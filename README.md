# Diskpart
A bash script to partition and format a disk and mount the partition.

## Getting Started
1. **Clone the repository**
    ```
    git clone https://github.com/ssaatvik30/diskpart.git
    cd diskpart
    ```
2. **Move the diskpart.1 file to /usr/local/share/man/man1/**
    ```
     man diskpart
    ```
3. **Make the script executable**
    ```
    chmod +x diskpart.sh
    ```
4. **Execute the script or place the script in /usr/local/bin/**
    ```
    ./server-stats.sh {-n(new partition table)/-e(existing partition table)} device partition_table partition_type filesystem start end partition_name mount_point 
    ```

