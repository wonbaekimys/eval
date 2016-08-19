#include <iostream>
#include <map>
#include <unordered_map>
#include <set>
#include <unordered_set>
#include <vector>
#include <string>
#include <fstream>
#include <algorithm>
#include <iomanip>
#include <numeric>
#include <valarray>

using namespace std;

int main(int argc, char **argv) {

  int num_run = 4;
  // vector<string> job_name({"wc", "grep"});
  // vector<string> job_name({"wc", "grep", "sort"});
  vector<string> job_name({"sort"});
  vector<string> data_size({"64gb", "250gb"});
  vector<string> block_size({"32mb", "64mb", "128mb", "256mb", "512mb", "1gb",
        "2gb"});
  map<string, int> h2mb;
  h2mb.emplace("32mb", 32);
  h2mb.emplace("64mb", 64);
  h2mb.emplace("128mb", 128);
  h2mb.emplace("256mb", 256);
  h2mb.emplace("512mb", 512);
  h2mb.emplace("1gb", 1024);
  h2mb.emplace("2gb", 2048);

  for (auto &tmp_job_name : job_name) {
    string csv_path="/home/wb/hadoop/eval/time/time-blocksize-" + tmp_job_name +
        ".csv";
    ofstream os(csv_path, ofstream::out);
    // ostream os(cout.rdbuf());
    os << "blocksize,";
    for (auto &tmp_data_size : data_size) {
      os << tmp_job_name + "-" + tmp_data_size << ",ylow,yhigh,";
    }
    os << endl;
    for (auto &tmp_block_size : block_size) {
      os << h2mb[tmp_block_size] << ",";
      for (auto &tmp_data_size : data_size) {
        vector<double> times;
        // multiset<double> times;
        for (int i = 0; i < num_run; ++i) {
          string log_path = "/home/wb/hadoop/eval/logs/" + tmp_job_name + "-" +
              tmp_data_size + "-" + tmp_block_size + "-" + to_string(i + 1) +
              ".log";
          ifstream is(log_path, ifstream::in);
          if (!is.good()) break;

          is.seekg(-2, is.end);
          int length = is.tellg();
          string record;
          while (true) {
            char ch;
            is.get(ch);
            if (ch == '\n') break;
            record+=ch;
            is.seekg(-2, is.cur);
          }
          is.close();
          reverse(record.begin(), record.end());
          double time = stod(record);
          // block_time.emplace(tmp_block_size, time);
          // block_time[h2mb[tmp_block_size]].emplace(time);
          times.push_back(time);
        }
        sort(times.begin(), times.end());
        double median = times[times.size() / 2];
        double ylow = times[0];
        double yhigh = times[times.size() - 1];
        os << fixed << setprecision(3) << median << "," << ylow << ","
            << yhigh << ",";
        // int ssize = times.size();
        // int num_dis = ssize * 0.25;
        // auto sit = times.begin();
        // auto eit = times.end();
        // for (int i = 0; i < num_dis; ++i) {
        //   ++sit;
        //   --eit;
        // }
        // double sum;
        // double min;
        // double max;
        // min = *min_element(sit, eit);
        // max = *max_element(sit, eit);
        // sum = accumulate(sit, eit, 0.0);
        // double avg = sum / distance(sit, eit);
        // os << fixed << setprecision(3) << avg << "," << min << "," << max <<
        //     ",";
      }
      os << endl;
    }
    os.close();
  }
  return 0;
}
