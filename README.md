# OptimusGrime

OptimusGrime is a program that generates cleaning instructions for square-meters in an office. Given a grid and a list of coordinates representing square-meters to be cleaned, OptimusGrime provides a list of navigation instructions to reach those locations.

## Setup

1. Ensure that Ruby is installed on your system. You can check by running `ruby --version` in the terminal. If Ruby is not installed, you can install it from the official website: https://www.ruby-lang.org/

2. Clone the OptimusGrime repository to your local machine:

   ```shell
   git clone https://github.com/your-username/OptimusGrime.git
   ```

3. ``` cd project directory
    bundle install ```


## Usage

To generate cleaning instructions, you need to provide the grid size and the coordinates of the square-meters to be cleaned.

Run the following command to execute OptimusGrime:

```
./optimusgrime.rb grid_size "coordinate1" "coordinate2" ...
```

grid_size:  e.g., 5x5.
coordinate1, coordinate2, ...: format (x, y), e.g., "(1, 3)"

## Testing

``` bundle exec rspec main/optimusgrime_spec.rb ```



