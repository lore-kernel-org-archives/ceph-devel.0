From: scan-admin@coverity.com
Subject: New Defects reported by Coverity Scan for ceph
Date: Wed, 19 Apr 2017 22:34:10 -0700
Message-ID: <58f84852999bf_139972f330517b6@ss1435.mail>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from o2.lv30e.shared.sendgrid.net ([50.31.63.43]:47832 "EHLO
        o2.lv30e.shared.sendgrid.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1764035AbdDTFeP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 20 Apr 2017 01:34:15 -0400
Received: from coverity.com (static-208.69.177.245.nephosdns.com [208.69.177.245])
        by ismtpd0005p1iad1.sendgrid.net (SG) with ESMTP id E9MVniNQTpCjdxE8ajNm0w
        for <ceph-devel@vger.kernel.org>; Thu, 20 Apr 2017 05:34:11.364 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi,

Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.

148 new defect(s) introduced to ceph found with Coverity Scan.
24 defect(s), reported by Coverity Scan earlier, were marked fixed in the recent build analyzed by Coverity Scan.

New defect(s) Reported-by: Coverity Scan
Showing 20 of 148 defect(s)


** CID 717204:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/client/Client.cc: 300 in Client::Client(Messenger *, MonClient *)()


________________________________________________________________________________________________________
*** CID 717204:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/client/Client.cc: 300 in Client::Client(Messenger *, MonClient *)()
294     				  cct->_conf->client_oc_max_dirty,
295     				  cct->_conf->client_oc_target_dirty,
296     				  cct->_conf->client_oc_max_dirty_age,
297     				  true);
298       objecter_finisher.start();
299       filer = new Filer(objecter, &objecter_finisher);
>>>     CID 717204:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "root_ancestor" is not initialized in this constructor nor in any functions that it calls.
300     }
301     
302     
303     Client::~Client()
304     {
305       assert(!client_lock.is_locked());

** CID 717207:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/client/MetaRequest.h: 93 in MetaRequest::MetaRequest(int)()


________________________________________________________________________________________________________
*** CID 717207:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/client/MetaRequest.h: 93 in MetaRequest::MetaRequest(int)()
87         kick(false), success(false),
88         got_unsafe(false), item(this), unsafe_item(this),
89         unsafe_dir_item(this), unsafe_target_item(this),
90         caller_cond(0), dispatch_cond(0) {
91         memset(&head, 0, sizeof(head));
92         head.op = op;
>>>     CID 717207:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "dirp" is not initialized in this constructor nor in any functions that it calls.
93       }
94       ~MetaRequest();
95     
96       /**
97        * Prematurely terminate the request, such that callers
98        * to make_request will receive `rc` as their result.

** CID 717264:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/messages/MClientReply.h: 128 in InodeStat::InodeStat()()


________________________________________________________________________________________________________
*** CID 717264:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/messages/MClientReply.h: 128 in InodeStat::InodeStat()()
122       bufferlist inline_data;
123       version_t inline_version;
124     
125       quota_info_t quota;
126     
127      public:
>>>     CID 717264:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "inline_version" is not initialized in this constructor nor in any functions that it calls.
128       InodeStat() {}
129       InodeStat(bufferlist::iterator& p, uint64_t features) {
130         decode(p, features);
131       }
132     
133       void decode(bufferlist::iterator &p, uint64_t features) {

** CID 728001:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/osd/PG.cc: 998 in PG::Scrubber::Scrubber()()


________________________________________________________________________________________________________
*** CID 728001:  Uninitialized members  (UNINIT_CTOR)
/home/brad/working/src/ceph/src/osd/PG.cc: 998 in PG::Scrubber::Scrubber()()
992        must_scrub(false), must_deep_scrub(false), must_repair(false),
993        auto_repair(false),
994        num_digest_updates_pending(0),
995        state(INACTIVE),
996        deep(false),
997        seed(0)
>>>     CID 728001:  Uninitialized members  (UNINIT_CTOR)
>>>     Non-static class member "priority" is not initialized in this constructor nor in any functions that it calls.
998     {}
999     
1000     PG::Scrubber::~Scrubber() {}
1001     
1002     /**
1003      * find_best_info

** CID 1219624:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/ceph_fuse.cc: 73 in main()
/home/brad/working/src/ceph/src/ceph_fuse.cc: 73 in main()
/home/brad/working/src/ceph/src/ceph_fuse.cc: 73 in main()


________________________________________________________________________________________________________
*** CID 1219624:    (UNCAUGHT_EXCEPT)
/home/brad/working/src/ceph/src/ceph_fuse.cc: 73 in main()
67     "                    use root_directory as the mounted root, rather than the full Ceph tree.\n"
68     "\n";
69       fuse_usage();
70       generic_client_usage();
71     }
72     
>>>     CID 1219624:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **, char const **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
73     int main(int argc, const char **argv, const char *envp[]) {
74       int filer_flags = 0;
75       //cerr << "ceph-fuse starting " << myrank << "/" << world << std::endl;
76       std::vector<const char*> args;
77       argv_to_vec(argc, argv, args);
78       if (args.empty()) {
/home/brad/working/src/ceph/src/ceph_fuse.cc: 73 in main()
67     "                    use root_directory as the mounted root, rather than the full Ceph tree.\n"
68     "\n";
69       fuse_usage();
70       generic_client_usage();
71     }
72     
>>>     CID 1219624:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **, char const **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
73     int main(int argc, const char **argv, const char *envp[]) {
74       int filer_flags = 0;
75       //cerr << "ceph-fuse starting " << myrank << "/" << world << std::endl;
76       std::vector<const char*> args;
77       argv_to_vec(argc, argv, args);
78       if (args.empty()) {
/home/brad/working/src/ceph/src/ceph_fuse.cc: 73 in main()
67     "                    use root_directory as the mounted root, rather than the full Ceph tree.\n"
68     "\n";
69       fuse_usage();
70       generic_client_usage();
71     }
72     
>>>     CID 1219624:    (UNCAUGHT_EXCEPT)
>>>     In function "main(int, char const **, char const **)" an exception of type "ceph::buffer::bad_alloc" is thrown and never caught.
73     int main(int argc, const char **argv, const char *envp[]) {
74       int filer_flags = 0;
75       //cerr << "ceph-fuse starting " << myrank << "/" << world << std::endl;
76       std::vector<const char*> args;
77       argv_to_vec(argc, argv, args);
78       if (args.empty()) {

** CID 1297734:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 414 in SyntheticClient::run()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 824 in SyntheticClient::run()()


________________________________________________________________________________________________________
*** CID 1297734:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 414 in SyntheticClient::run()()
408         case SYNCLIENT_MODE_RANDOMSLEEP:
409           {
410             int iarg1 = iargs.front();
411             iargs.pop_front();
412             if (run_me()) {
413               srand(time(0) + getpid() + client->whoami.v);
>>>     CID 1297734:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
414               sleep(rand() % iarg1);
415             }
416     	did_run_me();
417           }
418           break;
419     
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 824 in SyntheticClient::run()()
818     
819         case SYNCLIENT_MODE_OPENTEST:
820           {
821             int count = iargs.front();  iargs.pop_front();
822             if (run_me()) {
823               for (int i=0; i<count; i++) {
>>>     CID 1297734:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
824                 int fd = client->open("test", (rand()%2) ?
825     				  (O_WRONLY|O_CREAT) : O_RDONLY,
826     				  perms);
827                 if (fd > 0) client->close(fd);
828               }
829             }

** CID 1297743:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.h: 126 in SyntheticClient::get_random_fh()()


________________________________________________________________________________________________________
*** CID 1297743:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.h: 126 in SyntheticClient::get_random_fh()()
120         contents.clear();
121         subdirs.clear();
122         did_readdir = false;
123       }
124     
125       int get_random_fh() {
>>>     CID 1297743:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
126         int r = rand() % open_files.size();
127         set<int>::iterator it = open_files.begin();
128         while (r--) ++it;
129         return *it;
130       }
131     

** CID 1297748:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.h: 136 in SyntheticClient::get_random_subdir()()


________________________________________________________________________________________________________
*** CID 1297748:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.h: 136 in SyntheticClient::get_random_subdir()()
130       }
131     
132     
133       filepath n1;
134       const char *get_random_subdir() {
135         assert(!subdirs.empty());
>>>     CID 1297748:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
136         int r = ((rand() % subdirs.size()) + (rand() % subdirs.size())) / 2;  // non-uniform distn
137         set<string>::iterator it = subdirs.begin();
138         while (r--) ++it;
139     
140         n1 = cwd;
141         n1.push_dentry( *it );

** CID 1297749:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2354 in SyntheticClient::object_rw(int, int, int, int, double, double)()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2351 in SyntheticClient::object_rw(int, int, int, int, double, double)()


________________________________________________________________________________________________________
*** CID 1297749:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2354 in SyntheticClient::object_rw(int, int, int, int, double, double)()
2348         if (time_to_stop()) break;
2349         
2350         // read or write?
2351         bool write = (rand() % 100) < wrpc;
2352     
2353         // choose object
>>>     CID 1297749:    (DC.WEAK_CRYPTO)
>>>     "drand48()" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2354         double r = drand48(); // [0..1)
2355         long o;
2356         if (write) {
2357           o = (long)trunc(pow(r, wskew) * (double)nobj);  // exponentially skew towards 0
2358           int pnoremap = (long)(r * 100.0);
2359           if (pnoremap >= overlappc) 
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2351 in SyntheticClient::object_rw(int, int, int, int, double, double)()
2345       int unack = 0;
2346     
2347       while (1) {
2348         if (time_to_stop()) break;
2349         
2350         // read or write?
>>>     CID 1297749:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2351         bool write = (rand() % 100) < wrpc;
2352     
2353         // choose object
2354         double r = drand48(); // [0..1)
2355         long o;
2356         if (write) {

** CID 1297751:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2531 in normdist(int, int, int)()


________________________________________________________________________________________________________
*** CID 1297751:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2531 in normdist(int, int, int)()
2525          curve */
2526       
2527       stdev += 1; /* compensation for integer vs. floating point math */
2528       for (int c = iterate; c != 0; c--) /* loop through iterations */
2529         {
2530           //  result += (uniform (1, 100) * stdev) / 100; /* calculate and
>>>     CID 1297751:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2531           result += ( (rand()%100 + 1)  * stdev) / 100;
2532           // printf("result=%d\n", result );
2533         }
2534       printf("\n final result=%d\n", result );
2535       return result + min; /* send final result back */
2536     }

