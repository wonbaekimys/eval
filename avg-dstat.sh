function job_name_it() {
#  echo eclipseWc
#  echo eclipseWcWTO
#  echo eclipseWcWPF
#  echo eclipseWcWTOWPF
echo sort
}
function data_size_it() {
  # echo 250gb
  echo 64gb
}
function block_size_it() {
  # echo 128mb
  echo 1gb
  echo 2gb
}
# usage: avg_dstat job_name data_size block_size [num_runs] [num_slaves]
avg_dstat=/home/wb/tools/examples/avg_dstat
# $avg_dstat sort 64gb 4mb 1 32
# $avg_dstat sort 64gb 8mb 1 32
# $avg_dstat sort 64gb 16mb 1 32
# $avg_dstat sort 64gb 32mb 1 32
# $avg_dstat sort 64gb 64mb 1 32
# $avg_dstat sort 64gb 128mb 1 32
# $avg_dstat sort 64gb 256mb 1 32
# $avg_dstat sort 64gb 512mb 1 32
# $avg_dstat sort 64gb 1gb 1 32
# $avg_dstat sort 64gb 2gb 1 32
# $avg_dstat sort 250gb 4mb 1 32
# $avg_dstat sort 250gb 8mb 1 32
# $avg_dstat sort 250gb 16mb 1 32
# $avg_dstat sort 250gb 32mb 1 32
# $avg_dstat sort 250gb 64mb 1 32
# $avg_dstat sort 250gb 128mb 1 32
# $avg_dstat sort 250gb 256mb 1 32
# $avg_dstat sort 250gb 512mb 1 32
# $avg_dstat sort 250gb 1gb 1 32
# $avg_dstat sort 250gb 2gb 1 32
# $avg_dstat grep 250gb 2gb 1 32
# $avg_dstat wc 64gb 2gb 1 32
# $avg_dstat wc 250gb 2gb 1 32
# $avg_dstat wc 250gb 2gb 1 32
num_runs=1
for job_name in $(job_name_it); do
  for data_size in $(data_size_it); do
    for block_size in $(block_size_it); do
      $avg_dstat $job_name $data_size $block_size $num_runs 32
    done
  done
done
# for job_name in $(sh job_name_it.sh); do
#   for data_size in $(sh data_size_it.sh); do
#     for block_size in $(sh block_size_it.sh); do
#       $avg_dstat $job_name $data_size $block_size $num_runs 32
#     done
#   done
# done
# for block_size in $(sh block_size_it.sh); do
#   $avg_dstat "wcGrepSort" "assorted" $block_size $num_runs 32
# done
