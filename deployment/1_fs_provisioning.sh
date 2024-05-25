
TARGET_DISK=$1

sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk --wipe-partitions always "${TARGET_DISK}"
  o # clear the in memory partition table
  n
  p
  1

  +128M
  n
  p
  2

  +2G
  n
  p
  3


  t
  1
  c
  t
  2
  82
  p
  w
  q
EOF

mkfs -t vfat -F 32 "${TARGET_DISK}1"
mkswap "${TARGET_DISK}2"
mkfs -i 8192 -t ext4 "${TARGET_DISK}3"