** CID 1297761:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.h: 163 in SyntheticClient::make_sub(const char *)()


________________________________________________________________________________________________________
*** CID 1297761:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.h: 163 in SyntheticClient::make_sub(const char *)()
157         return n2.get_path().c_str();
158       }
159       
160       filepath sub;
161       char sub_s[50];
162       const char *make_sub(const char *base) {
>>>     CID 1297761:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
163         snprintf(sub_s, sizeof(sub_s), "%s.%d", base, rand() % 100);
164         string f = sub_s;
165         sub = cwd;
166         sub.push_dentry(f);
167         return sub.c_str();
168       }

** CID 1297765:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/include/Distribution.h: 54 in Distribution::sample()()


________________________________________________________________________________________________________
*** CID 1297765:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/include/Distribution.h: 54 in Distribution::sample()()
48         }
49         for (unsigned i=0; i<p.size(); i++) 
50           p[i] /= sum;
51       }
52     
53       int sample() {
>>>     CID 1297765:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
54         float s = (float)(rand() % 10000) / 10000.0;
55         for (unsigned i=0; i<p.size(); i++) {
56           if (s < p[i]) return v[i];
57           s -= p[i];
58         }
59         ceph_abort();

** CID 1297767:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.h: 147 in SyntheticClient::get_random_sub()()


________________________________________________________________________________________________________
*** CID 1297767:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.h: 147 in SyntheticClient::get_random_sub()()
141         n1.push_dentry( *it );
142         return n1.get_path().c_str();
143       }
144       filepath n2;
145       const char *get_random_sub() {
146         assert(!contents.empty());
>>>     CID 1297767:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
147         int r = ((rand() % contents.size()) + (rand() % contents.size())) / 2;  // non-uniform distn
148         if (cwd.depth() && cwd.last_dentry().length()) 
149           r += cwd.last_dentry().c_str()[0];                                         // slightly permuted
150         r %= contents.size();
151     
152         map<string,struct stat*>::iterator it = contents.begin();

** CID 1297786:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 959 in roll_die(float)()


________________________________________________________________________________________________________
*** CID 1297786:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 959 in roll_die(float)()
953       return 0;
954     }
955     
956     
957     bool roll_die(float p) 
958     {
>>>     CID 1297786:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
959       float r = (float)(rand() % 100000) / 100000.0;
960       if (r < p) 
961         return true;
962       else 
963         return false;
964     }

