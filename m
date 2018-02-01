From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Fwd: Build failed in Jenkins: ceph-master #1732
Date: Thu, 1 Feb 2018 10:19:39 +0100
Message-ID: <f0846f5e-d8d4-2c3c-3b8b-dec7375e4ec6@digiware.nl>
References: <436047127.48.1517471296783.JavaMail.jenkins@cephdev.digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:31640 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751628AbeBAJTn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Feb 2018 04:19:43 -0500
In-Reply-To: <436047127.48.1517471296783.JavaMail.jenkins@cephdev.digiware.nl>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Casey Bodley <cbodley@redhat.com>

Hi Casey,

Current testing is broken on FreeBSD in unittest_log:
[==========] Running 15 tests from 1 test case.
[----------] Global test environment set-up.
[----------] 15 tests from Log
[ RUN      ] Log.Simple
[       OK ] Log.Simple (31 ms)
[ RUN      ] Log.ReuseBad

Where you fixed some trouble.
Any suggestions where to look how to fix this on FreeBSD?

Thanx,
--WjW



-------- Forwarded Message --------
Subject: Build failed in Jenkins: ceph-master #1732
Date: Thu, 1 Feb 2018 08:48:11 +0100 (CET)
From: jenkins@digiware.nl
Reply-To: jenkins@digiware.nl
To: wjw@digiware.nl

See 
<http://cephdev.digiware.nl:8180/jenkins/job/ceph-master/1732/display/redirect?page=changes>

Changes:

[dillaman] osd/OSDMap: expose require_min_compat_client variable

[dillaman] librados: getter for min compatible client versions

[xie.xingguo] mgr/balancer: pool-specific optimization support

[ncutler] build/ops: rpm: fix _defined_if_python2_absent conditional

[cbodley] test/log: add failing unit test for reuse of bad stream

[xie.xingguo] pybind/mgr/balancer: re-initialize everything on 
instantiating a new

[tone.zhang] cmake: fix libcephfs-test.jar build failure

[xie.xingguo] pybind/mgr/balancer: do not dirty compat_ws on error out

[xie.xingguo] pybind/mgr/balancer: fix sanity check against minimal pg 
numbers per

[guzhongyan] common/pick_address: wrong prefix_len in pick_iface() With 
prefix_len

[kchai] crushtool: add --add-bucket

[kchai] crushtool: add --move

[kchai] crush/CrushWrapper: lower log level of check_item_loc()

[kchai] test/cli/crushtool: add test for --add-bucket and --move

[cbodley] log: clear thread-local stream's ios flags on reuse

------------------------------------------
[...truncated 3.67 MB...]
         Start 125: unittest_osd_types
         Start 126: unittest_ecbackend
111/145 Test #125: unittest_osd_types ......................   Passed 
1.37 sec
         Start 127: unittest_osdscrub
112/145 Test #126: unittest_ecbackend ......................   Passed 
3.97 sec
         Start 128: unittest_pglog
113/145 Test #127: unittest_osdscrub .......................   Passed 
4.22 sec
         Start 129: unittest_hitset
114/145 Test #129: unittest_hitset .........................   Passed 
1.38 sec
         Start 130: unittest_osd_osdcap
115/145 Test #130: unittest_osd_osdcap .....................   Passed 
2.94 sec
         Start 131: unittest_extent_cache
116/145 Test #131: unittest_extent_cache ...................   Passed 
1.38 sec
117/145 Test #105: unittest_erasure_code_shec_thread .......   Passed 
62.12 sec
         Start 132: unittest_pg_transaction
         Start 133: unittest_ec_transaction
118/145 Test #133: unittest_ec_transaction .................   Passed 
1.13 sec
119/145 Test #132: unittest_pg_transaction .................   Passed 
1.34 sec
         Start 134: unittest_mclock_op_class_queue
         Start 135: unittest_mclock_client_queue
120/145 Test   #7: unittest_bufferlist.sh ..................   Passed 
115.11 sec
121/145 Test #128: unittest_pglog ..........................   Passed 
12.17 sec
         Start 136: test_ceph_daemon.py
         Start 137: test_ceph_argparse.py
