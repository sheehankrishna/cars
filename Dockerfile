FROM python:3.6-slim-stretch

RUN apt update
RUN apt install -y python3-dev gcc

# Install pytorch and fastai
# RUN pip install torch_nightly -f https://download.pytorch.org/whl/nightly/cpu/torch_nightly.html
RUN pip install "torch==1.4" "torchvision==0.5.0"
RUN pip install fastai

# Install starlette and uvicorn
RUN pip install starlette uvicorn python-multipart aiohttp

ADD cars.py cars.py
ADD cars-stage12.pth cars-stage-1.pth

# Run it once to trigger resnet download
RUN python cars.py

EXPOSE 8008

# Start the server
CMD ["python", "cars.py", "serve"]
