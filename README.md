# ec2_metadata_stubs

Create fixed stubs for the EC2 API (hosted at http://169.254.169.254), so that you can test cookbooks that expect it to be present without needing to launch actual EC2 instances

This cookbook will create a loopback subinterface that is bound to 169.254.169.254 and listen on it on port 80 with a ruby server (powered by the ruby that comes with chef) to serve static API stubs.

## Usage

1. Include this cookbook in your kitchen runlist
1. Add attributes under ec2_metadata_stubs/stubs for each EC2 API endpoint


## Example

`kitchen.yml`

```
suites:
  - name: default
    run_list:
      - recipe[ec2_metadata_stubs]
      - recipe[my_cookbook_under_test]
    attributes:
      ec2_metadata_stubs:
        stubs:
          latest/user-data: '{"configuration": "static stub values appropriate for smoke tests"}'
```

