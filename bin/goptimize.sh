#!/bin/bash
#### GOptimize by gu5t3r@XDA ####
GOVersion=1.27.06

#### CHECK FOR BINARIES ####
if [ ! -f /bin/.GOptimize ]; then
	for witch in TruePNG pngout DeflOpt zipalign basename dirname realpath wc find awk stat cat xargs sed grep chmod 7za nice sleep sort tr; do
		which "$witch" > /dev/null 2>&1
		if [ ${?} -ne 0 ]; then missing="$missing [$witch]"; fi
	done
	if [ -n "$missing" ]; then echo -e "\n[E] Missing binaries:$missing"; exit 1; fi
	unset missing
fi

#### USAGE ####
usage()
{
cat << EOF

######################[ GOptimize v${GOVersion} ]######################
--------------------------------------------------------------#
  usage: goptimize [options] *.apk                            #
###############################################################
  This script optimizes PNG's in APK using                    #
  TruePNG + PNGout / PNGZopfli + DeflOpt .:. by gu5t3r@XDA    #
###############################################################
 OPTIONS:                                                     #
  -h   Show Help                                              #
  -he  Show Help + Extra Help (also accepts -hh)              #
  -p   Optimize PNG's                                         #
  -m   MultiThreaded PNG optimizing [2-16]; forces -p         #
  -zz  Use PNGZopfli instead PNGout; Save few more kB at cost #
       of ~20% longer optimizing; multithreading recommended  #
  -zb  Use both PNGout + PNGZopfli for maximum saving at cost #
       of extra ~20% longer optimizing compared to PNGZopfli  #
  -j   Optimize JPG's using jpegoptim; [0] or [75-100]        #
  -a   Recompress resources.arsc with CL[0-6]                 #
  -d   Recompress classes.dex with CL[0-6]                    #
  -b   Remove debug info from classes.dex for API[1-19] using #
       baksmali/smali; -d[0-6] required; -d5 recommended      #
  -s   [1,2] Force smali v1 or v2 when removing debug info    #
  -l   Recompress libraries with CL[0-6]                      #
  -r   Recompress APK with  CL[0-6]                           #
  -R   [+,-] Smart Recompression modes, read extra help...    #
  -k   Keep only libraries for architecture: 1 armeabi        #
                                             2 armeabi-v7a    #
                                             3 mips           #
                                             4 mipso32        #
                                             5 x86            #
  -t  Sign APK with Android test certificate                  #
###############################################################
EOF
}

usagee()
{
cat << EOF
                         Extra Help                           #
--------------------------------------------------------------#
  Compression Levels:                                         #
      Script always uses 11 passes for compression which      #
      guarantees maximum compression and does not impact      #
      decompression time. Script CL differ in fast bytes.     #
          CL(1) <=>   4 fb        CL(4) <=>  32 fb            #
          CL(2) <=>   8 fb        CL(5) <=>  64 fb            #
          CL(3) <=>  16 fb        CL(6) <=> 128 fb            #
      You can also enter custom fast bytes number to be used  #
      for compression by entering fb[3-258] instead CL.       #
      Examples:   -afb3   -dfb69   -lfb132   -rfb258          #
                                                              #
  JPG's optimization using jpegoptim                          #
      [0] is lossless optimization and recommended.           #
          It does not recompress jpg's, it just strips all    #
          unnecessary info and optimizes huffman coding.      #
      [75-100] optimizes and recompresses jpg's. Level 95 is  #
          recommended, it will recompress unnecessary big     #
          ones and do lossless optimization on other jpg's.   #
                                                              #
  APK Recompression (-r option):                              #
      As of v1.25 script uses Smart Recompressing i.e. it     #
      will leave files uncompressed in GOptimized apk that    #
      were uncompressed in original apk which is the best way #
      for recompressing.                                      #
      -R+ Script will use Smart Recompression plus it will    #
          never compress file formats from below list even if #
          they were compressed in original apk.               #
      -R- Script will disable Smart Recompress and store      #
          file formats uncompressed only if they are on below #
          list.                                               #
      Following Android Asset Packaging Tool rules following  #
      list of file formats:                                   #
       "jpg jpeg jpe jfif png gif wav mp2 mp3 ogg aac mpg     #
        mpeg mid midi smf jet rtttl imy xmf mp4 m4a m4v 3gp   #
        3gp 3gpp 3g2 3gpp2 amr awb wma wmv zip lzma xz 7z lua #
        pxp resS gltxt geo apf zi_"                           #
      should never be compressed as they are already          #
      compressed formats or don't compress well.              #
      Most developers use this file formats for databases and #
      compressing them would result with application errors.  #
                                                              #
  APK signing with Android test certificate                   #
      Non system apk's and apk's you want to install after    #
      goptimization are needed to be signed. You need Java    #
      configured for signing.                                 #
      Alternative is to patch rom (core.jar) with             #
      Lucky Patcher not to verify signatures.                 #
                                                              #
  Configure Java:                                             #
      To use -b feature for removing debugging info from      #
      classes.dex using smali you need to enter java bin path #
      in bin\.JavaPATH file which is usually                  #
      "C:\Program Files\Java\jre[version number]\bin"         #
                                                              #
  GOptimize.cmd Default Options:                              #
      You can edit GOptimize.cmd default options in           #
      bin\.GOptimize file.                                    #
      GOptimize.cmd default options are:                      #
                       "goptimize -m4 -j0 -a0 -d5 -l5 *.apk;" #
###############################################################
EOF
}


