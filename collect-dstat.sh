WB_DSTAT_DIR=/scratch2/wb/eval/hadoop_dstat
function collect_dstat() {
  # job_name=$1
  # data_size=$2
  # block_size=$3
  # run_id=$4
  for (( i=0; i<=32; i++ )); do
    case $i in
      0)
        host="ravenleader"
        ;;
      *)
        (( $i < 10 )) && host="raven0${i}" || host="raven${i}"
        ;;
    esac
    # job_tag="${job_name}-${data_size}-${block_size}-${run_id}"
    scp ${host}:${WB_DSTAT_DIR}/sort-64gb-*gb-1-${host}.csv ravenleader:~/hadoop/eval/dstat/.
  done
}

# collect_dstat "wc" "250gb" "4mb" "1"
collect_dstat

function job_name_it() {
  echo "sort"
}
function data_size_it() {
  echo "64gb"
}
function block_size_it() {
  echo "1gb"
  echo "2gb"
}
