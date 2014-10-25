multicities_flexdates
=====================

Allows for searching kayak.com with multiple cities AND flexible dates, sort of :/

The idea is that you enter in your multi-leg travel plans one leg at a time and each permutation is opened in a new tab in your default browser.

Crude. Dirty. Inefficient. Not anywhere near the best way to solve the multi-city/flex-date problem.
But quick(ish). And I needed to buy that ticket like yesterday.

Documentation
=============

This was designed to be run in a Mac terminal. I don't think it's Windows or Linux compatible because the search function uses the system("open") command, which I'm given to understand is unique to Mac Terminal. Sry. 

To start, clone the repository and switch to your Ruby environment (irb or pry). 

Next you'll want to load the Trip class file:
> load '/Users/NAME/PATH/TO/multicities_flexdates/kayak_trip.rb'


Then you'll want to create a new Trip object, specifying the number of legs the trip will have. In this example, I'm searching for Santa Barbara to Austin, Austin to Chicago, Chicago to Santa Barbara, so, 3 legs.
> xmas_vacation = Trip.new(3)

If all is right with the universe, you'll be prompted for all the necessary information, starting with origin and destination. You'll note that this first version requires you to know airport codes. I'm a big fan, and have all my normal destinations memorized. If you don't, or are going somewhere new, here's a resource for finding them: expedia.com/daily/airports/AirportCodes.asp. Alternately, just go to kayak.com/flights and type in the city and you'll see the airport code in parentheses after the city name.

The other quirk is that the dates you provide have to be in the format: YYYY-MM-DD. Or you can create a Date object (Date.new(YYYY, MM, DD)), but that's not really any easier. 

The last item you're asked for in each leg is the flexibility. This is the number of dates in addition to the original that you want to search for. So if you want to search the range Jan 1st, 2015 through the 3rd, you would enter 2015-01-01 for the date and 2 for the flexibility. Just keep in mind that the number of tabs that will be opened is essentially the product of the flexibility values + 1. So if you have three legs and put 4 for each flexibility, that's gonna be 125 tabs (5 * 5 * 5).

Once your legs are entered, you can see how many tabs the search will open with the #permutations command:
> xmas_vacation.permutations


If that number is over 200, you may want to change one or more of your flexibilities, or just be prepared for your computer and network to be very slow for a few minutes. To change a flexibility (right now it's ugly, but) you can do the following:
> xmas_vacation.flights[0].flexibility = 2  # this changes the flex. value for the 1st flight to '2'


You can also change origin, destination, and date values this way.

Finally, to run the search:
> xmas_vacation.search


I usually open a new browser window right before I execute this. Once all the tabs pop up, it's easy to navigate through them with CTRL-Tab, or if you have a specific dollar amount in mind, just close each tab that's higher than you want it to be. In Chrome, Cmd-Shift-W closes the entire window.
