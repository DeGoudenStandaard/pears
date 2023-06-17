# Data
A place where you can store all your data. This directory is ignored by git, so you can store all your data here without worrying about accidentally committing it to the repository.

The data structure is __very__ important in this project. The data structure is as follows:

```yaml
data:
- raw
    - train
        - rotten
            - 0.png
            - 1.png
        - not_rotten
            - 0.png
            - 1.png
    - test
        - all
            - 0.png
            - 1.png
```
