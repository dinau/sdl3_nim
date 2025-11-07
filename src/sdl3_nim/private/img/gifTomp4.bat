
set name=%~n1
ffmpeg -i "%name%".mp4  -vf scale=640:-1   "%name%".gif

ffmpeg -i "%name%".gif -movflags faststart -pix_fmt yuv420p -vf "scale=trunc(iw/2)*2:trunc(ih/2)*2" "%name%".mp4
