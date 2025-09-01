import sys
import zstandard as zstd
import tarfile
import os
import shutil
from pathlib import Path

file_path = "./vndb-db-latest.tar.zst"
extract_path = "./extract_files"

def decompress_and_extract():
    try:
        with open(file_path, 'rb') as comp_file:

            decompresser = zstd.ZstdDecompressor()
            
            with decompresser.stream_reader(comp_file) as reader:
                with tarfile.open(fileobj=reader, mode="r|") as tar:
                    tar.extractall(extract_path)

            print(f"Successfully extracted file {file_path} to path {extract_path}")
    except IOError as e:
        print(f'Decomrpession or extraction failed: {e}')
        sys.exit(1)
    except OSError as e:
        print(f"An error occured during zst decompression: {e}")
        sys.exit(1)


def remove_file(path: str):
    try:
        os.remove(path)
        print(f"Successfully deleted file: {path}")
    except FileNotFoundError as e:
        print(f"File deletion failed for file {path}: {e}")
        return
    except IOError as e:
        print(f"An IOError occured during file deletion for file {path}: {e}")
        sys.exit(1)


def copy_file(src: str, dst: str):
    try:

        if (Path(dst).exists()):
            print(f"File already exists at destination: {dst}")
            print("Skipping copy operation...")
            return

        shutil.copy(src, dst)
        print(f"Successfully copied file: {src} to destination: {dst}")
    except Exception as e:
        print(f"Failed to copy file to: {dst}. Error: {e}")
        sys.exit(1)

try:

    os.makedirs(os.path.dirname(extract_path), exist_ok=True)

    decompress_and_extract()

    remove_file(extract_path + "/import.sql")
    remove_file(extract_path + "/schema_plain.sql")

    custom_import = "custom_import.sql"
    copy_file(custom_import, extract_path + "/" + custom_import)


except Exception as e:
    print(f"An unhandled exception occured during script execution: {e}")
    sys.exit(1)
