# One-click reproduction image for the companion notebook
# "Revisiting statistical methods for radiochromic film dosimetry".
#
#   docker build -t radiochromic-film .
#   docker run --rm -p 8888:8888 radiochromic-film
#
# then open the Jupyter URL printed in the terminal and run
# Kernel -> Restart & Run All (deterministic via the fixed SEED).
FROM python:3.11.15-slim

# `zip` is required by the notebook's final cell (! zip -r Figures.zip Figures).
RUN apt-get update && apt-get install -y --no-install-recommends zip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY Revisiting_Statistical_Methods_for_Radiochromic_Film_Dosimetry.ipynb .

EXPOSE 8888
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", \
     "--no-browser", "--allow-root", "--NotebookApp.token="]
