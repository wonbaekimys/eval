source /home/wb/tools/h2mb.sh

function job_name_it() {
  echo wc
  echo grep
  echo sort
}
function data_size_it() {
  echo 64gb
  echo 250gb
}
function block_size_it() {
  echo 32mb
  echo 64mb
  echo 128mb
  echo 256mb
  echo 512mb
  echo 1gb
  echo 2gb
}

prefix="time-blocksize-"
for job_name in $(job_name_it); do
  csvpath="time/${prefix}${job_name}.csv"
  [[ -f $csvpath ]] && rm $csvpath
  record="blocksize,"
  for data_size in $(data_size_it); do
    record+="${job_name}-${data_size},"
  done
  for (( run_id=1; run_id<=3; ++run_id )); do
    echo $record >> $csvpath
    for block_size in $(block_size_it); do
      record="$(h2mb $block_size),"
      for data_size in $(data_size_it); do
        record+="$(tail -n 1 logs/$job_name-$data_size-$block_size-$run_id.log),"
      done
      echo $record >> $csvpath
    done
  done
done



# run_id=1
# for job_name in $(sh job_name_it.sh); do
#   for data_size in $(sh data_size_it.sh); do
#     rm logs/$job_name-$data_size.dat
#     bls=32
#     for block_size in $(sh block_size_it.sh); do
#       echo $bls' '$(tail -n 1 logs/$job_name-$data_size-$block_size-$run_id.log) >> logs/$job_name-$data_size.dat
#       ((bls*=2))
#     done
#   done
# done

# run_id=1
# job_name="wcGrepSort"
# data_size="assorted"
# rm logs/$job_name-$data_size.dat
# bls=32
# for block_size in $(sh block_size_it.sh); do
#   echo $bls' '$(tail -n 1 logs/$job_name-$data_size-$block_size-$run_id.log) >> logs/$job_name-$data_size.dat
#   ((bls*=2))
# done

# function job_name_it() {
#   echo eclipseWc
#   echo eclipseWcWTO
#   echo eclipseWcWPF
#   echo eclipseWcWTOWPF
# }
# function data_size_it() {
#   echo 250gb
# }
# function block_size_it() {
#   echo 128mb
# }
# run_id=1
# for job_name in $(job_name_it); do
#   for data_size in $(data_size_it); do
#     rm logs/$job_name-$data_size.dat
#     bls=128
#     for block_size in $(block_size_it); do
#       echo $bls' '$(tail -n 1 logs/$job_name-$data_size-$block_size-$run_id.log) >> logs/$job_name-$data_size.dat
#       ((bls*=2))
#     done
#   done
# done
