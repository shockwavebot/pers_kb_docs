# It's possible to use argopt, argopts, or manually create case logic 

############################################################################################################################
# example by using argopt
############################################################################################################################
USAGE="\n
USAGE: $0 [-c|--component] COMPONENT [-r|--rpm] RPM [-d|--duration] DURATION [-t|--target] TARGET \n
\n
Where all arguments are mandatory: \n
\n
\t    -c|--component  C7 components available: | nca | \n
\t    -r|--rpm       \t Intensiti of simulated requests in Requests Per Minute. Value between [1-9600] \n
\t    -d|--duration  \t Duration of simulation in minutes. Less than 480 min (8h) \n
\t    -t|--target    \t Target point in time recovery calculated in minutes back from the end of the simulation \n\n"

[[ $# -lt 8 ]] && echo -e $USAGE && exit 1

args=$(getopt -o c:r:d:t: --long component:,rpm:,duration:,target: -- "$@")
eval set -- "$args"

while true; do
  case "${1}" in
    -c|--component)
      shift
      APP=$1
      regexp="(^nca$)"
      [[ ! "${APP}" =~ ${regexp} ]] && echo "ERROR: Unknown COMPONENT name: ${APP}" && echo -e $USAGE && exit 2
      ;;
    -r|--rpm)
      shift
      RPM=$1
      [[ ! $RPM -le 9600 ]] && echo "ERROR: RPM should be in range from 1 to 9600" && echo -e $USAGE && exit 2
      ;;
    -d|--duration)
      shift
      SIM_DURATION=$1
      [[ ! $SIM_DURATION -lt 480 ]] && echo "ERROR: Duration should be less than 8h (480 min)" && echo -e $USAGE && exit 2
      ;;
    -t|--target)
      shift
      TARGET_PITR=$1
      [[ ! $TARGET_PITR -lt $SIM_DURATION ]] && echo "ERROR: Duration should be longer than target recovery point" && echo -e $USAGE && exit 2
      ;;
    --)
     shift
     break ;;
  esac
  shift
done

############################################################################################################################

