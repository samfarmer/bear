# bear

bear takes metadata from ColdFusion ORM entities and turns it into a readable text-based diagram of the relationships and properties.

## Features

- Works with any entities that a mapping will point to. 
- Option to exclude entities to avoid listing entities that just produce noise (eg, user). Entities are displayed once to prevent circular display problems.
- Option to show just relationships and ignore properties.
- A GUI setup process
- Clicking on a property displays all metadata in a popover

## How it works

bear runs as its own application and uses ColdFusion mappings to read entities and their information. Provide all the mappings that your application uses for entities

## How to make it work

Download the code somewhere local. Run. 

## This would make a great Builder extension

Yes it would!

### License

Licensed under the [MIT License](http://opensource.org/licenses/MIT)