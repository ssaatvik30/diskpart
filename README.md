
# Diskpart Automation Script 

A command-line tool to automate common disk partitioning tasks in Linux. It acts as a simple wrapper around `parted`, `mkfs`, and `mount` to streamline the process of creating and preparing new disk partitions.

---

## **CRITICAL WARNING: DATA LOSS RISK** 

This script automates disk partitioning and formatting. **Using it on the wrong disk or with incorrect parameters will lead to PERMANENT DATA LOSS.**

* **Verify your disk names** (`/dev/sda`, `/dev/sdb`, etc.) carefully before execution.
* Understand the difference between creating a **new partition table (`-n`)**, which erases the entire disk, and adding to an **existing one (`-e`)**.
* It is highly recommended to **test this script on a virtual machine** or a non-critical disk before using it in a production environment.

**By using this script, you acknowledge the risks and take full responsibility for any data loss.**

---

## Prerequisites

Before running this script, ensure the following utilities are installed on your system:
* `parted`
* Filesystem creation tools (e.g., `e2fsprogs` for `mkfs.ext4`, `xfsprogs` for `mkfs.xfs`).

---

## How to Use

1. **Clone the repository**
    ```
    git clone https://github.com/ssaatvik30/diskpart.git
    cd diskpart
    ```
2.  **Make the script executable:**
    ```bash
    chmod +x diskpart.sh
    ```

3. **Execute the script or place the script in /usr/local/bin/**
    ```
    ./diskpart.sh [-n/-e] [disk] [part_table] [part_type] [fs] [start] [end] [partition_name] [mount_point]  
    ```		
 
### **Option 1: `-n` (Create a New Partition Table)**

This option is for **blank disks** or disks you want to **completely wipe**. It creates a new partition table (e.g., GPT or MBR), then creates a partition, formats it, and mounts it.

**Syntax:**
```bash
sudo ./diskpart.sh -n [disk] [table_type] [part_name] [fs_type] [start] [end] [partition_device] [mount_point]
```

* **`<disk>`**: The target disk name (e.g., `sdb`, `nvme0n1`). **Do not include `/dev/`.**
* **`<table_type>`**: The type of partition table to create (e.g., `gpt`, `msdos`).
* **`<part_name>`**: A name for the partition (e.g., `primary`, `data-part`).
* **`<fs_type>`**: The filesystem to format the partition with (e.g., `ext4`, `xfs`, `btrfs`).
* **`<start>`**: The start position of the partition (e.g., `0%`, `1MiB`).
* **`<end>`**: The end position of the partition (e.g., `100%`, `50GiB`).
* **`<partition_device>`**: The name of the new partition (e.g., `sdb1`, `nvme0n1p1`).
* **`[mount_point]`**: (Optional) The directory to mount the new partition. The script will create it if it doesn't exist.

**Example:**
To create a new `gpt` table on disk `sdb`, use 100% of the space for an `ext4` partition, and mount it to `/mnt/newdata`:
```bash
sudo ./diskpart.sh -n sdb gpt primary ext4 0% 100% sdb1 /mnt/newdata
```

---

### **Option 2: `-e` (Partition on an Existing Table)**

This option adds a new partition to a disk that **already has a partition table**. It creates the partition in the specified free space, formats it, and mounts it.

**Syntax:**
```bash
sudo ./diskpart.sh -e [disk] [part_name] [fs_type] [start] [end] [partition_device] [mount_point]
```

* **`<disk>`**: The target disk name (e.g., `sda`). **Do not include `/dev/`.**
* **`<part_name>`**: A name for the partition (e.g., `logical`, `archive-part`).
* **`<fs_type>`**: The filesystem to format with (e.g., `ext4`).
* **`<start>`**: The start position of the new partition.
* **`<end>`**: The end position of the new partition.
* **`<partition_device>`**: The name of the new partition (e.g., `sda3`).
* **`[mount_point]`**: (Optional) The mount point for the new partition.

**Example:**
To add a new `ext4` partition to disk `sda` using the space from 50% to 100% and mount it to `/home/user/archive`:
```bash
sudo ./diskpart.sh -e sda archive-part ext4 50% 100% sda3 /home/user/archive
```

---

