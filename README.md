
# MyBookShelf

MyBookShelf is a Java Servlets and JSP based web application designed to serve as a reading log. Users can create, edit, read, and delete books from their collection. Additionally, they can view records and statistics about their reading habits, such as number of books read, average rating books, and preferred genres. One of the key features of the app is the ability to upload Excel documents to populate the list of books, providing users with a convenient way to import their reading lists.



## Infrastructure Dependencies

To run this application, you'll need the following software installed on your development machine:

- **Tomcat 9**: A Java Servlet container: https://tomcat.apache.org/
- **Java 21 (or later)**: The Java Development Kit: https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html
- **MySQL 8 (or later)**: A relational database management system: https://dev.mysql.com/downloads/mysql/
- **Maven 3 (or later)**: A build automation tool: https://maven.apache.org/download.cgi
## How to Build

1. Clone or Download the Project: Obtain the source code for the application:


 ```sh
git clone https://github.com/AlondraMRP/MyBookShelf.git

  ```

2. Open in IDE: Open the project directory in your preferred Java IDE (e.g., Eclipse, IntelliJ IDEA).
3. Configure Database Connection (if necessary): Update the `context.xml` file with your MySQL connection details (`hostname`, `username`, `password`, `database name`).

4. Build with Maven: Run the following command in your terminal from the project directory:

 ```sh
  mvn clean package

  ```
This will create a `.war` file (web archive) in the target directory. This file is deployable to your Tomcat server.







## How to Build as a Developer

If you want to modify the application's code:

1. Follow steps 1-3 in the "How to Build" section.
2. Make your desired changes to the source code (Java servlets, JSPs, etc.).
3. Rebuild the project using the same Maven command (`mvn clean package`) to incorporate your modifications into the `.war` file.
## Deployment

To deploy MyBookShelf in Tomcat, follow these steps:

1. After building the project, navigate to the target directory.
2. Copy the generated WAR file (`mybookshelf.war`) to the webapps directory of your Tomcat installation.
3. Start or restart Tomcat.
4. Access the application at http://localhost:8080/mybookshelf (assuming default Tomcat configurations).


## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**. 

If you have a suggestion that would make this better, please fork the repo and create a pull request. 

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature`)
3. Commit your Changes (`git commit -m 'Add some feature'`)
4. Push to the Branch (`git push origin feature`)
5. Open a Pull Request



