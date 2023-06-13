import argparse

import attr
from dotenv import load_dotenv


@attr.s
class Predict:
    """
    A prediction class

    :param string env_path: path to the .env file

    """

    env_path = attr.ib()

    def __attrs_post_init__(self):
        """""
        This function is called automatically when the class is instantiated
        """ ""
        self.env = load_dotenv(self.env_path)

    def main(self):
        pass

    @staticmethod
    def save_data(data):
        """Template data saving function (PROBABLY NEEDS TO BE CHANGED DEPENDING ON THE DATA)

        Args:
            data (_type_): _description_
        """
        data.to_csv("data/model_output/predictions.csv", index=False)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Preprocess the data")
    parser.add_argument("--env_path", default=".env", help="path to .env file")
    args = parser.parse_args()
    preprocess = Predict(env_path=args.env_path)
    preprocess.main()
