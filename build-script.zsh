#/usr/bin/env zsh

build='docker build . -t nvim-computer'

run='docker run -it nvim-computer bash'


eval $build & 


# Get the PID of the last command
build_pid=$!

# Tell me what the PID is
echo "Build PID:$build_pid"


echo "Waiting for PID to finish"
wait $build_pid

# Tel me if the build was successful
if [ $? -eq 0 ]; then
    # If build succeeded, run the container
    echo "Running the container"
    eval $run
else
    echo "Build failed, container will not run."
fi

