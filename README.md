<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/rkelly310/CucumberAPIDemo/">
    <img src="images/cucumber.png" alt="Logo">
  </a>

  <h2 align="center">Creating and Testing BDD Scenarios using Specflow in .NET and Selenium Webdriver</h2>

  <p align="center">
    A demo lab instructing users on construct BDD test projects, feature files, step definitions and test runners to complete a BDD test iteration.
    <br />
    <a href="https://github.com/U815073/SpecFlowSeleniumDemo/"><strong>Explore the docs �</strong></a>
    <br />
    <br />
    <a href="https://github.com/U815073/SpecFlowSeleniumDemo/">View Demo</a>
    �
    <a href="https://github.com/U815073/SpecFlowSeleniumDemo/issues">Report Bug</a>
    �
    <a href="https://github.com/U815073/SpecFlowSeleniumDemo/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
        </ul>
        <li><a href="#instructions">Instructions</a></li>
      </ul>
    </li>
<!--
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
-->
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
<!--
    <li><a href="#acknowledgements">Acknowledgements</a></li>
-->
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
### About The Project

This project is designed for a lab environment within a Test Automation and Behavior-Driven Development course. Students will build out a feature file, a series of step definitions, a Specflow test runner class to test a basic webdriver application that utilizes the preexisting Lambda lab to test its To-Do List functionalities.
To view individual requirement solutions, review the steps below.

### Built With

* [Visual Studio 2019]
* [SpecFlow for VS2019 Extension Plugin](https://openjdk.java.net/projects/jdk/11/)
* geckodriver.exe (or another browser equivalent) existing in your System PATH) https://github.com/mozilla/geckodriver/releases
<br>
**Please ensure you also download the following plugins if you do not have them already:**

* [Nunit] Testing Framework
* [Specflow] BDD Framework
* [Selenium Webdriver]
* [Selenium Firefox Webdriver]
<br>


<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

None, other than Visual Studio (2017 or 2019), one webdriver (we used Firefox for this lab) and the packages and extensions above.

### Installation

Simply clone the repo to see the full solution:
   ```sh
   git clone https://github.com/U815073/SpecFlowSeleniumDemo.git
   ```
<!-- Instructions -->
## Instructions
### Task 1: Install the Dependencies:  
Open a 'Class Library' Project in Visual Studio using any .NET Core version (preferably the latest). Call it 'ToDoListDemo'. Immediately download the following dependencies from Artifactory or NuGet Package Manager:  
**Specflow**  
**Specflow.Nunit**  
**Nunit3TestAdapter**  
**Specflow.Tools.MsBuild.Generation**
**Selenium.WebDriver**  
**Selenium.Firefox.Webdriver**  
<br>
In addition, make sure the **Specflow for Visual Studio** extension is installed on your VS version.  
<br>
### Task 2: Create the Feature File and Step Definitions  
Once the project has been created, add two new folders under our new Class Library project; one called 'Features' and one called 'StepDefinitions'. in the 'Features' folder, add a new item. If you have the SpecFlow plugin installsed, you should be able to select the 'Specflow' option from the Visual C# Items and choose Feature File. Fill the feature file in with the following:  

```csharp
Feature: ToDoList
    Select first two items in the ToDoList
    Enter a new item in the ToDoList
    Add the new item to the list
 
@ToDoList
Scenario: Add items to the ToDoList
    Given that I am on the LambdaTest Sample app
    Then select the first item
    Then select the second item
    Then find the text box to enter the new value
    Then click the Submit button
    And  verify whether the item is added to the list
    Then close the browser instance
```  
 Next, right click any of the lines in the feature file and select 'Generate Step Definition'. This will allow you to auto-generate a skeleton of steps. This new 'StepDefinitions' file should import all of our dependencies and outline our logic. Fill this file with the following:  
 ```csharp
 using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OpenQA.Selenium;
using OpenQA.Selenium.Firefox;
using TechTalk.SpecFlow;
using NUnit.Framework;
using System.Threading.Tasks;
using System.Text.RegularExpressions;
using OpenQA.Selenium.Support.UI;
using OpenQA.Selenium.Interactions;

namespace ToDoApp.StepDefinitions
{
    [Binding]
    public sealed class ToDoListSteps
    {
        readonly string test_url = "https://lambdatest.github.io/sample-todo-app/";
        readonly string itemName = "Adding item to the list";
        IWebDriver driver;

        // For additional details on SpecFlow step definitions see https://go.specflow.org/doc-stepdef


        [Given(@"that I am on the LambdaTest Sample app")]
        public void GivenThatIAmOnTheLambdaTestSampleApp()
        {
            driver = new FirefoxDriver(@"C:\...\ToDoList\ToDoList\Features") //insert the path to the geckodriver.exe here!
            {
                Url = test_url
            };
            driver.Manage().Window.Maximize();
            System.Threading.Thread.Sleep(2000);
        }

        [Then(@"select the first item")]
        public void ThenSelectTheFirstItem()
        {
            // Click on First Check box
            IWebElement firstCheckBox = driver.FindElement(By.Name("li1"));
            firstCheckBox.Click();
        }

        [Then(@"select the second item")]
        public void ThenSelectTheSecondItem()
        {
            // Click on Second Check box
            IWebElement secondCheckBox = driver.FindElement(By.Name("li2"));
            secondCheckBox.Click();
        }

        [Then(@"find the text box to enter the new value")]
        public void ThenFindTheTextBoxToEnterTheNewValue()
        {
            // Enter Item name
            IWebElement textfield = driver.FindElement(By.Id("sampletodotext"));
            textfield.SendKeys(itemName);
        }

        [Then(@"click the Submit button")]
        public void ThenClickTheSubmitButton()
        {
            // Click on Add button
            IWebElement addButton = driver.FindElement(By.Id("addbutton"));
            addButton.Click();
        }

        [Then(@"verify whether the item is added to the list")]
        public void ThenVerifyWhetherTheItemIsAddedToTheList()
        {
            // Verified Added Item name
            IWebElement itemtext = driver.FindElement(By.XPath("/html/body/div/div/div/ul/li[6]/span"));
            String getText = itemtext.Text;

            // Check if the newly added item is present or not using
            // Condition constraint (Boolean)
            Assert.That((itemName.Contains(getText)), Is.True);

            /* Perform wait to check the output */
            System.Threading.Thread.Sleep(2000);

            Console.WriteLine("Firefox - Test 1 Passed");
        }

        [Then(@"close the browser instance")]
        public void ThenCloseTheBrowserInstance()
        {
            driver.Quit();
        }
    }
}
```
Take time to analyze the following code and understand each step.  
<br>

### Task 3: Run The Test  
At this point, build the solution and run the test. You should see the example application pop up in a firefox window. Follow the steps as written in the feature file and the browser should close on its own. Congratulations, you have successfully performed a SpecFlow Nunit Test using Selenium Firefox webdriver.  
<br>
<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<!-- CONTACT -->
## Contact

Project Link: [https://github.com/U815073/SpecFlowSeleniumDemo](https://github.com/U815073/SpecFlowSeleniumDemo)



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=for-the-badge
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=for-the-badge
[forks-url]: https://github.com/othneildrew/Best-README-Template/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=for-the-badge
[stars-url]: https://github.com/othneildrew/Best-README-Template/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=for-the-badge
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/othneildrew/Best-README-Template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/othneildrew
[product-screenshot]: images/screenshot.png
