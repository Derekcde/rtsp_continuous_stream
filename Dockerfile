FROM alpine:latest

RUN apk add --no-cache ffmpeg

COPY "rtsp_continuous_stream.sh" "/app/rtsp_continuous_stream.sh"

RUN chmod +x "/app/rtsp_continuous_stream.sh"

WORKDIR "/app"

CMD ["sh", "rtsp_continuous_stream.sh"]