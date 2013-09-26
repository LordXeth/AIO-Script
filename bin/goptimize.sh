#!/bin/bash
#### GOptimize by gu5t3r@XDA ####
GOVersion=1.23

#### CHECK FOR BINARIES ####
if [ ! -f /bin/.GOptimize ]; then
	for witch in TruePNG pngout DeflOpt zipalign basename dirname realpath wc find awk stat cat xargs sed grep chmod 7za nice sleep; do
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
  -b   Remove debug info from classes.dex for API[1-17] using #
       baksmali/smali; -d[0-6] required; -d5 recommended      #
  -s2  Use smali/baksmali v2.0b5 for removing debuging info   #
  -l   Recompress libraries with CL[0-6]                      #
  -r   Recompress APK with  CL[0-6]                           #
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
      Script always uses 16 passes for compression which      #
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
      Following Android Asset Packaging Tool rules files with #
      extensions:                                             #
       "jpg, jpeg, png, gif, wav, mp2, mp3, ogg, aac, mpg,    #
        mpeg, mid, midi, smf, jet, rtttl, imy, xmf, mp4, m4a, #
        m4v, 3gp, 3gpp, 3g2, 3gpp2, amr, awb, wma, wmv, zip,  #
        lzma" will never be compressed as they are already    #
      compressed formats or don't compress well.              #
      Most developers use this extensions for databases and   #
      compressing them would result in application ForceClose #
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


CL()
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

