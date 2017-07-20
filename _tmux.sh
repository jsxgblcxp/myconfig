tmux_ad_video_ini()
{
        tmux new-session -s all_ad_server -n ad_server  -d  ""  \;    \
                split-window -p 67  ""\; \
                split-window -t 1 -p 50  ""  \;  \
                split-window -t 1 -h  -p 50  ""  \;  \

        tmux new-window -t all_ad_server -n ad_server_root  -d ""; 

        tmux select-window -t :1     \;                             \
                split-window -p 67  ""\; \
                split-window -t 1 -p 50  ""  \;  \
                split-window -t 1 -h  -p 50  ""  \;  \


        tmux attach -t all_ad_server
}

alias at0='tmux attach -t 0'
alias at1='tmux attach -t 1'
alias at2='tmux attach -t 2'
alias at3='tmux attach -t 3'
alias at4='tmux attach -t 4'
alias at5='tmux attach -t 5'
alias at6='tmux attach -t 6'
alias at7='tmux attach -t 7'
alias at8='tmux attach -t 8'
alias at9='tmux attach -t 9'