122/145 Test   #6: smoke.sh ................................***Failed 
117.17 sec
123/145 Test #136: test_ceph_daemon.py .....................   Passed 
1.33 sec
         Start 138: unittest_rgw_bencode
         Start 139: unittest_rgw_period_history
124/145 Test #139: unittest_rgw_period_history .............   Passed 
0.41 sec
125/145 Test  #25: unittest_bufferlist .....................   Passed 
114.27 sec
126/145 Test #138: unittest_rgw_bencode ....................   Passed 
0.52 sec
127/145 Test #135: unittest_mclock_client_queue ............   Passed 
5.26 sec
         Start 140: unittest_rgw_compression
         Start 141: unittest_http_manager
         Start 142: unittest_rgw_crypto
         Start 143: unittest_rgw_iam_policy
128/145 Test #141: unittest_http_manager ...................   Passed 
0.73 sec
129/145 Test #134: unittest_mclock_op_class_queue ..........   Passed 
8.10 sec
         Start 144: unittest_rgw_string
         Start 145: unittest_rbd_mirror
130/145 Test #143: unittest_rgw_iam_policy .................   Passed 
2.59 sec
131/145 Test #144: unittest_rgw_string .....................   Passed 
2.09 sec
132/145 Test #142: unittest_rgw_crypto .....................   Passed 
5.68 sec
133/145 Test   #4: test_objectstore_memstore.sh ............   Passed 
131.79 sec
134/145 Test #140: unittest_rgw_compression ................   Passed 
12.66 sec
135/145 Test #137: test_ceph_argparse.py ...................   Passed 
68.73 sec
136/145 Test #145: unittest_rbd_mirror .....................   Passed 
142.61 sec
137/145 Test #117: ceph_test_object_map ....................   Passed 
209.75 sec
138/145 Test   #3: run-cli-tests ...........................   Passed 
283.66 sec
139/145 Test  #91: check-generated.sh ......................   Passed 
313.51 sec
140/145 Test   #2: rbd-ggate.sh ............................   Passed 
486.54 sec
141/145 Test  #92: readable.sh .............................   Passed 
481.21 sec
142/145 Test #123: safe-to-destroy.sh ......................   Passed 
491.42 sec
143/145 Test   #8: run-tox-ceph-disk .......................   Passed 
625.87 sec
144/145 Test #104: unittest_erasure_code_shec_all ..........   Passed 
612.66 sec
145/145 Test   #1: run-rbd-unit-tests.sh ...................   Passed 
832.62 sec

99% tests passed, 2 tests failed out of 145

Total Test time (real) = 833.07 sec

The following tests FAILED:
	  6 - smoke.sh (Failed)
	 17 - unittest_log (SEGFAULT)
Errors while running CTest
+ RETEST=1

echo "Testing result, retest: = " $RETEST
+ echo 'Testing result, retest: = ' 1
Testing result, retest: =  1

