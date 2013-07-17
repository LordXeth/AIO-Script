#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

namespace Ui {
    class MainWindow;
}

class QString;

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
    bool resizeImage(QString filename, QString fromDPI, QString toDPI);

private:
    Ui::MainWindow *ui;

private slots:
    void on_actionQuit_triggered();
    void on_actionAbout_triggered();
    void on_actionAbout_Qt_triggered();
    void on_cmdStart_clicked();
    void on_chkUseInput_clicked(bool checked);
    void on_cmdBrowseOutput_clicked();
    void on_cmdBrowseInput_clicked();
};

#endif // MAINWINDOW_H
