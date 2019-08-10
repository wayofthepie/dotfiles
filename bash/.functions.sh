psg () {
  local find=$1
  ps aux | awk "NR ==1 || /.*${find}.*/"
}
