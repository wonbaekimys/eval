# hdfs dfs -Ddfs.blocksize=4194304 -cp /250gb_tera_32mb /250gb_tera_4mb
# hdfs dfs -Ddfs.blocksize=8388608 -cp /250gb_tera_32mb /250gb_tera_8mb
# hdfs dfs -Ddfs.blocksize=16777216 -cp /250gb_tera_32mb /250gb_tera_16mb
# hdfs dfs -Ddfs.blocksize=268435456 -cp /250gb_tera_32mb /250gb_tera_256mb
# hdfs dfs -Ddfs.blocksize=536870912 -cp /250gb_tera_32mb /250gb_tera_512mb
# hdfs dfs -Ddfs.blocksize=1073741824 -cp /250gb_tera_32mb /250gb_tera_1gb
# hdfs dfs -Ddfs.blocksize=2147483327 -cp /250gb_text_1gb /250gb_text_2gb
# hdfs dfs -Ddfs.blocksize=2147483327 -cp /250gb_seq_1gb /250gb_seq_2gb

# hdfs dfs -Ddfs.blocksize=4194304 -cp /64gb_seq_128mb /64gb_seq_4mb
hdfs dfs -Ddfs.blocksize=8388608 -cp /64gb_seq_128mb /64gb_seq_8mb
hdfs dfs -Ddfs.blocksize=16777216 -cp /64gb_seq_128mb /64gb_seq_16mb
hdfs dfs -Ddfs.blocksize=33554432 -cp /64gb_seq_128mb /64gb_seq_32mb
hdfs dfs -Ddfs.blocksize=67108864 -cp /64gb_seq_128mb /64gb_seq_64mb
hdfs dfs -Ddfs.blocksize=268435456 -cp /64gb_seq_128mb /64gb_seq_256mb
hdfs dfs -Ddfs.blocksize=536870912 -cp /64gb_seq_128mb /64gb_seq_512mb
hdfs dfs -Ddfs.blocksize=1073741824 -cp /64gb_seq_128mb /64gb_seq_1gb
hdfs dfs -Ddfs.blocksize=2147483136 -cp /64gb_seq_128mb /64gb_seq_2gb
hdfs dfs -rm -r /250gb_seq_2gb
hdfs dfs -Ddfs.blocksize=2147483136 -cp /250gb_seq_32mb /250gb_seq_2gb