** CID 1297788:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2847 in SyntheticClient::make_dir_mess(const char *, int)()


________________________________________________________________________________________________________
*** CID 1297788:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2847 in SyntheticClient::make_dir_mess(const char *, int)()
2841       //  P(dir) ~ subdirs_of(dir) + 2
2842       // from 5-year metadata workload paper in fast'07
2843     
2844       // create dirs
2845       for (int i=0; i<n; i++) {
2846         // pick a dir
>>>     CID 1297788:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2847         int k = rand() % dirs.size();
2848         string parent = dirs[k];
2849         
2850         // pick a name
2851         std::stringstream ss;
2852         ss << parent << "/" << i;

** CID 1297794:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2934 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2935 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2936 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2950 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2951 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2952 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2953 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2954 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2955 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2970 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2971 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2972 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2973 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2974 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2975 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2985 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2986 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2987 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2988 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2989 in SyntheticClient::foo()()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2990 in SyntheticClient::foo()()


________________________________________________________________________________________________________
*** CID 1297794:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2934 in SyntheticClient::foo()()
2928       }
2929       if (1) {
2930         // open some files
2931         srand(0);
2932         for (int i=0; i<20; i++) {
2933           int s = 5;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2934           int a = rand() % s;
2935           int b = rand() % s;
2936           int c = rand() % s;
2937           char src[80];
2938           snprintf(src, sizeof(src), "syn.0.0/dir.%d/dir.%d/file.%d", a, b, c);
2939           //int fd = 
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2935 in SyntheticClient::foo()()
2929       if (1) {
2930         // open some files
2931         srand(0);
2932         for (int i=0; i<20; i++) {
2933           int s = 5;
2934           int a = rand() % s;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2935           int b = rand() % s;
2936           int c = rand() % s;
2937           char src[80];
2938           snprintf(src, sizeof(src), "syn.0.0/dir.%d/dir.%d/file.%d", a, b, c);
2939           //int fd = 
2940           client->open(src, O_RDONLY, perms);
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2936 in SyntheticClient::foo()()
2930         // open some files
2931         srand(0);
2932         for (int i=0; i<20; i++) {
2933           int s = 5;
2934           int a = rand() % s;
2935           int b = rand() % s;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2936           int c = rand() % s;
2937           char src[80];
2938           snprintf(src, sizeof(src), "syn.0.0/dir.%d/dir.%d/file.%d", a, b, c);
2939           //int fd = 
2940           client->open(src, O_RDONLY, perms);
2941         }
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2950 in SyntheticClient::foo()()
2944       }
2945     
2946       if (0) {
2947         // rename fun
2948         for (int i=0; i<100; i++) {
2949           int s = 5;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2950           int a = rand() % s;
2951           int b = rand() % s;
2952           int c = rand() % s;
2953           int d = rand() % s;
2954           int e = rand() % s;
2955           int f = rand() % s;
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2951 in SyntheticClient::foo()()
2945     
2946       if (0) {
2947         // rename fun
2948         for (int i=0; i<100; i++) {
2949           int s = 5;
2950           int a = rand() % s;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2951           int b = rand() % s;
2952           int c = rand() % s;
2953           int d = rand() % s;
2954           int e = rand() % s;
2955           int f = rand() % s;
2956           char src[80];
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2952 in SyntheticClient::foo()()
2946       if (0) {
2947         // rename fun
2948         for (int i=0; i<100; i++) {
2949           int s = 5;
2950           int a = rand() % s;
2951           int b = rand() % s;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2952           int c = rand() % s;
2953           int d = rand() % s;
2954           int e = rand() % s;
2955           int f = rand() % s;
2956           char src[80];
2957           char dst[80];
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2953 in SyntheticClient::foo()()
2947         // rename fun
2948         for (int i=0; i<100; i++) {
2949           int s = 5;
2950           int a = rand() % s;
2951           int b = rand() % s;
2952           int c = rand() % s;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2953           int d = rand() % s;
2954           int e = rand() % s;
2955           int f = rand() % s;
2956           char src[80];
2957           char dst[80];
2958           snprintf(src, sizeof(src), "syn.0.0/dir.%d/dir.%d/file.%d", a, b, c);
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2954 in SyntheticClient::foo()()
2948         for (int i=0; i<100; i++) {
2949           int s = 5;
2950           int a = rand() % s;
2951           int b = rand() % s;
2952           int c = rand() % s;
2953           int d = rand() % s;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2954           int e = rand() % s;
2955           int f = rand() % s;
2956           char src[80];
2957           char dst[80];
2958           snprintf(src, sizeof(src), "syn.0.0/dir.%d/dir.%d/file.%d", a, b, c);
2959           snprintf(dst, sizeof(dst), "syn.0.0/dir.%d/dir.%d/file.%d", d, e, f);
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2955 in SyntheticClient::foo()()
2949           int s = 5;
2950           int a = rand() % s;
2951           int b = rand() % s;
2952           int c = rand() % s;
2953           int d = rand() % s;
2954           int e = rand() % s;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2955           int f = rand() % s;
2956           char src[80];
2957           char dst[80];
2958           snprintf(src, sizeof(src), "syn.0.0/dir.%d/dir.%d/file.%d", a, b, c);
2959           snprintf(dst, sizeof(dst), "syn.0.0/dir.%d/dir.%d/file.%d", d, e, f);
2960           client->rename(src, dst, perms);
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2970 in SyntheticClient::foo()()
2964     
2965       if (1) {
2966         // link fun
2967         srand(0);
2968         for (int i=0; i<100; i++) {
2969           int s = 5;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2970           int a = rand() % s;
2971           int b = rand() % s;
2972           int c = rand() % s;
2973           int d = rand() % s;
2974           int e = rand() % s;
2975           int f = rand() % s;
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2971 in SyntheticClient::foo()()
2965       if (1) {
2966         // link fun
2967         srand(0);
2968         for (int i=0; i<100; i++) {
2969           int s = 5;
2970           int a = rand() % s;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2971           int b = rand() % s;
2972           int c = rand() % s;
2973           int d = rand() % s;
2974           int e = rand() % s;
2975           int f = rand() % s;
2976           char src[80];
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2972 in SyntheticClient::foo()()
2966         // link fun
2967         srand(0);
2968         for (int i=0; i<100; i++) {
2969           int s = 5;
2970           int a = rand() % s;
2971           int b = rand() % s;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2972           int c = rand() % s;
2973           int d = rand() % s;
2974           int e = rand() % s;
2975           int f = rand() % s;
2976           char src[80];
2977           char dst[80];
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2973 in SyntheticClient::foo()()
2967         srand(0);
2968         for (int i=0; i<100; i++) {
2969           int s = 5;
2970           int a = rand() % s;
2971           int b = rand() % s;
2972           int c = rand() % s;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2973           int d = rand() % s;
2974           int e = rand() % s;
2975           int f = rand() % s;
2976           char src[80];
2977           char dst[80];
2978           snprintf(src, sizeof(src), "syn.0.0/dir.%d/dir.%d/file.%d", a, b, c);
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2974 in SyntheticClient::foo()()
2968         for (int i=0; i<100; i++) {
2969           int s = 5;
2970           int a = rand() % s;
2971           int b = rand() % s;
2972           int c = rand() % s;
2973           int d = rand() % s;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2974           int e = rand() % s;
2975           int f = rand() % s;
2976           char src[80];
2977           char dst[80];
2978           snprintf(src, sizeof(src), "syn.0.0/dir.%d/dir.%d/file.%d", a, b, c);
2979           snprintf(dst, sizeof(dst), "syn.0.0/dir.%d/dir.%d/newlink.%d", d, e, f);
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2975 in SyntheticClient::foo()()
2969           int s = 5;
2970           int a = rand() % s;
2971           int b = rand() % s;
2972           int c = rand() % s;
2973           int d = rand() % s;
2974           int e = rand() % s;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2975           int f = rand() % s;
2976           char src[80];
2977           char dst[80];
2978           snprintf(src, sizeof(src), "syn.0.0/dir.%d/dir.%d/file.%d", a, b, c);
2979           snprintf(dst, sizeof(dst), "syn.0.0/dir.%d/dir.%d/newlink.%d", d, e, f);
2980           client->link(src, dst, perms);
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2985 in SyntheticClient::foo()()
2979           snprintf(dst, sizeof(dst), "syn.0.0/dir.%d/dir.%d/newlink.%d", d, e, f);
2980           client->link(src, dst, perms);
2981         }
2982         srand(0);
2983         for (int i=0; i<100; i++) {
2984           int s = 5;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2985           int a = rand() % s;
2986           int b = rand() % s;
2987           int c = rand() % s;
2988           int d = rand() % s;
2989           int e = rand() % s;
2990           int f = rand() % s;
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2986 in SyntheticClient::foo()()
2980           client->link(src, dst, perms);
2981         }
2982         srand(0);
2983         for (int i=0; i<100; i++) {
2984           int s = 5;
2985           int a = rand() % s;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2986           int b = rand() % s;
2987           int c = rand() % s;
2988           int d = rand() % s;
2989           int e = rand() % s;
2990           int f = rand() % s;
2991           char src[80];
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2987 in SyntheticClient::foo()()
2981         }
2982         srand(0);
2983         for (int i=0; i<100; i++) {
2984           int s = 5;
2985           int a = rand() % s;
2986           int b = rand() % s;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2987           int c = rand() % s;
2988           int d = rand() % s;
2989           int e = rand() % s;
2990           int f = rand() % s;
2991           char src[80];
2992           char dst[80];
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2988 in SyntheticClient::foo()()
2982         srand(0);
2983         for (int i=0; i<100; i++) {
2984           int s = 5;
2985           int a = rand() % s;
2986           int b = rand() % s;
2987           int c = rand() % s;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2988           int d = rand() % s;
2989           int e = rand() % s;
2990           int f = rand() % s;
2991           char src[80];
2992           char dst[80];
2993           snprintf(src, sizeof(src), "syn.0.0/dir.%d/dir.%d/file.%d", a, b, c);
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2989 in SyntheticClient::foo()()
2983         for (int i=0; i<100; i++) {
2984           int s = 5;
2985           int a = rand() % s;
2986           int b = rand() % s;
2987           int c = rand() % s;
2988           int d = rand() % s;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2989           int e = rand() % s;
2990           int f = rand() % s;
2991           char src[80];
2992           char dst[80];
2993           snprintf(src, sizeof(src), "syn.0.0/dir.%d/dir.%d/file.%d", a, b, c);
2994           snprintf(dst, sizeof(dst), "syn.0.0/dir.%d/dir.%d/newlink.%d", d, e, f);
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 2990 in SyntheticClient::foo()()
2984           int s = 5;
2985           int a = rand() % s;
2986           int b = rand() % s;
2987           int c = rand() % s;
2988           int d = rand() % s;
2989           int e = rand() % s;
>>>     CID 1297794:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
2990           int f = rand() % s;
2991           char src[80];
2992           char dst[80];
2993           snprintf(src, sizeof(src), "syn.0.0/dir.%d/dir.%d/file.%d", a, b, c);
2994           snprintf(dst, sizeof(dst), "syn.0.0/dir.%d/dir.%d/newlink.%d", d, e, f);
2995           client->unlink(dst, perms);

** CID 1297796:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/mds/MDCache.h: 1143 in MDCache::hack_pick_random_inode()()


________________________________________________________________________________________________________
*** CID 1297796:  Security best practices violations  (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/mds/MDCache.h: 1143 in MDCache::hack_pick_random_inode()()
1137      public:
1138       void show_cache();
1139       void show_subtrees(int dbl=10);
1140     
1141       CInode *hack_pick_random_inode() {
1142         assert(!inode_map.empty());
>>>     CID 1297796:  Security best practices violations  (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
1143         int n = rand() % inode_map.size();
1144         ceph::unordered_map<vinodeno_t,CInode*>::iterator p = inode_map.begin();
1145         while (n--) ++p;
1146         return p->second;
1147       }
1148     

** CID 1297800:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3075 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3077 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3082 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3091 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3109 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3113 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3121 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3125 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3130 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3161 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3163 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3167 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3173 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3175 in SyntheticClient::thrash_links(const char *, int, int, int, int)()


________________________________________________________________________________________________________
*** CID 1297800:    (DC.WEAK_CRYPTO)
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3075 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
3069     
3070       srand(0);
3071       if (1) {
3072         bool renames = true; // thrash renames too?
3073         for (int k=0; k<n; k++) {
3074           
>>>     CID 1297800:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3075           if (renames && rand() % 10 == 0) {
3076     	// rename some directories.  whee!
3077     	int dep = (rand() % depth) + 1;
3078     	string src = basedir;
3079     	{
3080     	  char t[80];
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3077 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
3071       if (1) {
3072         bool renames = true; // thrash renames too?
3073         for (int k=0; k<n; k++) {
3074           
3075           if (renames && rand() % 10 == 0) {
3076     	// rename some directories.  whee!
>>>     CID 1297800:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3077     	int dep = (rand() % depth) + 1;
3078     	string src = basedir;
3079     	{
3080     	  char t[80];
3081     	  for (int d=0; d<dep; d++) {
3082     	    int a = rand() % dirs;
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3082 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
3076     	// rename some directories.  whee!
3077     	int dep = (rand() % depth) + 1;
3078     	string src = basedir;
3079     	{
3080     	  char t[80];
3081     	  for (int d=0; d<dep; d++) {
>>>     CID 1297800:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3082     	    int a = rand() % dirs;
3083     	    snprintf(t, sizeof(t), "/dir.%d", a);
3084     	    src += t;
3085     	  }
3086     	}
3087     	string dst = basedir;
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3091 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
3085     	  }
3086     	}
3087     	string dst = basedir;
3088     	{
3089     	  char t[80];
3090     	  for (int d=0; d<dep; d++) {
>>>     CID 1297800:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3091     	    int a = rand() % dirs;
3092     	    snprintf(t, sizeof(t), "/dir.%d", a);
3093     	    dst += t;
3094     	  }
3095     	}
3096     	
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3109 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
3103           
3104           // pick a dest dir
3105           string src = basedir;
3106           {
3107     	char t[80];
3108     	for (int d=0; d<depth; d++) {
>>>     CID 1297800:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3109     	  int a = rand() % dirs;
3110     	  snprintf(t, sizeof(t), "/dir.%d", a);
3111     	  src += t;
3112     	}
3113     	int a = rand() % files;
3114     	snprintf(t, sizeof(t), "/file.%d", a);
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3113 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
3107     	char t[80];
3108     	for (int d=0; d<depth; d++) {
3109     	  int a = rand() % dirs;
3110     	  snprintf(t, sizeof(t), "/dir.%d", a);
3111     	  src += t;
3112     	}
>>>     CID 1297800:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3113     	int a = rand() % files;
3114     	snprintf(t, sizeof(t), "/file.%d", a);
3115     	src += t;
3116           }
3117           string dst = basedir;
3118           {
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3121 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
3115     	src += t;
3116           }
3117           string dst = basedir;
3118           {
3119     	char t[80];
3120     	for (int d=0; d<depth; d++) {
>>>     CID 1297800:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3121     	  int a = rand() % dirs;
3122     	  snprintf(t, sizeof(t), "/dir.%d", a);
3123     	  dst += t;
3124     	}
3125     	int a = rand() % files;
3126     	snprintf(t, sizeof(t), "/file.%d", a);
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3125 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
3119     	char t[80];
3120     	for (int d=0; d<depth; d++) {
3121     	  int a = rand() % dirs;
3122     	  snprintf(t, sizeof(t), "/dir.%d", a);
3123     	  dst += t;
3124     	}
>>>     CID 1297800:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3125     	int a = rand() % files;
3126     	snprintf(t, sizeof(t), "/file.%d", a);
3127     	dst += t;
3128           }
3129           
3130           int o = rand() % 4;
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3130 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
3124     	}
3125     	int a = rand() % files;
3126     	snprintf(t, sizeof(t), "/file.%d", a);
3127     	dst += t;
3128           }
3129           
>>>     CID 1297800:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3130           int o = rand() % 4;
3131           switch (o) {
3132           case 0: 
3133     	client->mknod(src.c_str(), 0755, perms);
3134     	if (renames) client->rename(src.c_str(), dst.c_str(), perms);
3135     	break;
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3161 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
3155           char f[20];
3156           
3157           // pick a file
3158           string file = basedir;
3159           
3160           if (depth) {
>>>     CID 1297800:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3161     	int d = rand() % (depth+1);
3162     	for (int k=0; k<d; k++) {
3163     	  snprintf(f, sizeof(f), "/dir.%d", rand() % dirs);
3164     	  file += f;
3165     	}
3166           }
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3163 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
3157           // pick a file
3158           string file = basedir;
3159           
3160           if (depth) {
3161     	int d = rand() % (depth+1);
3162     	for (int k=0; k<d; k++) {
>>>     CID 1297800:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3163     	  snprintf(f, sizeof(f), "/dir.%d", rand() % dirs);
3164     	  file += f;
3165     	}
3166           }
3167           snprintf(f, sizeof(f), "/file.%d", rand() % files);
3168           file += f;
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3167 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
3161     	int d = rand() % (depth+1);
3162     	for (int k=0; k<d; k++) {
3163     	  snprintf(f, sizeof(f), "/dir.%d", rand() % dirs);
3164     	  file += f;
3165     	}
3166           }
>>>     CID 1297800:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3167           snprintf(f, sizeof(f), "/file.%d", rand() % files);
3168           file += f;
3169           
3170           // pick a dir for our link
3171           string ln = basedir;
3172           if (depth) {
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3173 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
3167           snprintf(f, sizeof(f), "/file.%d", rand() % files);
3168           file += f;
3169           
3170           // pick a dir for our link
3171           string ln = basedir;
3172           if (depth) {
>>>     CID 1297800:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3173     	int d = rand() % (depth+1);
3174     	for (int k=0; k<d; k++) {
3175     	  snprintf(f, sizeof(f), "/dir.%d", rand() % dirs);
3176     	  ln += f;
3177     	}
3178           }
/home/brad/working/src/ceph/src/client/SyntheticClient.cc: 3175 in SyntheticClient::thrash_links(const char *, int, int, int, int)()
3169           
3170           // pick a dir for our link
3171           string ln = basedir;
3172           if (depth) {
3173     	int d = rand() % (depth+1);
3174     	for (int k=0; k<d; k++) {
>>>     CID 1297800:    (DC.WEAK_CRYPTO)
>>>     "rand" should not be used for security related applications, as linear congruential algorithms are too easy to break.
3175     	  snprintf(f, sizeof(f), "/dir.%d", rand() % dirs);
3176     	  ln += f;
3177     	}
3178           }
3179           snprintf(f, sizeof(f), "/ln.%d", i);
3180           ln += f;

** CID 1297806:  Program hangs  (INFINITE_LOOP)
/home/brad/working/src/ceph/src/librados/RadosClient.cc: 917 in librados::RadosClient::pg_command(pg_t, std::vector<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>> &, const ceph::buffer::list &, ceph::buffer::list *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *)()


________________________________________________________________________________________________________
*** CID 1297806:  Program hangs  (INFINITE_LOOP)
/home/brad/working/src/ceph/src/librados/RadosClient.cc: 917 in librados::RadosClient::pg_command(pg_t, std::vector<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>, std::allocator<std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>>>> &, const ceph::buffer::list &, ceph::buffer::list *, std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char>> *)()
911       ceph_tid_t tid;
912       lock.Lock();
913       objecter->pg_command(pgid, cmd, inbl, &tid, poutbl, prs,
914     		       new C_SafeCond(&mylock, &cond, &done, &ret));
915       lock.Unlock();
916       mylock.Lock();
>>>     CID 1297806:  Program hangs  (INFINITE_LOOP)
>>>     If "done" is initially false then it will remain false.
917       while (!done)
918         cond.Wait(mylock);
919       mylock.Unlock();
920       return ret;
921     }
922     

** CID 1297808:  Program hangs  (INFINITE_LOOP)
/home/brad/working/src/ceph/src/librados/RadosClient.cc: 743 in librados::RadosClient::pool_delete(const char *)()


________________________________________________________________________________________________________
*** CID 1297808:  Program hangs  (INFINITE_LOOP)
/home/brad/working/src/ceph/src/librados/RadosClient.cc: 743 in librados::RadosClient::pool_delete(const char *)()
737       ret = objecter->delete_pool(name, onfinish);
738     
739       if (ret < 0) {
740         delete onfinish;
741       } else {
742         mylock.Lock();
>>>     CID 1297808:  Program hangs  (INFINITE_LOOP)
>>>     If "done" is initially false then it will remain false.
743         while (!done)
744           cond.Wait(mylock);
745         mylock.Unlock();
746       }
747       return ret;
748     }


________________________________________________________________________________________________________
To view the defects in Coverity Scan visit, https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRaGCnxtQO9E3gxlB2GxVsWFENryh7bC5hIb-2FQBVM85YLQ-3D-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8FM-2Bxn1zjqYZCkhHlCBkOx1Vz0uLM-2FuwLDNBehQ2BDvWcOTkGamZs6pEokobGiq806-2By-2BV2NXD3E-2BdqHwlZLT3BYGFSRnkXKtde76qyalNbQq00lnximbAQohElZErU19YUuo2zvV5HZ2Xyo-2B6EJbkJBr-2FYuIukpf2b-2Bf3D3-2Bs4eB0sZ7FfOf3uEZ6mH8iz3s8-3D

To manage Coverity Scan email notifications for "ceph-devel@vger.kernel.org", click https://u2389337.ct.sendgrid.net/wf/click?upn=08onrYu34A-2BWcWUl-2F-2BfV0V05UPxvVjWch-2Bd2MGckcRbVDbis712qZDP-2FA8y06Nq4Bco8jcmzhh7FSyvoR0E3-2BDgRcBCQ6OuthHBtaTCGNq9zoLsiw8NWrIF2zsdhfTt-2FbHjZ2ToL3Et9v1-2BrDLungAOjHpQtOY-2BsyLiTVCQEUCU-3D_2sw0G7ICm9mxCh1lYW1t9y1lfDrIerWzLwB67LZ-2Bn8FM-2Bxn1zjqYZCkhHlCBkOx1Vz0uLM-2FuwLDNBehQ2BDvWWusjvVvLqEEQz1PxoGnvV4szRZ-2B6087FsnqILien-2F5rjXesn3ZF-2BbCJNq6fRgf5c4m-2F-2F1wgt1Wr-2By78JNfI1Y97M4y1hVoiPoMo4-2B1OFoYneqPN8HlniTnL8uDnBhHMpMDuOjApUEDtmMFt-2FwgcGaA-3D