CLevel()
{
	case "$1" in
		1) echo '4';;
		2) echo '8';;
		3) echo '16';;
		4) echo '32';;
		5) echo '64';;
		6) echo '128';;
		*) 
			if [[ "$1" =~ ^fb[0-9]{1,3}$ ]]; then
				if [ "${1#fb}" -lt 3 ]; then
					echo '3'
				elif [ "${1#fb}" -gt 258 ]; then
					echo '258'
				else
					echo "${1#fb}"
				fi
			else
				echo '4'
			fi
		;;
	esac
}

COptions()
{
	if [ -z "$1" ] || [ "${1#fb}" -eq 0 ]; then
		echo 'a -tzip -mm=Copy -w.. -ssc- -y';
	else
		echo 'a -tzip -mm=Deflate -mx=9 -mfb='"$(CLevel $1)"' -mpass=11 -w.. -ssc- -y';
	fi
}

CCheck()
{
	if ! [[ "$1" =~ ^[0-6]$ || "$1" =~  ^fb[0-9]{1,3}$ && "${1#fb}" -ge 3 && "${1#fb}" -le 258 ]]; then
		return 0;
	else
		return 1;
	fi
}

#### GET OPTIONS ####
unset -v opt_h opt_p opt_m opt_z opt_a opt_r opt_l opt_d opt_k opt_b opt_s opt_t opt_j opt_R opt_e opt_E SMALI;
while getopts “h:pm:a:r:l:d:b:k:z:s:tj:R:e:E” OPTION 2>/dev/null
do
	case $OPTION in
		h)
			opt_h="$OPTARG"
			if [ "$opt_h" = "e" ] || [ "$opt_h" = "h" ]; then
				usage; usagee; exit 0;
			else
				usage; exit 0;
			fi
			;;
		p)
			opt_p=1;
			;;
		m)
			opt_m="$OPTARG"
			if ! [[ "$opt_m" =~ ^[2-9]$ ]] && ! [[ "$opt_m" =~ ^1[0-6]$ ]]; then
				usage; exit 1;
			fi
			opt_p=1;
			;;
		z)
			opt_z="$OPTARG"
			if [ "$opt_z" = 'o' ]; then opt_z='b'; fi
			if [ "$opt_z" != "z" ] && [ "$opt_z" != "b" ] || [ -z "$opt_p" ]; then usage; exit 1; fi
			if ! which "PNGZopfli" &>/dev/null || ! which "zopfli" &>/dev/null; then
				echo -e "\n[E] Missing binaries: PNGZopfli or zopfli"; exit 1;
			fi 
			;;
		a)
			opt_a="$OPTARG"
			if CCheck "$opt_a"; then usage; exit 1; fi
			;;
		r)
			opt_r="$OPTARG"
			if CCheck "$opt_r"; then usage; exit 1; fi
			;;
		l)
			opt_l="$OPTARG"
			if CCheck "$opt_l"; then usage; exit 1; fi
			;;
		d)
			opt_d="$OPTARG"
			if CCheck "$opt_d"; then usage; exit 1; fi
			;;
		k)
			opt_k="$OPTARG"
			if ! [[ "$opt_k" =~ ^[0-5]$ ]]; then
				usage; exit 1;
			fi
			;;
		b)
			opt_b="$OPTARG"
			if [[ ! "$opt_b" =~ ^[1-9]$ && ! "$opt_b" =~ ^1[0-9]$ || ! "$opt_d" ]]; then
				usage; exit 1;
			fi
			if [ -z "$SMALI" ]; then SMALI="smali"; fi
			if [ -z "$opt_s" ]; then opt_s='a'; fi
			;;
		s)
			opt_s="$OPTARG"
			if [ -z "$opt_b" ]; then opt_s=''; fi
			case "$opt_s" in
				1) SMALI_LIST='smali';;
				2) SMALI_LIST='smali2';;
				*) usage; exit 1;;
			esac
			;;
		t)
			opt_t=1;
			;;
		j)
			if ! which "jpegoptim" &>/dev/null; then echo -e "\n[E] Missing binaries: jpegoptim"; exit 1; fi
			opt_j="$OPTARG";
			if ! [[ "$opt_j" =~ ^[0-9]*$ ]] || [[ $opt_j -ne 0 && $opt_j -lt 75 || $opt_j -gt 100 ]]; then
				usage; exit 1;
			fi
			;;
		R)
			opt_R="$OPTARG";
			if [ "$opt_R" != '-' ] && [ "$opt_R" != '+' ] || [ -z "$opt_r" ]; then
				usage; exit 1;
			fi
			;;
		e)
			opt_e="$OPTARG";
			if [ "$opt_e" = '-' ]; then :;
			elif [ -z "$opt_e" ] || [[ ! "$opt_e" =~ ^[a-zA-Z\ ]*$ ]] || [ -n "$(echo "$opt_e" | sed -e 's/ \?[[:alpha:]]\{2\} \?//gI')" ]; then
				usage; exit 1;
			else
				opt_e="$(echo -n "$opt_e" | sed -e 's/./\L&/g')"
			fi
			;;
		E)
			opt_E=1;
			;;
		?)
			usage; exit 1;
			;;
	esac