if [ $RETEST -eq 1 ]; then
     # make sure no leftovers are there
     killall ceph-osd || true
     killall ceph-mgr || true
     killall ceph-mds || true
     killall ceph-mon || true
     rm -rf td/* src/test/td/* || true
     ctest --output-on-failure --rerun-failed
fi
+ [ 1 -eq 1 ]
+ killall ceph-osd
No matching processes belonging to you were found
+ true
+ killall ceph-mgr
No matching processes belonging to you were found
+ true
+ killall ceph-mds
No matching processes belonging to you were found
+ true
+ killall ceph-mon
No matching processes belonging to you were found
+ true
+ rm -rf 'td/*' 'src/test/td/*'
+ ctest --output-on-failure --rerun-failed
Test project /home/jenkins/workspace/ceph-master/build
     Start  6: smoke.sh
1/2 Test  #6: smoke.sh .........................   Passed  156.86 sec
     Start 17: unittest_log
2/2 Test #17: unittest_log .....................***Exception: SegFault 
0.36 sec
2018-02-01 08:48:08.309 800ae1000 -1 did not load config file, using 
default settings.
2018-02-01 08:48:08.309 800ae1000 -1 Errors while parsing config file!
2018-02-01 08:48:08.309 800ae1000 -1 parse_file: cannot open 
/etc/ceph/ceph.conf: (2) No such file or directory
2018-02-01 08:48:08.309 800ae1000 -1 parse_file: cannot open 
~/.ceph/ceph.conf: (2) No such file or directory
2018-02-01 08:48:08.309 800ae1000 -1 parse_file: cannot open ceph.conf: 
(2) No such file or directory
2018-02-01 08:48:08.309 800ae1000 -1 parse_file: cannot open 
/usr/local/etc/ceph/ceph.conf: (2) No such file or directory
2018-02-01 08:48:08.319 800ae1000 -1 Errors while parsing config file!
2018-02-01 08:48:08.319 800ae1000 -1 parse_file: cannot open 
/etc/ceph/ceph.conf: (2) No such file or directory
2018-02-01 08:48:08.319 800ae1000 -1 parse_file: cannot open 
~/.ceph/ceph.conf: (2) No such file or directory
2018-02-01 08:48:08.319 800ae1000 -1 parse_file: cannot open ceph.conf: 
(2) No such file or directory
2018-02-01 08:48:08.319 800ae1000 -1 parse_file: cannot open 
/usr/local/etc/ceph/ceph.conf: (2) No such file or directory
[==========] Running 15 tests from 1 test case.
[----------] Global test environment set-up.
[----------] 15 tests from Log
[ RUN      ] Log.Simple
[       OK ] Log.Simple (1 ms)
[ RUN      ] Log.ReuseBad
*** Caught signal (Segmentation fault) **
  in thread 800ae1000 thread_name:
  ceph version Development (no_version) mimic (dev)
  1: <ceph::BackTrace::BackTrace(int)+0x6c> at 
/home/jenkins/workspace/ceph-master/build/bin/unittest_log
  2: <handle_fatal_signal(int)+0xcf> at 
/home/jenkins/workspace/ceph-master/build/bin/unittest_log
  3: <pthread_sigmask()+0x536> at /lib/libthr.so.3
2018-02-01 08:48:08.339 800ae1000 -1 *** Caught signal (Segmentation 
fault) **
  in thread 800ae1000 thread_name:

  ceph version Development (no_version) mimic (dev)
  1: <ceph::BackTrace::BackTrace(int)+0x6c> at 
/home/jenkins/workspace/ceph-master/build/bin/unittest_log
  2: <handle_fatal_signal(int)+0xcf> at 
/home/jenkins/workspace/ceph-master/build/bin/unittest_log
  3: <pthread_sigmask()+0x536> at /lib/libthr.so.3
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- begin dump of recent events ---
    -30> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command perfcounters_dump hook 0x800afe250
    -29> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command 1 hook 0x800afe250
    -28> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command perf dump hook 0x800afe250
    -27> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command perfcounters_schema hook 0x800afe250
    -26> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command perf histogram dump hook 0x800afe250
    -25> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command 2 hook 0x800afe250
    -24> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command perf schema hook 0x800afe250
    -23> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command perf histogram schema hook 0x800afe250
    -22> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command perf reset hook 0x800afe250
    -21> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command config show hook 0x800afe250
    -20> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command config help hook 0x800afe250
    -19> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command config set hook 0x800afe250
    -18> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command config get hook 0x800afe250
    -17> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command config diff hook 0x800afe250
    -16> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command config diff get hook 0x800afe250
    -15> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command log flush hook 0x800afe250
    -14> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command log dump hook 0x800afe250
    -13> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command log reopen hook 0x800afe250
    -12> 2018-02-01 08:48:08.309 800ae1000  5 asok(0x800d41000) 
register_command dump_mempools hook 0x800da4488
    -11> 2018-02-01 08:48:08.309 800ae1000 -1 did not load config file, 
using default settings.
    -10> 2018-02-01 08:48:08.309 800ae1000 -1 Errors while parsing 
config file!
     -9> 2018-02-01 08:48:08.309 800ae1000 -1 parse_file: cannot open 
/etc/ceph/ceph.conf: (2) No such file or directory
     -8> 2018-02-01 08:48:08.309 800ae1000 -1 parse_file: cannot open 
~/.ceph/ceph.conf: (2) No such file or directory
     -7> 2018-02-01 08:48:08.309 800ae1000 -1 parse_file: cannot open 
ceph.conf: (2) No such file or directory
     -6> 2018-02-01 08:48:08.309 800ae1000 -1 parse_file: cannot open 
/usr/local/etc/ceph/ceph.conf: (2) No such file or directory
     -5> 2018-02-01 08:48:08.319 800ae1000 -1 Errors while parsing 
config file!
     -4> 2018-02-01 08:48:08.319 800ae1000 -1 parse_file: cannot open 
/etc/ceph/ceph.conf: (2) No such file or directory
     -3> 2018-02-01 08:48:08.319 800ae1000 -1 parse_file: cannot open 
~/.ceph/ceph.conf: (2) No such file or directory
     -2> 2018-02-01 08:48:08.319 800ae1000 -1 parse_file: cannot open 
ceph.conf: (2) No such file or directory
     -1> 2018-02-01 08:48:08.319 800ae1000 -1 parse_file: cannot open 
/usr/local/etc/ceph/ceph.conf: (2) No such file or directory
      0> 2018-02-01 08:48:08.339 800ae1000 -1 *** Caught signal 
(Segmentation fault) **
  in thread 800ae1000 thread_name:

  ceph version Development (no_version) mimic (dev)
  1: <ceph::BackTrace::BackTrace(int)+0x6c> at 
/home/jenkins/workspace/ceph-master/build/bin/unittest_log
  2: <handle_fatal_signal(int)+0xcf> at 
/home/jenkins/workspace/ceph-master/build/bin/unittest_log
  3: <pthread_sigmask()+0x536> at /lib/libthr.so.3
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.

--- logging levels ---
    0/ 5 none
    0/ 1 lockdep
    0/ 1 context
    1/ 1 crush
    1/ 5 mds
    1/ 5 mds_balancer
    1/ 5 mds_locker
    1/ 5 mds_log
    1/ 5 mds_log_expire
    1/ 5 mds_migrator
    0/ 1 buffer
    0/ 1 timer
    0/ 1 filer
    0/ 1 striper
    0/ 1 objecter
    0/ 5 rados
    0/ 5 rbd
    0/ 5 rbd_mirror
    0/ 5 rbd_replay
    0/ 5 journaler
    0/ 5 objectcacher
    0/ 5 client
    1/ 5 osd
    0/ 5 optracker
    0/ 5 objclass
    1/ 3 filestore
    1/ 3 journal
    0/ 0 ms
    1/ 5 mon
    0/10 monc
    1/ 5 paxos
    0/ 5 tp
    1/ 5 auth
    1/ 5 crypto
    1/ 1 finisher
    1/ 1 reserver
    1/ 5 heartbeatmap
    1/ 5 perfcounter
    1/ 5 rgw
    1/ 5 rgw_sync
    1/10 civetweb
    1/ 5 javaclient
    1/ 5 asok
    1/ 1 throttle
    0/ 0 refs
    1/ 5 xio
    1/ 5 compressor
    1/ 5 bluestore
    1/ 5 bluefs
    1/ 3 bdev
    1/ 5 kstore
    4/ 5 rocksdb
    4/ 5 leveldb
    4/ 5 memdb
    1/ 5 kinetic
    1/ 5 fuse
    1/ 5 mgr
    1/ 5 mgrc
    1/ 5 dpdk
    1/ 5 eventtrace
   -2/-2 (syslog threshold)
   99/99 (stderr threshold)
   max_recent       500
   max_new         1000
   log_file --- end dump of recent events ---


50% tests passed, 1 tests failed out of 2

Total Test time (real) = 157.24 sec

The following tests FAILED:
	 17 - unittest_log (SEGFAULT)
Errors while running CTest
Build step 'Execute shell' marked build as failure
