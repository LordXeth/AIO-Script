#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "ui_preview.h"

#include <QFileDialog>
#include <QDir>
#include <QStringList>
#include <QMessageBox>
#include <QString>
#include <QImage>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_cmdBrowseInput_clicked()
{
    ui->lneInputDir->setText(QFileDialog::getExistingDirectory(this, "Please Select Input Directory..."));
}

void MainWindow::on_cmdBrowseOutput_clicked()
{
    ui->lneOutputDir->setText(QFileDialog::getExistingDirectory(this, "Please Select Output Directory..."));
}

void MainWindow::on_chkUseInput_clicked(bool checked)
{
    ui->lneOutputDir->setEnabled(!checked);
}

void MainWindow::on_cmdStart_clicked()
{
    ui->cmdStart->setEnabled(false);
    ui->log->append("> Starting...");

    QString iDPIString = "ldpi";
    if (ui->cmbInputDPI->currentIndex() == 1)
	iDPIString = "mdpi";
    else if (ui->cmbInputDPI->currentIndex() == 2)
	iDPIString = "hdpi";

    QString oDPIString = "ldpi";
    if (ui->cmbOutputDPI->currentIndex() == 1)
	oDPIString = "mdpi";
    else if (ui->cmbOutputDPI->currentIndex() == 2)
	oDPIString = "hdpi";

    ui->log->append(QString("> Searching for directories that are of '%1' resolution.").arg(iDPIString));
    QDir inputDir(ui->lneInputDir->text());
    if (!inputDir.exists()) {
	ui->log->append("> Aborting: the input directory specified does not exist. Nice try though.");
	ui->cmdStart->setEnabled(true);
	return;
    }
    QStringList wildcard;
    wildcard << "*";
    if (inputDir.entryList(wildcard, QDir::Dirs).isEmpty()) {
	ui->log->append("> Aborting: no subdirectories were found in the input directory specified.");
	ui->cmdStart->setEnabled(true);
	return;
    }
    QStringList dpiWildcard;
    dpiWildcard << QString("*%1*").arg(iDPIString);
    QStringList inputFiles = inputDir.entryList(dpiWildcard, QDir::Dirs);
    if (inputFiles.isEmpty()) {
	ui->log->append("> Aborting: no resolution specific subdirectories could be found in the input directory specified.");
	ui->cmdStart->setEnabled(true);
	return;
    }

    qApp->processEvents();

    ui->log->append("> Resolution-specific subdirectories found:");
    for (int i = 0; i < inputFiles.size(); ++i) {
	ui->log->append(inputFiles.at(i));
    }

    qApp->processEvents();

    ui->log->append("> Starting conversion process.");
    for (int i = 0; i < inputFiles.size(); ++i) {  // Iterate 'ldpi', 'mdpi', and/or 'hdpi' subdirs
	QString dirName = inputFiles.at(i);
	ui->log->append(QString("> Processing directory %1").arg(dirName));
	inputDir.cd(dirName);
	QStringList png;
	png << "*.png";
	QStringList subdirFiles = inputDir.entryList(png, QDir::Files); // Iterate files in subdir
	qApp->processEvents();
	for (int f = 0; f < subdirFiles.size(); ++f) {
	    QString file = subdirFiles.at(f);
	    if (!file.endsWith(".9.png")) {   // Ignore .9.png files because they're (partially) encrypted
		ui->log->append(QString("> Processing file %1").arg(file));
		qApp->processEvents();
		if (!resizeImage(inputDir.absoluteFilePath(subdirFiles.at(f)), iDPIString, oDPIString)) {
		    ui->log->append(QString("!!! Error processing file %1 !!!").arg(subdirFiles.at(f)));
		    qApp->processEvents();
		}
	    }
	}
	inputDir.cdUp();
	QString newName = dirName;
	newName.replace(iDPIString, oDPIString);
	inputDir.rename(dirName, newName);
	ui->log->append(QString("> Done processing directory %1 and it has been renamed to %2").arg(dirName).arg(newName));
	qApp->processEvents();
    }
    ui->log->append("> FINISHED processing all directories!");
    ui->cmdStart->setEnabled(true);
}

bool MainWindow::resizeImage(QString filename, QString fromDPI, QString toDPI)
{
    int from = 0;
    if (fromDPI == "ldpi")
	from = 120;
    else if (fromDPI == "mdpi")
	from = 160;
    else if (fromDPI == "hdpi")
	from = 240;

    int to = 0;
    if (toDPI == "ldpi")
	to = 120;
    else if (toDPI == "mdpi")
	to = 160;
    else if (toDPI == "hdpi")
	to = 240;

    double ratio = (double)to / from;

    QImage source(filename);
    if (source.isNull()) {
	qDebug((QString("Source '%1' is null.").arg(filename)).toLocal8Bit());
	return false;
    }

    int origX = 0; // initialize to 0 to be able to perform error checking on the next function
    origX = source.width();

    if (origX <= 0)
	return false;

    /* We don't need to worry about maintaining aspect ratio in rounding because QImage does that for us.
       Also, the decimal place is intentionally stripped when converting from qRound's result to 'int'
       because pixels do not have decimals. :)
    */
    int scaledX = qRound((origX * ratio));
    // qDebug((QString("scaledX is '%1', origX is '%2', ratio is '%3', to is '%4', from is '%5'").arg(scaledX).arg(origX).arg(ratio).arg(to).arg(from)).toLocal8Bit());

    QImage dest(source.scaledToWidth(scaledX, Qt::SmoothTransformation));
    if (dest.isNull()) {
	qDebug((QString("Dest '%1' is null.").arg(filename)).toLocal8Bit());
	return false;
    }
    return dest.save(filename); // May need to tweak 3rd argument (quality) depending on how it ends up looking?
}

void MainWindow::on_actionAbout_Qt_triggered()
{
    QMessageBox::aboutQt(this, "About Qt...");
}

void MainWindow::on_actionAbout_triggered()
{
    QMessageBox::about(this, "About AndroidImageScaler...", "AndroidImageScaler version 1.0.0. Created by Nick Betcher <nbetcher@gmail.com> for the Android community.");
}

void MainWindow::on_actionQuit_triggered()
{
    qApp->quit();
}