done

nice='nice'$'\n''-n19';

OP_progress()
{
	case "$(($1%4))" in
		0) echo '-';;
		1) echo '\';;
		2) echo '|';;
		3) echo '/';;
	esac
}


PZopfli()
{
	${nice} PNGZopfli "${1}" "${2}" "${1}z0pfl1" > /dev/null
	if [ "$(stat -c%s "${1}z0pfl1")" -lt "$(stat -c%s "${1}")" ]; then
		mv -f "${1}z0pfl1" "${1}"
	else
		rm -f "${1}z0pfl1"
	fi
}


GOptimize()
{
	#### DIRECTORY MAGIC ####
	OPWD="$PWD"
	DIR="`realpath \`dirname "$1"\``"
	APK="`basename "$1"`"

	##APK="${APK%.*}.apk"

	#### START GOPTIMIZE ####
	cd "$DIR"
	if [ -n "$APK" ] && [ -f "$APK" ]; then
		echo ""
		#### CHECK IF APK IS PROPER ####
		7za l -tzip "$APK" > /dev/null 2>&1
		if [ ${?} -ne 0 ]; then
			echo "[E] <[ $APK ]> is NOT zip compatible archive"'!!!';
			return 1;
		fi
		echo "[+] GOptimizing: <[ $APK ]>"
		GOCHECK="`7za l -tzip "$APK" 2>/dev/null | sed -n 's/^[ \t]\+[0-9]\+[ \t]\+[0-9]\+[ \t]\+\([0-9]\+\)[ \t].*[ \t]\([0-9]\+\)[ \t].*/\1_\2/gp'`"
		
		if [ -d ".go[${APK%.*}]" ]; then rm -rf ".go[${APK%.*}]" 2>/dev/null; fi
		mkdir -m 777 -p ".go[${APK%.*}]/GOApk";
		cd ".go[${APK%.*}]"
		GOTemp_zip='GOTemp.apk';
		cp -f "../$APK" "GOTemp.apk";
		if [ $? -ne 0 ]; then echo -e '\n[E] File operation errors!!!'; exit 1; fi
		
		
		
		
		#### REMOVE UNNEEDED LANGUAGES FROM RESOURCES USING APKTOOL ####
		if [ -n "$opt_e" ]; then
			echo -n ' |- Cleaning resources of unneeded languages...';
			if java -version &>/dev/null && [ "$(java -version 2>&1) | grep 'java version')" ]; then
				echo '';
				if [ -d "../framework" ]; then
					echo ' |  +- Setting up frameworks...'
					find "../framework/" -maxdepth 1 -mindepth 1 -type f -iname '*.apk' -exec apktool if -p GOATif "{}" \; &>/dev/null;
					echo -n ' |  |- ';
				else
					echo -n ' |  +- ';
				fi
				echo -n 'Running disassemble test...: '
				if apktool d -a "$(cygpath -wal /bin/aapt.exe)" -s -p GOATif -o GOATool GOTemp.apk &>disassemble.log; then
					echo 'Success!';
					echo -n ' |  |- Running assemble test......: '
					apktool b -a "$(cygpath -wal /bin/aapt.exe)" -p GOATif -o GOATool.apk GOATool &>assemble.log;
					if [ -f 'GOATool/build/apk/resources.arsc' ] && [ -d 'GOATool/build/apk/res' ] && [ -f 'GOATool.apk' ]; then
						rm -rf 'GOATool/build'; rm -r 'GOATool.apk';
						echo 'Success!';
						if [ "$opt_e" != "-" ]; then for each in $opt_e; do exclude_lang="$exclude_lang"'\|'"$each"; done; fi
						req_lang="$(sed -ne 's#^aapt: warning: string .*; found: \([[:alpha:][:space:]]\+\)#\1#pI' assemble.log | sed -e 's/\([[:alpha:]]\{2\}\)_[[:alpha:]]\+/\1/gI' | awk '{ j=0; for(i=1;i<=NF;i++){ if( $i ~ /^[[:alpha:]]{2}$/ ){if(j==0)print " "; else printf " "; printf $i; j++} } }')";
						if [ -n "req_lang" ]; then
							#### DOH, Detect UnNeeded Languages ####
							min_field="$(echo "$req_lang" |  awk '{if (NF<i || i==0)i=NF;} END{print i}')";
							min_lang="$(echo "$req_lang" | sort -uf | awk '{ if (NF=='$min_field') for(i=1;i<=NF;i++) print $i}' | sort -uf | awk '{printf $0 " "}')"
							req_lang="$(echo "$req_lang" | sed -e 's/.*\(en'"$exclude_lang"'\).*/\1/I' | sort -uf)"
							i=0; for each in $min_lang; do if [ $i -eq 0 ]; then min_lang="$each"; else min_lang="$min_lang"'\|'"$each"; fi; i=1; done
							req_lang="$(echo "$req_lang" | sed -e 's/.*\('"$min_lang"'\).*/\1/I' | sort -uf)"
							min_lang="$(echo "$req_lang" | awk '{if($1 != "" )printf $1 " "}')"
							i=0; for each in $min_lang; do if [ $i -eq 0 ]; then min_lang="$each"; else min_lang="$min_lang"'\|'"$each"; fi; i=1; done
							req_lang="$(echo "$req_lang" | sed -e 's/.*\('"$min_lang"'\).*/\1/I' | sort -uf | awk '{if($1 != "" )printf $1 " "}')"
						fi
						
						if [ "$req_lang" ]; then echo " |  |- Detected required languages: $req_lang"; fi
						for each in $req_lang; do exclude_lang="$exclude_lang"'\|'"$each"; done
							removable_lang="$(find ./GOATool/res/ -maxdepth 1 -mindepth 1 -type d -regextype sed -iregex '\./.*/res/values-[[:alpha:]]\{2\}\(-[[:alpha:]]\+\)\?' -not -iregex '\./.*/res/values-\(sw\|en'$exclude_lang'\)\(-[[:alpha:]]\+\)\?' | sed -ne 's#.*/res/values-\([[:alpha:]]\{2\}\)\(-[[:alpha:]]\+\)\?#\1#Ip' | sort -uf)";
						if [ -n "$removable_lang" ]; then
							mkdir -p -m 777 GOATresb; e1=''; e2=''; e3=''; i=0;
							for each in $removable_lang; do 
								echo -ne "\r |  |- Removing unneeded languages: ${each}${e1}${e2}${e3}"; e2="$e1"; e1=" $each"; if [ $i -eq 0 ]; then e3=' []o:'; i=1; else e3='[ ]o:'; i=0; fi;
								mv -f ./GOATool/res/values-${each} ./GOATresb/ &>/dev/null
								mv -f ./GOATool/res/values-${each}-* ./GOATresb/ &>/dev/null
								mv -f ./GOATool/res/values-*-${each} ./GOATresb/ &>/dev/null
								mv -f ./GOATool/res/values-*-${each}-* ./GOATresb/ &>/dev/null
								mv -f ./GOATool/res/raw-${each} ./GOATresb/ &>/dev/null
								mv -f ./GOATool/res/raw-${each}-* ./GOATresb/ &>/dev/null
								mv -f ./GOATool/res/xml-${each} ./GOATresb/ &>/dev/null
								mv -f ./GOATool/res/xml-${each}-* ./GOATresb/ &>/dev/null
								mv -f ./GOATool/res/drawable-${each}-* ./GOATresb/ &>/dev/null
								
							done
							echo -e '\r |  |- Removing unneeded languages: Success!     ';
							echo -n ' |  +- Attempting to assemble APK.: ';
							apktool b -a "$(cygpath -wal /bin/aapt.exe)" -p GOATif -o GOATool.apk GOATool &>assemble2.log;
							if [ -f 'GOATool/build/apk/resources.arsc' ] && [ -d 'GOATool/build/apk/res' ] && [ -f 'GOATool.apk' ]; then
								echo 'Success!';
								cd 'GOATool/build/apk';
								find 'res' -type f -not \( -iname '*.png' -or -iname '*.xml' \) > ../files_list
								7za l "../../../GOTemp.apk" | sed -ne 's/.*[ \t]\+\([0-9]\+\)[ \t]\+\([0-9]\+\)[ \t]\+/\1|\2|/p' | awk -F '|' 'BEGIN{IGNORECASE = 1} { if ( $1 == $2 && $2 != 0 && $3 !~ /.*\.png$/ ) print $3 }' > ../store_list
								7za d -y -ssc- -tzip -i'!res' "../../../GOTemp.apk" >/dev/null
								7za a -y -ssc- -tzip -mpass=11 -mfb=32 -i'!resources.arsc' -ir'!*.*' -i@../files_list -x@../store_list -xr'!*.png' -x'!AndroidManifest.xml' -x'!lib' -x'!classes.dex' "../../../GOTemp.apk" >/dev/null
								7za a -y -ssc- -tzip -mm=Copy -ir'!*.png' -i@../store_list "../../../GOTemp.apk" >/dev/null
								cd '../../../';
								GOCHECK="`7za l -tzip "GOTemp.apk" 2>/dev/null | sed -n 's/^[ \t]\+[0-9]\+[ \t]\+[0-9]\+[ \t]\+\([0-9]\+\)[ \t].*[ \t]\([0-9]\+\)[ \t].*/\1_\2/gp'`"
							else
								echo -e 'Failed!\r[w] +'
							fi
						else
							echo ' |  +- No removable lang. found...: Skipping!'
						fi
					else
						echo -e 'Failed!\r[w] +'
					fi
				else
					echo -e 'Failed!\r[w] +'
				fi
				if [ -n "$opt_E" ]; then read -sn1; fi
				if [ -d "GOATool" ]; then rm -rf "GOATool"; fi
				if [ -d "GOATif" ]; then rm -rf "GOATif"; fi
				if [ -d "GOATresb" ]; then rm -rf "GOATresb"; fi
				if [ -f "GOATool.apk" ]; then rm -rf "GOATool.apk"; fi
			else
				echo "[E] Cleaning resources FAILED: Java not properly configured"
			fi
		fi
		
		
		
		
		#### EXTRACT IF NEEDED ####
		if [ "$opt_r" ] || [ "$opt_p" ] || [ "$opt_a" ] || [ "$opt_d" ] || [ "$opt_l" ] || [ "$opt_j" ]; then
			echo " |- Extracting APK..."
			cd "GOApk";
			if [ "$opt_r" ]; then
				7za x -ssc- -y -xr\!META-INF -xr\!AndroidManifest.xml "../GOTemp.apk" > /dev/null
			else
				if [ "$opt_p" ]; then 7za x -ssc- -y -ir\!*.png -xr\!*.9.png "../GOTemp.apk" > /dev/null; fi
				if [ "$opt_a" ]; then 7za x -ssc- -y -i\!resources.arsc "../GOTemp.apk" > /dev/null; fi
				if [ "$opt_d" ]; then 7za x -ssc- -y -i\!classes.dex "../GOTemp.apk" > /dev/null; fi
				if [ "$opt_l" ]; then 7za x -ssc- -y -i\!lib "../GOTemp.apk" > /dev/null; fi
				if [ "$opt_j" ]; then 7za x -ssc- -y -ir\!*.jpg -ir\!*.jpeg -ir\!*.jpe -ir\!*.jfif "../GOTemp.apk" > /dev/null; fi
			fi
			chmod -R 777 '.'
			Apk_Was_Extracted='1';
		else
			Apk_Was_Extracted='';
		fi


		#### OPTIMIZE PNG'S ####
		if [ "$opt_p" ]; then
			PNGLIST="`find . -type f -iname '*.png' -not -iname '*.9.png'`";
			if [ -z "$PNGLIST" ]; then
				echo -e " |- NO PNG's in APK detected"
			else
				nof="`echo "$PNGLIST" | wc -l`";
				sync > /dev/null 2>&1;
				size_before="`echo "$PNGLIST" | xargs -rI "{}" stat -c%s "{}" 2>/dev/null | awk '{ PNGSIZE += \$1 } END { print PNGSIZE }'`"
				i=0; mi=0; SIFS="$IFS"; IFS=$'\n'; unset MTPPID;
				for PNG in $PNGLIST; do
					if [ -n "$opt_m" ]; then
						{
							${nice} TruePNG /o max "$PNG" > /dev/null 2>&1;
							if [ ${?} -eq 0 ]; then
								if [ "$opt_z" != "z" ]; then ${nice} pngout /ks /f6 "$PNG" > /dev/null; fi
								if [ "$opt_z" ]; then PZopfli "$PNG" "15"; fi
								${nice} DeflOpt "$PNG" > /dev/null;
							fi
						} & MTPPID="${MTPPID}${!}"$'\n'; let mi++;
						wi=0;
						while [ "$mi" -ge "$opt_m" ]; do
							if [ "$wi" -ge 1 ]; then sleep "0.${wi}"; fi
							if [ "$wi" -lt 9 ]; then let wi++; fi
							for EMTPPID in $MTPPID; do
								if kill -0 "$EMTPPID" 2>/dev/null; then
									NMTPPID="${NMTPPID}${EMTPPID}"$'\n';
								else
									let mi--;
								fi
							done
							MTPPID="$NMTPPID"; NMTPPID='';
						done
					else
						${nice} TruePNG /o max "$PNG" > /dev/null 2>&1;
						if [ ${?} -eq 0 ]; then
							if [ "$opt_z" != "z" ]; then ${nice} pngout /ks /f6 "$PNG" > /dev/null; fi
							if [ "$opt_z" ]; then PZopfli "$PNG" "15"; fi
							${nice} DeflOpt "$PNG" > /dev/null;
						fi
					fi
					let i++; opp="$(($i*100/$nof))";
					echo -en "\r[$(OP_progress $opp)] Optimizing PNG's: $opp%";
				done
				if [ -n "$MTPPID" ]; then for EMTPPID in $MTPPID; do wait $EMTPPID; done; unset MTPPID; fi
				IFS="$SIFS";
				####ps -a | grep -i "TruePNG\|pngout\|DeflOpt"
				sync > /dev/null 2>&1;
				sleep 1;
				size_after="`echo "$PNGLIST" | xargs -rI "{}" stat -c%s "{}" 2>/dev/null | awk '{ PNGSIZE += \$1 } END { print PNGSIZE }'`"
				let size_before+=0; if [ "$size_before" -eq 0 ]; then size_before=1; size_after=1; fi
				echo -e "\r |- Optimized PNG's: 100% | Saved: $((($size_before-$size_after)/1024)) kB ($((($size_before-$size_after)*100/$size_before))%)"
				#echo " |- Packing PNG's in APK..."
				7za $(COptions) -ir\!*.png -xr\!*.9.png "../GOTemp.apk" > /dev/null
			fi
			unset PNGLIST PNG size_before size_after;
		fi


		#### OPTIMIZE JPG'S ####
		if [ "$opt_j" ]; then
			JPGLIST="`find . -type f \( -iname '*.jpg' -or -iname '*.jpeg' -or -iname '*.jpe' -or -iname '*.jfif' \)`"
			if [ -z "$JPGLIST" ]; then
				echo -e " |- NO JPG's in APK detected"
			else
				nof="`echo "$JPGLIST" | wc -l`";
				sync > /dev/null 2>&1;
				size_before="`echo "$JPGLIST" | xargs -rI "{}" stat -c%s "{}" 2>/dev/null | awk '{ JPGSIZE += \$1 } END { print JPGSIZE }'`"
				i=0; SIFS="$IFS"; IFS=$'\n';
				for JPG in $JPGLIST; do
					jpegoptim --strip-all "$JPG" > /dev/null 2>&1
					if [ $opt_j -ne 0 ]; then
						jpegoptim --strip-all --max=${opt_j} "$JPG" > /dev/null 2>&1
					fi
					let i++; opp="$(($i*100/$nof))";
					echo -en "\r[$(OP_progress $opp)] Optimizing JPG's: $opp%";
				done
				IFS="$SIFS";
				sync > /dev/null 2>&1;
				sleep 1;
				size_after="`echo "$JPGLIST" | xargs -rI "{}" stat -c%s "{}" 2>/dev/null | awk '{ JPGSIZE += \$1 } END { print JPGSIZE }'`"
				let size_before+=0; if [ "$size_before" -eq 0 ]; then size_before=1; size_after=1; fi
				echo -e "\r |- Optimized JPG's: 100% | Saved: $((($size_before-$size_after)/1024)) kB ($((($size_before-$size_after)*100/$size_before))%)"
				#echo " |- Packing JPG's in APK..."
				7za $(COptions) -ir\!*.jpg -ir\!*.jpeg -ir\!*.jpe -ir\!*.jfif "../GOTemp.apk" > /dev/null
			fi
			unset JPGLIST JPG size_before size_after;
		fi


		#### STORE/RECOMPRESS RESOURCES.ARSC ####
		if [ "$opt_a" ]; then
			if [ -f "resources.arsc" ]; then
				if [ "${opt_a#fb}" -eq 0 ]; then
					echo " |- Storing resources.arsc uncompressed";
				else
					echo " |- Recompressing resources.arsc with CL($opt_a)";
				fi
				7za $(COptions $opt_a) "../GOTemp.apk" "resources.arsc" > /dev/null
			else
				echo " |- NO resources.arsc in APK detected"
			fi
		fi

		#### RECOMPRESS CLASSES.DEX / REMOVE DEBUGGING INFO ####
		if [ "$opt_d" ]; then
			if [ -f "classes.dex" ]; then
				if [ "$opt_b" ]; then
					if java -version &>/dev/null && [ "$(java -version 2>&1) | grep 'java version')" ]; then
					
						if [ -z "$SMALI_LIST" ]; then SMALI_LIST='smali smali2 smali'; fi
						
						j=0; for SMALI in $SMALI_LIST; do let j++; done
						
						i=0;
						for SMALI in $SMALI_LIST; do
							if [ -d "../smali" ]; then rm -rf ../smali; fi
							if [ $i -eq 0 ]; then
								echo -n " |- Removing debug info using smali v$($SMALI --version | awk '{ if (NR == 1) print $2}'): "
							else
								echo -n " |  +- Trying to remove using smali v$($SMALI --version | awk '{ if (NR == 1) print $2}'): "
							fi
							if [ -f /bin/bak$SMALI ] && [ -f /bin/$SMALI ] &&  [ -f /bin/bak${SMALI}.jar ] && [ -f /bin/${SMALI}.jar ] \
							  && [ ! "$(bak$SMALI -x -b -a${opt_b} -o ../smali classes.dex 2>&1)" ] && [ ! "$($SMALI -a${opt_b} -o ../GOclass.dex ../smali 2>&1)" ]; then
								if [ "$(stat -c%s "../GOclass.dex")" -lt "$(stat -c%s "classes.dex")" ]; then
									rm -f classes.dex; mv -f ../GOclass.dex classes.dex;
									echo 'Success!';
									if [ $i -ne 0 ]; then continue $(($j-$i-1)); fi; break;
								else
									echo 'Already removed!';
									if [ -f "../GOclass.dex" ]; then rm -f ../GOclass.dex; fi
									break;
								fi
							else
								echo -n 'Failed!'; echo -e '\r[w]';
								if [ -f "../GOclass.dex" ]; then rm -f ../GOclass.dex; fi
								let i++;
								if [ $(($i+1)) -ge $j ]; then break; fi
							fi
						done
						if [ -d "../smali" ]; then rm -rf ../smali; fi
						
						
					else
						echo "[E] Removing debugging info FAILED: Java not properly configured"
					fi
				fi
			
				if [ "${opt_d#fb}" -eq 0 ]; then
					echo " |- Storing classes.dex uncompressed";
				else
					echo " |- Recompressing classes.dex with CL($opt_d)";
				fi
				7za $(COptions $opt_d) "../GOTemp.apk" "classes.dex" > /dev/null
			else
				echo " |- NO classes.dex in APK detected"
			fi
		fi

		#### RECOMPRESS LIBRARIES ####
		if [ "$opt_l" ]; then
			if [ -d "lib" ]; then
				if [ "${opt_l#fb}" -eq 0 ]; then
					echo " |- Storing libraries uncompressed";
				else
					echo " |- Recompressing libraries with CL($opt_l)";
				fi
				7za $(COptions $opt_l) -i\!lib/*/*.* "../GOTemp.apk" > /dev/null
			else
				echo " |- NO libraries in APK detected"
			fi
		fi

		#### RECOMPRESS APK ####
		if [ "$opt_r" ]; then
			echo " |- Recompressing APK with CL($opt_r)"
			if [ "$opt_a" ]; then resources_arsc='-x!resources.arsc'; else resources_arsc=''; fi
			if [ "$opt_d" ]; then classes_dex='-x!classes.dex'; else classes_dex=''; fi
			if [ "$opt_l" ]; then libraries='-x!lib'; else libraries=''; fi
			if [ "$opt_p" ]; then png_files=''; else png_files='-ir!*.png'; fi
			if [ "$opt_j" ]; then jpg_files=''; else jpg_files='-ir!*.jpg -ir!*.jpeg -ir!*.jpe -ir!*.jfif'; fi
			
			x_copy_list=' '; i_copy_list=' ';
			if [ "$opt_R" = "-" ] || [ "$opt_R" = "+" ]; then
				r_copy_list='9.png gif wav mp2 mp3 ogg aac mpg mpeg mid midi smf jet rtttl imy xmf mp4 m4a m4v 3gp 3gpp 3g2 3gpp2 amr awb wma wmv zip lzma xz 7z lua pxp resS gltxt geo apf zi_';
				for ext in ${r_copy_list}; do x_copy_list="${x_copy_list}"'-xr!*.'"${ext} "; i_copy_list="${i_copy_list}"'-ir!*.'"${ext} "; done
			fi
			store_list='';
			if [ -z "$opt_R" ] || [ "$opt_R" = "+" ]; then
				7za l "../GOTemp.apk" | sed -ne 's/.*[ \t]\+\([0-9]\+\)[ \t]\+\([0-9]\+\)[ \t]\+/\1|\2|/p' | awk -F '|' 'BEGIN{IGNORECASE = 1} { if ( $1 == $2 && $2 != 0 && $3 !~ /.*\.(png|jpg|jpeg|jpe|jfif)$/ ) print $3 }' > ../store_list
				if [ -s '../store_list' ]; then store_list='-x@../store_list'; fi
			fi
			
			find '.' -type f -not -iname '*.*' | sed -n 's#^\./##p' > ../noex_list
			if [ -s '../noex_list' ]; then noex_list='-i@../noex_list'; else noex_list=''; fi
			
			nice -n19 7za $(COptions $opt_r) -ir\!*.* ${noex_list} ${resources_arsc} ${classes_dex} ${libraries} ${store_list} -xr\!*.png -xr\!*.jpg -xr\!*.jpeg -xr\!*.jpe -xr\!*.jfif ${x_copy_list} "../GOTemp.apk" > /dev/null
			7za $(COptions) ${i_copy_list} ${png_files} ${jpg_files} "../GOTemp.apk" > /dev/null
			unset -v i_copy_list x_copy_list r_copy_list store_list
		fi


		if [ "$Apk_Was_Extracted" ]; then cd '..'; fi

		#### Check All Files Are In APK####
		if [ "$GOCHECK" != "`7za l -tzip "GOTemp.apk" 2>/dev/null | sed -n 's/^[ \t]\+[0-9]\+[ \t]\+[0-9]\+[ \t]\+\([0-9]\+\)[ \t].*[ \t]\([0-9]\+\)[ \t].*/\1_\2/gp'`" ]; then
			echo "[E] <[ $APK ]> CORRUPTED during GOptimization"'!!!'
		fi

		#### KEEP ONLY SELECTED LIBRARIES ####
		if [ "$opt_k" ]; then
			lib_test="`7za l -i\!lib/* "GOTemp.apk" | sed -n 's#^.*[\t ]lib/\([[:alnum:]-]\+\)/.*$#\1#gp' |  awk '!x[$0]++'`";
			
			case "$opt_k" in
				1)
					lib_keep="armeabi";
				;;
				2)
					lib_keep="armeabi-v7a"
					if [ ! "`echo "$lib_test" | grep -x "$lib_keep"`" ]; then
						lib_keep="armeabi";
					fi
				;;
				3)
					lib_keep="mips";
				;;
				4)
					lib_keep="mipso32"
					if [ ! "`echo "$lib_test" | grep -x "$lib_keep"`" ]; then
						lib_keep="mips";
					fi
				;;
				5)
					lib_keep="x86";
				;;
			esac
			
			lib_remove="`echo "${lib_test}" | grep -xv "${lib_keep}"`"
			if [ -n "$lib_remove" ]; then
				echo -n " |- Removing libraries for: "; echo -n "$lib_remove" | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/, /g'; echo "";
				7za d -tzip -i\!"lib/*" -x\!"lib/${lib_keep}/*" "GOTemp.apk" > /dev/null
			else
				echo " |- NO libraries to remove..."
			fi
			if [ "`echo -n "$lib_test" | grep -x "$lib_keep"`" ]; then
				echo " |  + Keeping for: [${lib_keep}]"
			fi
		fi

		#### SIGN APK WITH ANDROID TEST CERTIFICATE ####
		if [ -n "$opt_t" ]; then
			echo " |- Signing APK with Android test certificate"
			java -version > /dev/null 2>&1;
			if [ ${?} -eq 0 ] && [ "$(java -version 2>&1) | grep 'java version')" ] &&  [ -f /bin/sign ] && [ -f /bin/sign.jar ]; then
				sign --override "GOTemp.apk"
			else
				echo "[E] Failed: Java not properly configured"
			fi
		fi

		#### ZIPALIGN ####
		echo " +- Zipaligning APK..."
		zipalign -f 4 "GOTemp.apk" "GOZipa.apk" 2>&1 1>/dev/null | grep -vi 'WARNING: header mismatch';
		mv -f "GOZipa.apk" "../$APK"
		if [ $? -ne 0 ]; then echo -e '\n[E] File operation errors!!!'; exit 1; fi
		cd '..';
		## read -sn1;
		rm -rf ".go[${APK%.*}]" 2>/dev/null;

		cd "$OPWD"
		return 0;
	else
		cd "$OPWD"
		if [ -n "$APK" ]; then echo -e "\n[E] <[ $APK ]> does not exist"'!!!'; fi
		return 1;
	fi
}

if [ -z "$*" ]; then usage; exit 0; fi

#### APK LIST LOOP ####
argumentsc=0
apkscount=0
for APK in "$@"; do
	let argumentsc=argumentsc+1
	if [ $argumentsc -lt $OPTIND ]; then continue; fi
	GOptimize "$APK" && let apkscount=apkscount+1
done

if [ $apkscount -eq 0 ]; then usage; exit 1; fi

