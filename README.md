# Film Ratings

## Project Description

The dataset for this project was taken from kaggle.com. This project for learning purposes only. I wanted to utilize some of the transformation components available in Integration Services, build reports in Power Bi using a Multidimensional Model, and create calculations and KPI's in Analysis Services.

## Technologies Used

* Visual Studio 2017
* SSIS - SSDT 2017
* SSAS - SSDT 2017
* SQL Server - 2016
* Microsoft Excel
* Microsoft Power BI

## Features

* Implemented Integration Services to load from a flat file source into a relational database
* Used SSAS to provide analysis by creating measures and KPI
* Created views to give insight into data based on each dimension.
* Created visualizations and detailed reports using Power BI

To-do list:
* Create a stored procedure to insert new films
* Create a trigger that logs each time a new film is inserted.
* Implement an SSRS Project

## Getting Started
   
* Ensure that you have Visual Studio with SSDT 2017 installed.
* Ensure that you have SQL Server 2016 installed with integration services and analysis services instances. 
* Ensure that you have Power Bi Desktop installed. 
* Using the Command Prompt, navigate to the directory that you want to clone the repository in.
* Use the following command to clone the repository:
    git clone https://github.com/Robo-91/film_database.git
* Find the film_DB.bak file, move it to your backup folder and restore: https://docs.microsoft.com/en-us/sql/relational-databases/backup-restore/restore-a-database-backup-using-ssms?view=sql-server-ver15
* For Example, the path to my backup file would be:
C:\Program Files\Microsoft SQL Server\MSSQL13.servername\MSSQL\Backup  
* Find the SSASFilm_Multidimensional.abf file, move it to your backup folder and restore it: https://docs.microsoft.com/en-us/analysis-services/multidimensional-models/backup-and-restore-of-analysis-services-databases?view=asallproducts-allversions
* For Example, the path to my backup file would be:
C:\Program Files\Microsoft SQL Server\MSAS13.servername\OLAP\Backup
* Connect the Power Bi reports to your analysis services (Where the .abf backup file is restored)

## Usage

Use Power Bi to view how the data is visualized. You can use the visualizations from the summary report to drillthrough to each detail report. Right click on a chart, select drillthrough, and it should give you the option of the appropriate report to navigate to.

## License

This project uses the following license: [GNU](https://www.gnu.org/licenses/gpl-3.0.en.html).
