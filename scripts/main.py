import logging
import logging.config
from datetime import datetime
from pathlib import Path

from pybioimage.frap import Analyzer
from pybioimage.utils import find_files

# Define script constants.
INPUT: Path = Path("data", "raw")
OUTPUT: Path = Path("data", "processed")
LOGGING_CONFIG = {
    "version": 1,
    "formatters": {
        "detailed": {
            "class": "logging.Formatter",
            "format": "%(asctime)s %(name)-15s %(levelname)-8s %(processName)-15s %(message)s",
        }
    },
    "handlers": {
        "console": {
            "class": "logging.StreamHandler",
            "level": "DEBUG",
            "formatter": "detailed",
        },
        "file": {
            "class": "logging.FileHandler",
            "level": "INFO",
            "filename": str(Path("log", datetime.now().strftime("%Y-%m-%d_%H-%M-%S") + ".log")),
            "mode": "w",
            "formatter": "detailed",
        },
    },
    "loggers": {"pybioimage": {"level": "INFO", "propagate": True}},
    "root": {"level": "INFO", "handlers": ["console", "file"]},
}


def main():
    """Analyze FRAP movies of tricellular junctions"""

    logging.config.dictConfig(LOGGING_CONFIG)
    logger = logging.getLogger()

    n = 0

    for file in find_files(INPUT, "movie_avg.tif"):
        logger.info("Analyzing: %s", file)

        dst = OUTPUT.joinpath(file.parent.name)
        dst.mkdir(parents=True, exist_ok=True)

        intensities = Analyzer(file, prebleach_frames=3, interval=0.5).analyze()

        if intensities is not None:
            logger.info("Writing 'intensities.csv'.")
            intensities.to_csv(dst.joinpath("intensities.csv"), index=False)

        n += 1

    logger.info("Analyzed %d images.", n)


if __name__ == "__main__":

    main()
