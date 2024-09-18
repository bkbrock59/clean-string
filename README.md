# RPGLE - Clean invalid characters from string
On the IBM i, I've used a few methods to remove unwanted characters from text strings. Usually, these methods involved defining a string of unwanted characters. Each time a new unwanted character was encountered, the string of valid characters was updated. 

In this latest version of the string cleaner, the logic was flipped. The unwanted list of characters was converted to a list of valid characters. These were the basic printable EBCIDIC characters. When we started using browser-based text widgets, they were less restrictive than green screens. Thus, the routine was modified to allow an extended set of valid characters.

* This program is meant to run in debug mode so you can see how it works. I coded the sub-procedure as a function to make it easier to use. I placed it in a service program that can be accessed from any other program.