# OptimusGrime

OptimusGrime is a program that generates cleaning instructions for square-meters in an office. Given a grid and a list of coordinates representing square-meters to be cleaned, OptimusGrime provides a list of navigation instructions to reach those locations.

## Setup

1. Ensure that Ruby is installed on your system. You can check by running `ruby --version` in the terminal. If Ruby is not installed, you can install it from the official website: https://www.ruby-lang.org/

2. Clone the OptimusGrime repository to your local machine:

   ```shell
   git clone git@github.com:manasashanubhogue/OptimusGrime.git
   ```

3. ``` cd project directory
    bundle install


## Usage

To generate cleaning instructions, you need to provide the grid size and the coordinates of the square-meters to be cleaned.

Run the following command to execute OptimusGrime:

```
ruby optimusgrime.rb grid_size "coordinate1" "coordinate2" ...
```

grid_size:  e.g., 5x5.
coordinate1, coordinate2, ...: format (x, y), e.g., "(1, 3)"

## Testing

``` bundle exec rspec spec/cleaningtask_spec.rb ```


## Few Outputs
<img width="1213" alt="Screenshot 2023-07-03 at 20 05 45" src="https://github.com/manasashanubhogue/OptimusGrime/assets/6822599/87d867e4-9c1e-4c76-b2ce-ee9a105356f7">



