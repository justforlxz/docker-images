FROM nvidia/cuda:12.3.1-runtime-ubuntu22.04 AS builder

RUN apt-get update && apt-get -y install git python3-pip python3-venv
RUN git clone https://github.com/comfyanonymous/ComfyUI /ComfyUI --depth 1

WORKDIR /ComfyUI

COPY . .

RUN python3 -m venv venv && \
    . venv/bin/activate && \
    pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu121 && \
    pip install -r requirements.txt && \
    rm -rf /ComfyUI/.git

FROM nvidia/cuda:12.3.1-runtime-ubuntu22.04

RUN apt-get update && \
    apt-get -y install python3-pip python3-venv

COPY --from=builder /ComfyUI /
COPY entrypoint.sh /

WORKDIR /ComfyUI

ENTRYPOINT ["/entrypoint.sh"]
