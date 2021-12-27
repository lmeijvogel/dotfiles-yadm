#include <stdio.h>
#include <string.h>

int check_params(int argc, char **argv);

int MAX_PARAM_LENGTH = 8;

void unauthorize_and_authorize_device(char *path_part);
int contains_invalid_chars(char *input);

int main(int argc, char** argv) {
  int result = check_params(argc, argv);

  if (result != 0) {
    return result;
  }

  unauthorize_and_authorize_device(argv[1]);
}

int check_params(int argc, char **argv) {
  if (argc != 2) {
    printf("Usage: writer <usb_device_path>\n");
    return 1;
  }
  char *path_part = argv[1];

  if (strlen(path_part) > MAX_PARAM_LENGTH) {
    printf("Param too long!\n");
    return 2;
  }

  if (contains_invalid_chars(path_part)) {
    printf("Param contains invalid chars!\n");
    return 3;
  }

  return 0;
}

int contains_invalid_chars(char *input) {
  char *VALID_CHARS = "abcdefghijklmnopqrstuvwxyz:.-01234567890";

  int input_length = strlen(input);

  for (int index_in_input = 0 ; index_in_input < input_length ; index_in_input++) {
    char current_char = input[index_in_input];
    if (!strchr(VALID_CHARS, current_char)) {
      return 1;
    }
  }

  return 0;
}

void unauthorize_and_authorize_device(char *path_part) {
  char to_path[32 + MAX_PARAM_LENGTH];

  //                          1         2           3
  //                012345678901234567890  12345678901
  sprintf(to_path, "/sys/bus/usb/devices/%s/authorized", path_part);

  printf("Toggling device at %s\n", to_path);

  // Enable for debugging
  /* sprintf(to_path, "/tmp/%s", path_part); */

  FILE *handle = fopen(to_path, "w");

  fprintf(handle, "0");
  fclose(handle);

  handle = fopen(to_path, "w");

  fprintf(handle, "1");
  fclose(handle);
}
