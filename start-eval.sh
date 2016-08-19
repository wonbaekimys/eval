WB_DSTAT_DIR=/scratch2/wb/eval/hadoop_dstat
# WB_DSTAT_DIR=/home/wb/hadoop/eval/dstat
function start_record() {
# $1=num_hosts, $2=job_tag
  local num_hosts=$1
  local job_tag=$2
  local set host
  for (( i=0; i<=$num_hosts; i++ )); do
    case $i in
      0)
        host="ravenleader"
        ;;
      *)
        (( $i >= 10 )) && host="raven${i}" || host="raven0${i}"
        ;;
    esac
    local csv_path="${WB_DSTAT_DIR}/${job_tag}-${host}.csv"
    local cmd="rm -f ${csv_path}; dstat -cdnmgs --output ${csv_path} &> /dev/null"
    ssh $host $cmd &
  done
}

function stop_record() {
# $1=num_hosts
  local num_hosts=$1
  local set host
  for (( i=0; i<=$num_hosts; i++ )); do
    case $i in
      0)
        host="ravenleader"
        ;;
      *)
        (( $i >= 10 )) && host="raven${i}" || host="raven0${i}"
        ;;
    esac
    ssh $host 'pkill -9 dstat' &
  done
}

function rm_output() {
  local job_name=$1
  hdfs dfs -rm -r /${job_name}Output
}

function drop_page() {
  sudo sh /root/clear_pagecache.sh
  sleep 5
}

function get_job_class_name () {
  local job_name=$1
  local set class_name
  case $job_name in
    ("wc")
      class_name="wordcount"
      ;;
    ("sort")
      class_name="terasort"
      ;;
    (*)
      class_name=$job_name
  esac
  echo $class_name
}

