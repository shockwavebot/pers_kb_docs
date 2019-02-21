function print_help
{
    cat << END_OF_HELP
Usage: $0 [OPTIONS]

Options:
  Mandatory:
  --env-id=<number>                          Environment ID.
  --type=<string>                            Environment type (Not mandatory if --clean parameter is used).
  Optional:
  --level=<string>                           Software level.
  --project=<string>                         Software project or comma-separated list of projects.
  --files-tag=<path>                         Custom setup files tag.

END_OF_HELP
}

function extract_cmd_parameter_value
{
    echo "${1#*=}"
    return 0
}

function parse_parameters
{
    while [ $# -gt 0 ]; do
        case $1 in
            --env-id=*)
                env_id="$(extract_cmd_parameter_value $1)";;
            --type=*)
                env_type="$(extract_cmd_parameter_value $1)";;
            --level=*)
                level="$(extract_cmd_parameter_value $1)";;
            --project=*)
                project="$(extract_cmd_parameter_value $1)";;
            --help | -h | -?)
                print_help; exit 0;;
            *)
                print_help
                echo_e "Unknown parameter '$1'"
                exit 2;;
        esac
        shift
    done
}


