Feature: Calculator
	In order to avoid silly mistakes
	As a math idiot
	I want to be told the sum of two numbers

@HappyPath
Scenario Outline: Add two numbers
	Given I have entered <FirstNumber> into the calculator
	And I have also entered <SecondNumber> into the calculator
	When I press add
	Then the result should be <ExpectedResult> on the screen

	Examples: 
	| FirstNumber | SecondNumber | ExpectedResult |
	| 50          | 70           | 120            |
