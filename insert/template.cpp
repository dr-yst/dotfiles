// You have to choose include files below.
// Last Updated: <2013/04/10 21:47:01 from Yoshitos-iMac.local by yoshito>
#include <iostream>
#include <iomanip>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <cstdlib>
#include <cassert>
#include <getopt.h>
#include <itpp/itbase.h>
#include <itpp/itcomm.h>
#include <myaudio.h>
#include <myimg.h>
#include <mydsp.h>
#include <mycomm.h>
#include <myutl.h>
#include <mymatrix.h>

static option options[] =
  {
    {"help", no_argument, NULL, 'h'},

    {0, 0, 0, 0}
  };

int main(int argc, char* argv[])
{
  int index;
  int c;

  while((c = getopt_long(argc, argv, "h", options, &index)) != -1){
    switch(c){
    case 'h':
      std::cout << "Usage: This program ...\n"
                << "       -h: Shows this sentences.\n";
      exit(0);

    default:
      std::cerr << "Error: An unknown option is appointed.\n";
      exit(1);
    }
  }

  return 0;
}
