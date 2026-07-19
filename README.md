# crime-analysis-20-24
This repo contains a crime analysis project done in PowerBI.
## 1. Crime Data in LA 2020-2024 Dashboard
An interactive data visualization tool built to explore crime in LA, examining incidents by time, location, and reported threats.

## 2. Description
The Crime Analysis dashboard is a visually engaging and analytical Power BI report designed to help users explore and compare the crime incidents in LA from 2020-2024. The dashboard focuses on highlighting crime patterns through temporal patterns, geographic distribution, and threats reported in each documented case. This tool is intended for use by law enforcement or civilians who seek to identify the trends in criminal activity in LA.

## 3.  Tech Stack
The dashboard was built using the following tools and technologies:
* PowerBI Desktop - Main data visualization platform used for report creation.
* Power Query- Data transformation and cleaning layer for reshaping and preparing data.
* DAX (Data Analysis Expression) - Used for calculated measures and dynamic visuals.
* Data Modeling - Relationships established among tables (Date Table, time table, area, weapons, and crime).
* File Format - .pbix for development and .png for dashboard purposes.

## 4. Data Source
Source: [Los Angeles Open Data](https://data.lacity.org/Public-Safety/Crime-Data-from-2020-to-2024/2nrs-mtv8/about_data)

## 5. Features / Highlights
Law enforcement needs to understand when, where, and how crimes occur in order to allocate resources effectively and identify high-risk areas.

When are criminal activities most likely to take place?
Where are the criminal hotspots in Los Angeles?
Does law enforcement need to be prepared to use force when responding to a call?

Goal: To create an effective interactive tool that analyzes temporal trends, geographic hotspots, and weapon usage patterns to help users identify crime trends and support informed resource planning.  

**Key Visuals**
* Arrests By Time of Day (Pie Chart TOP LEFT): Comparing number of arrests by bucketed time of day slots (Early Morning, Morning, Afternoon, Night).
* Threats Reported at Time of Arrest (Donut Chart BOTTOM LEFT): Compares presence of reported threats during incidents. May be used to help determine level of intensity or level of force needed by law enforcement.
* KPIs (TOP MIDDLE): Shows 1 Million recorded arrests with the most arrests taking place at 12pm.
* Arrests By Year (Line Chart MIDDLE BOTTOM): Number of arrests each year.
* Arrests By Area (TreeMap RIGHT BOTTOM): The number of arrests in each area of Los Angeles.

**Impacts and Insights:**
* Interactive filtering enables users to explore crime trends across multiple dimensions for deeper analysis.
* Law enforcement can use this dashboard to identify peak criminal activity during specific times and days of week for targeted resource deployment in each area. 
* Geographic analysis identifies reoccurring hotspots that may benefit from an increased patrol presence.
* Weapon trend analysis reveals the most frequent threat types, supporting risk assessment and public safety planning.

**6. Screenshot of Dashboard** 

![Dashboard Preview](https://github.com/TahjaAnalyst/crime-analysis-20-24/blob/main/CrimeDashboard.JPG)
