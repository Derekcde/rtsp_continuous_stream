#!/bin/sh

# URL du flux RTSP de la caméra
camera_rtsp="$CAMERA_RTSP"
replacement_video="$REPLACEMENT_VIDEO"

# Paramètres FFmpeg pour la diffusion RTSP
ffmpeg_params="-rtsp_flags listen -max_delay 5000000"

# Lance FFmpeg en arrière-plan pour capturer le flux RTSP
ffmpeg -i "$camera_rtsp" $ffmpeg_params rtsp://0.0.0.0:8554/live &

# En boucle, surveille si FFmpeg est actif
while true; do
    sleep 5  # Attendez un certain temps (par exemple, 5 secondes) avant de vérifier à nouveau

    if ! ps | grep -q '[f]fmpeg'; then
        # Si FFmpeg n'est pas en cours d'exécution, redémarrez-le avec la vidéo de remplacement
        echo "Le flux RTSP de la caméra a échoué. Passage à la vidéo de remplacement..."
        ffmpeg -re -i "$replacement_video" $ffmpeg_params rtsp://0.0.0.0:8554/live &
    fi
done