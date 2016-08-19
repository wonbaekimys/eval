for (( i=1; i<=32; i++ )); do
  case $i in
    0)
      host="localhost"
      ;;
    *)
      (( $i >= 10 )) && host="raven${i}" || host="raven0${i}"
      ;;
  esac
  cmd="'pkill -9 dstat'"
  echo "ssh ${host} ${cmd}"
  ssh $host 'pkill -9 dstat' &
done
pkill -9 dstat
