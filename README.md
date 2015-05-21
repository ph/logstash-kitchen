# How to run
- install boot2docker
  `brew install boot2docker`
- Launch boot2docker
  `boot2docker start`
- Set the docker environment variables
- Install dependencies
  `bundle install`
- Run the suite with:
  `bundle exec kitchen test`


# TODO
- Allow to run with a specified seed
- Reduce noise ratio of kitchen.ci and only show serverspec (WIP on the kitchen.ci side)