#### GET OPTIONS ####
unset -v opt_h opt_p opt_m opt_z opt_a opt_r opt_l opt_d opt_k opt_b opt_s opt_t opt_j SMALI BAKSMALI;
while getopts “h:pm:a:r:l:d:b:k:z:s:tj:” OPTION 2>/dev/null
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
			if [ -z "$opt_p" ]; then usage; exit 1; fi
			if [ "$opt_z" != "z" ] && [ "$opt_z" != "b" ]; then usage; exit 1; fi
			which "PNGZopfli" > /dev/null 2>&1; if [ ${?} -ne 0 ]; then usage; exit 1; fi
			which "zopfli" > /dev/null 2>&1; if [ ${?} -ne 0 ]; then usage; exit 1; fi
			;;
		a)
			opt_a="$OPTARG"
			if ! [[ "$opt_a" =~ ^[0-6]$ || "$opt_a" =~  ^fb[0-9]{1,3}$ ]]; then
				usage; exit 1;
			fi
			;;
		r)
			opt_r="$OPTARG"
			if ! [[ "$opt_r" =~ ^[0-6]$ || "$opt_r" =~  ^fb[0-9]{1,3}$ ]]; then
				usage; exit 1;
			fi
			;;
		l)
			opt_l="$OPTARG"
			if ! [[ "$opt_l" =~ ^[0-6]$ || "$opt_l" =~  ^fb[0-9]{1,3}$ ]]; then
				usage; exit 1;
			fi
			;;
		d)
			opt_d="$OPTARG"
			if ! [[ "$opt_d" =~ ^[0-6]$ || "$opt_d" =~  ^fb[0-9]{1,3}$ ]]; then
				usage; exit 1;
			fi
			;;
		k)
			opt_k="$OPTARG"
			if ! [[ "$opt_k" =~ ^[0-5]$ ]]; then
				usage; exit 1;
			fi
			;;
		b)
			opt_b="$OPTARG"
			if [[ ! "$opt_b" =~ ^[1-9]$ && ! "$opt_b" =~ ^1[0-7]$ || ! "$opt_d" ]]; then
				usage; exit 1;
			fi
			if [ -z "$SMALI" ] || [ -z "$BAKSMALI" ]; then
				SMALI="smali";
				BAKSMALI="baksmali";
			fi
			;;
		s)
			opt_s="$OPTARG"
			if [ -n "$opt_b" ] && [ "$opt_s" = "2" ] ; then
				SMALI="smali2";
				BAKSMALI="baksmali2";
			elif [ -n "$opt_b" ] && [ "$opt_s" = "1" ]; then
				SMALI="smali";
				BAKSMALI="baksmali";
			else
				usage; exit 1;
			fi
			;;
		t)
			opt_t=1;
			;;
		j)
			opt_j="$OPTARG"
			if ! [[ "$opt_j" =~ ^[0-9]*$ ]] || [[ $opt_j -ne 0 && $opt_j -lt 75 || $opt_j -gt 100 ]]; then
				usage; exit 1;
			fi
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

		#### EXTRACT IF NEEDED ####
		if [ "$opt_r" ]; then
			echo " |- Extracting APK..."
			rm -rf ".go[${APK%.*}]" 2>/dev/null
			mkdir -m 777 -p ".go[${APK%.*}]"
			7za x -ssc- -y -xr\!META-INF -xr\!AndroidManifest.xml -o".go[${APK%.*}]" "$APK" > /dev/null
			cd ".go[${APK%.*}]"
			chmod -R 777 *
		elif [ "$opt_p" ] || [ "$opt_a" ] || [ "$opt_d" ] || [ "$opt_l" ] || [ "$opt_j" ]; then
			echo " |- Extracting APK..."
			rm -rf ".go[${APK%.*}]" 2>/dev/null
			mkdir -m 777 -p ".go[${APK%.*}]"
			if [ "$opt_p" ]; then 7za x -ssc- -y -ir\!*.png -xr\!*.9.png -o".go[${APK%.*}]" "$APK" > /dev/null; fi
			if [ "$opt_a" ]; then 7za x -ssc- -y -i\!resources.arsc -o".go[${APK%.*}]" "$APK" > /dev/null; fi
			if [ "$opt_d" ]; then 7za x -ssc- -y -i\!classes.dex -o".go[${APK%.*}]" "$APK" > /dev/null; fi
			if [ "$opt_l" ]; then 7za x -ssc- -y -i\!lib -o".go[${APK%.*}]" "$APK" > /dev/null; fi
			if [ "$opt_j" ]; then 7za x -ssc- -y -ir\!*.jpg -ir\!*.jpeg -o".go[${APK%.*}]" "$APK" > /dev/null; fi
			cd ".go[${APK%.*}]"
			chmod -R 777 * &>/dev/null
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
				7za a -tzip -mm=Copy -ssc- -y -ir\!*.png -xr\!*.9.png "../$APK" > /dev/null
			fi
			unset PNGLIST PNG size_before size_after;
		fi


		#### OPTIMIZE JPG'S ####
		if [ "$opt_j" ]; then
			JPGLIST="`find . -type f \( -iname '*.jpg' -or -iname '*.jpeg' \)`"
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
				7za a -tzip -mm=Copy -ssc- -y -ir\!*.jpg -ir\!*.jpeg "../$APK" > /dev/null
			fi
			unset JPGLIST JPG size_before size_after;
		fi


		#### STORE/RECOMPRESS RESOURCES.ARSC ####
		if [ "$opt_a" ]; then
			if [ -f "resources.arsc" ]; then
				if [ "${opt_a#fb}" -eq 0 ]; then
					echo " |- Storing resources.arsc uncompressed"
					7za a -tzip -mm=Copy -ssc- -y "../$APK" "resources.arsc" > /dev/null
				else
					echo " |- Recompressing resources.arsc with CL($opt_a)"
					7za a -tzip -mm=Deflate -mfb=$(CL ${opt_a}) -mpass=16 -ssc- -y "../$APK" "resources.arsc" > /dev/null
				fi
			else
				echo " |- NO resources.arsc in APK detected"
			fi
		fi

		#### RECOMPRESS CLASSES.DEX / REMOVE DEBUGGING INFO ####
		if [ "$opt_d" ]; then
			if [ -f "classes.dex" ]; then
				if [ "$opt_b" ]; then
					echo " |- Removing debugging info from classes.dex using ${SMALI}"
					unset RDIF; java -version > /dev/null 2>&1;
					if [ ${?} -eq 0 ] && [ "$(java -version 2>&1) | grep 'java version')" ] &&  [ -f /bin/$BAKSMALI ] && [ -f /bin/$SMALI ] &&  [ -f /bin/${BAKSMALI}.jar ] && [ -f /bin/${SMALI}.jar ]; then
						if [ ! "$($BAKSMALI -x -b -a${opt_b} -o .smali classes.dex 2>&1)" ]; then
							if [ "$($SMALI -a${opt_b} -o classesGO.dex .smali 2>&1)" ]; then RDIF=1; fi
						else
							RDIF=1;
						fi
						if [ -d ".smali" ]; then rm -rf .smali; fi
						if [ "$RDIF" ]; then
							echo "[w] Failed Removing debugging info..."
							if [ -f "classesGO.dex" ]; then rm -f classesGO.dex; fi
						else
							rm -f classes.dex; mv -f classesGO.dex classes.dex
						fi
					else
						echo "[E] Failed: Java not properly configured"
					fi
				fi
			
				if [ "${opt_d#fb}" -eq 0 ]; then
					echo " |- Storing classes.dex uncompressed"
					7za a -tzip -mm=Copy -ssc- -y "../$APK" "classes.dex" > /dev/null
				else
					echo " |- Recompressing classes.dex with CL($opt_d)"
					7za a -tzip -mm=Deflate -mfb=$(CL ${opt_d}) -mpass=16 -ssc- -y "../$APK" "classes.dex" > /dev/null
				fi
			else
				echo " |- NO classes.dex in APK detected"
			fi
		fi

		#### RECOMPRESS LIBRARIES ####
		if [ "$opt_l" ]; then
			if [ -d "lib" ]; then
				if [ "${opt_l#fb}" -eq 0 ]; then
					echo " |- Storing libraries uncompressed"
					7za a -tzip -mm=Copy -ssc- -y -i\!lib/*/*.* "../$APK" > /dev/null
				else
					echo " |- Recompressing libraries with CL($opt_l)"
					7za a -tzip -mm=Deflate -mfb=$(CL ${opt_l}) -mpass=16 -ssc- -y -i\!lib/*/*.* "../$APK" > /dev/null
				fi
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
			if [ "$opt_j" ]; then jpg_files=''; else jpg_files='-ir!*.jpg -ir!*.jpeg'; fi
			
			r_copy_list='9.png gif wav mp2 mp3 ogg aac mpg mpeg mid midi smf jet rtttl imy xmf mp4 m4a m4v 3gp 3gpp 3g2 3gpp2 amr awb wma wmv zip lzma';
			
			x_copy_list=' '; i_copy_list=' ';
			for ext in ${r_copy_list}; do x_copy_list="${x_copy_list}"'-xr!*.'"${ext} "; i_copy_list="${i_copy_list}"'-ir!*.'"${ext} "; done
			
			if [ "${opt_r#fb}" -eq 0 ]; then
				7za a -tzip -mm=Copy -ssc- -y -ir\!*.* ${resources_arsc} ${classes_dex} ${libraries} -xr\!*.png -xr\!*.jpg -xr\!*.jpeg ${x_copy_list} "../$APK" > /dev/null
			else
				7za a -tzip -mm=Deflate -mfb=$(CL ${opt_r}) -mpass=16 -ssc- -y -ir\!*.* ${resources_arsc} ${classes_dex} ${libraries} -xr\!*.png -xr\!*.jpg -xr\!*.jpeg ${x_copy_list} "../$APK" > /dev/null
			fi
			7za a -tzip -mm=Copy -ssc- -y ${i_copy_list} ${png_files} ${jpg_files} "../$APK" > /dev/null
			
			unset -v i_copy_list x_copy_list r_copy_list
		fi

		#### Remove ".go[${APK%.*}]" dir ####
		if [ "$opt_p" ] || [ "$opt_a" ] || [ "$opt_r" ] || [ "$opt_d" ] || [ "$opt_l" ] || [ "$opt_j" ]; then
			cd ..
			rm -rf ".go[${APK%.*}]" 2>/dev/null
		fi

		#### Check All Files Are In APK####
		if [ "$GOCHECK" != "`7za l -tzip "$APK" 2>/dev/null | sed -n 's/^[ \t]\+[0-9]\+[ \t]\+[0-9]\+[ \t]\+\([0-9]\+\)[ \t].*[ \t]\([0-9]\+\)[ \t].*/\1_\2/gp'`" ]; then
			echo "[E] <[ $APK ]> CORRUPTED during GOptimization"'!!!'
		fi

		#### KEEP ONLY SELECTED LIBRARIES ####
		if [ "$opt_k" ]; then
			lib_test="`7za l -i\!lib/* "$APK" | sed -n 's#^.*[\t ]lib/\([[:alnum:]-]\+\)/.*$#\1#gp' |  awk '!x[$0]++'`";
			
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
				7za d -tzip -i\!"lib/*" -x\!"lib/${lib_keep}/*" "$APK" > /dev/null
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
				sign --override "$APK"
			else
				echo "[E] Failed: Java not properly configured"
			fi
		fi

		#### ZIPALIGN ####
		echo " +- Zipaligning APK..."
		zipalign -f 4 "$APK" "${APK}.zipa" > /dev/null
		mv -f "${APK}.zipa" "$APK"

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