function run_job() {
# $1=jar_path, $1=job_name, $2=data_size, $3=block_size,
# $4=input_infix, $5=run_id
  local jar_path=$1
  [[ $jar_path -eq "example" ]] && jar_path=$HADOOP_EXAMPLE_JAR
  local job_name=$2
  local job_class_name=$(get_job_class_name $job_name)
  local data_size=$3
  local block_size=$4
  local input_infix=$5
  local run_id=$6
  local job_tag="${job_name}-${data_size}-${block_size}-${run_id}"
  local input_path="/${data_size}_${input_infix}_${block_size}"
  local output_path="/${job_name}Output"
  local set args
  for (( i=0; i<6; i++ )); do
    (( $# > 0 )) && shift
  done
  while (( $# > 0 )); do
    [[ $1 =~ '^\S+$' ]] && args="${args} ${1}" || args="${args} '${1}'"
    shift
  done
  if [[ $job_name == "wc" ]]; then
    hargs="-Dmapreduce.job.maps=256 -Dmapreduce.job.reduces=256"
  elif [[ $job_name == "grep" ]]; then
    hargs="-Dmapreduce.job.maps=256 -Dmapreduce.job.reduces=1"
  elif [[ $job_name == "sort" ]]; then
    hargs="-Dmapreduce.job.maps=256 -Dmapreduce.job.reduces=256"
  fi
  # local yarn_cmd="yarn jar ${jar_path} ${job_class_name} ${input_path} ${output_path} ${args}"
  local yarn_cmd="yarn jar ${jar_path} ${job_class_name} ${hargs} ${input_path} ${output_path} ${args}"
  local log_path="/home/wb/hadoop/eval/logs/${job_tag}.log"

  rm_output $job_name
  ( drop_page ) &> /dev/null
  start_record 32 $job_tag
  echo "${yarn_cmd}; logging on ${log_path}"
  ( TIMEFORMAT='%3R'; time $yarn_cmd ) 2>&1 | tee $log_path
  stop_record 32
}

function run_eclipse_job() {
  local job_tag="eclipseGrep-250gb-128mb-1"
  ( drop_page ) &> /dev/null
  start_record 32 $job_tag
  local eclipse_cmd="ssh ravenleader -lyoungmoon01 '/home/youngmoon01/mr_storage/app/grep'"
  local log_path="/home/wb/hadoop/eval/logs/${job_tag}.log"
  echo $eclipse_cmd
  ( TIMEFORMAT='%3R'; time $eclipse_cmd ) 2>&1 | tee $log_path
  stop_record 32
}
function run_eclipse_job_WPF() {
  local job_tag="eclipseGrepWPF-250gb-128mb-1"
  ( drop_page ) &> /dev/null
  start_record 32 $job_tag
  local eclipse_cmd="ssh ravenleader -lyoungmoon01 '/home/youngmoon01/mr_storage/app/grep'"
  local log_path="/home/wb/hadoop/eval/logs/${job_tag}.log"
  echo $eclipse_cmd
  ( TIMEFORMAT='%3R'; time $eclipse_cmd ) 2>&1 | tee $log_path
  stop_record 32
}
function run_eclipse_job_WTO() {
  local job_tag="eclipseGrepWTO-250gb-128mb-1"
  ( drop_page ) &> /dev/null
  start_record 32 $job_tag
  local eclipse_cmd="ssh ravenleader -lyoungmoon01 '/home/youngmoon01/mr_storage/app/grep'"
  local log_path="/home/wb/hadoop/eval/logs/${job_tag}.log"
  echo $eclipse_cmd
  ( TIMEFORMAT='%3R'; time $eclipse_cmd ) 2>&1 | tee $log_path
  stop_record 32
}
function run_eclipse_job_WTOWPF() {
  local job_tag="eclipseGrepWTOWPF-250gb-128mb-1"
  ( drop_page ) &> /dev/null
  start_record 32 $job_tag
  local eclipse_cmd="ssh ravenleader -lyoungmoon01 '/home/youngmoon01/mr_storage/app/grep'"
  local log_path="/home/wb/hadoop/eval/logs/${job_tag}.log"
  echo $eclipse_cmd
  ( TIMEFORMAT='%3R'; time $eclipse_cmd ) 2>&1 | tee $log_path
  stop_record 32
}


function multiple_job() {
  local block_size=$1
  yarn jar $HADOOP_EXAMPLE_JAR wordcount /64gb_text_$block_size /wcOutput &
  yarn jar $HADOOP_EXAMPLE_JAR grep /250gb_text_$block_size /grepOutput 'good' &
  yarn jar $HADOOP_EXAMPLE_JAR terasort /64gb_seq_$block_size /sortOutput &
  wait
}

function run_multiple_job() {
# $1=block_size, $2=run_id
  local block_size=$1
  local run_id=$2
  local job_tag="wcGrepSort-assorted-${block_size}-${run_id}"

  local job_cmd="multiple_job ${block_size}"
  local log_path="/home/wb/hadoop/eval/logs/${job_tag}.log"

  rm_output "wc"
  rm_output "grep"
  rm_output "sort"
  ( drop_page ) &> /dev/null
  start_record 32 $job_tag
  echo "${job_cmd}; logging on ${log_path}"
  ( TIMEFORMAT='%3R'; time $job_cmd ) 2>&1 | tee $log_path
  stop_record 32
}

run_eclipse_job
run_eclipse_job_WPF
run_eclipse_job_WTO
run_eclipse_job_WTOWPF

# for block_size in $(sh block_size_it.sh); do
#   run_multiple_job $block_size 1
# done

function job_name_it() {
  echo "grep"
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

# for (( run_id=4; run_id<17; ++run_id )); do
# run_id=2
# for job_name in $(job_name_it); do
#   for data_size in $(data_size_it); do
#     for block_size in $(block_size_it); do
#       [[ $job_name == "sort" ]] && input_infix="seq" || input_infix="text"
#       [[ $job_name == "grep" ]] && args="'good'" || args=""
#       run_job example $job_name $data_size $block_size $input_infix $run_id $args
#     done
#   done
# done
# done

# sh avg-time.sh
# sh collect-dstat.sh
# sh avg-dstat.sh
