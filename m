From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: data corruption with hammer
Date: Thu, 17 Mar 2016 13:36:33 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603171333440.14377@cpach.fuggernut.com>
References: <CAK9wOaA8_qpK1hNxQmY+zapaEedypzKdrChPUNWL+g-8YwfabQ@mail.gmail.com>
	<CAK9wOaA-o7ypB_O=vfgu=77zRt9HafWymBtsGt7zXpF53JY5Jg@mail.gmail.com>
	<CAK9wOaCTW=KFQE_HN+hon=dG5kxTFFGW78KJ-7h4knqLjiA-ng@mail.gmail.com>
	<def5db51.9Ro.9Gf.cC.1qX1QcBYq7@mailjet.com>
	<alpine.DEB.2.11.1603170823330.14377@cpach.fuggernut.com>
	<CAANLjFrabxuOkkWZrHS6ODmvG1Qx12Q1SeY8BUfQS-fKtOz=iw@mail.gmail.com>
	<alpine.DEB.2.11.1603171018330.14377@cpach.fuggernut.com>
	<CAANLjFoBOb=5_UpyGkp_8c509WkDE4YTo7oQbj5LW4c=v1wb7A@mail.gmail.com>
	<alpine.DEB.2.11.1603171238540.14377@cpach.fuggernut.com>
	<CAANLjFojZYTzsOHF2o6L5kofdEjvuTx3H=yHqtBefD34+5rx5w@mail.gmail.com>
	<CAANLjFpbQ_vyvSAbeuM3xvZznO8spcVKZhS88e+63_vkExxRww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAANLjFpbQ_vyvSAbeuM3xvZznO8spcVKZhS88e+63_vkExxRww-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org>
Cc: Robert LeBlanc <robert.leblanc-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Nick Fisk <nick-ksME7r3P/wO1Qrn1Bg8BZw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, William Perkins <william.perkins-Kvon/JIRTjNl57MIdRCFDg@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Thu, 17 Mar 2016, Robert LeBlanc wrote:
> Also, is this ceph_test_rados rewriting objects quickly? I think that
> the issue is with rewriting objects so if we can tailor the
> ceph_test_rados to do that, it might be easier to reproduce.

It's doing lots of overwrites, yeah.

I was albe to reproduce--thanks!  It looks like it's specific to 
hammer.  The code was rewritten for jewel so it doesn't affect the 
latest.  The problem is that maybe_handle_cache may proxy the read and 
also still try to handle the same request locally (if it doesn't trigger a 
promote).

Here's my proposed fix:

	https://github.com/ceph/ceph/pull/8187

Do you mind testing this branch?

It doesn't appear to be directly related to flipping between writeback and 
forward, although it may be that we are seeing two unrelated issues.  I 
seemed to be able to trigger it more easily when I flipped modes, but the 
bug itself was a simple issue in the writeback mode logic.  :/

Anyway, please see if this fixes it for you (esp with the RBD workload).

Thanks!
sage




> ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> 
> 
> On Thu, Mar 17, 2016 at 11:05 AM, Robert LeBlanc <robert-4JaGZRWAfWbajFs6igw21g@public.gmane.org> wrote:
> > I'll  miss the Ceph community as well. There was a few things I really
> > wanted to work in with Ceph.
> >
> > I got this:
> >
> > update_object_version oid 13 v 1166 (ObjNum 1028 snap 0 seq_num 1028)
> > dirty exists
> > 1038:  left oid 13 (ObjNum 1028 snap 0 seq_num 1028)
> > 1040:  finishing write tid 1 to nodez23350-256
> > 1040:  finishing write tid 2 to nodez23350-256
> > 1040:  finishing write tid 3 to nodez23350-256
> > 1040:  finishing write tid 4 to nodez23350-256
> > 1040:  finishing write tid 6 to nodez23350-256
> > 1035: done (4 left)
> > 1037: done (3 left)
> > 1038: done (2 left)
> > 1043: read oid 430 snap -1
> > 1043:  expect (ObjNum 429 snap 0 seq_num 429)
> > 1040:  finishing write tid 7 to nodez23350-256
> > update_object_version oid 256 v 661 (ObjNum 1029 snap 0 seq_num 1029)
> > dirty exists
> > 1040:  left oid 256 (ObjNum 1029 snap 0 seq_num 1029)
> > 1042:  expect (ObjNum 664 snap 0 seq_num 664)
> > 1043: Error: oid 430 read returned error code -2
> > ./test/osd/RadosModel.h: In function 'virtual void
> > ReadOp::_finish(TestOp::CallbackInfo*)' thread 7fa1bf7fe700 time
> > 2016-03-17 10:47:19.085414
> > ./test/osd/RadosModel.h: 1109: FAILED assert(0)
> > ceph version 0.94.6 (e832001feaf8c176593e0325c8298e3f16dfb403)
> > 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > const*)+0x76) [0x4db956]
> > 2: (ReadOp::_finish(TestOp::CallbackInfo*)+0xec) [0x4c959c]
> > 3: (()+0x9791d) [0x7fa1d472191d]
> > 4: (()+0x72519) [0x7fa1d46fc519]
> > 5: (()+0x13c178) [0x7fa1d47c6178]
> > 6: (()+0x80a4) [0x7fa1d425a0a4]
> > 7: (clone()+0x6d) [0x7fa1d2bd504d]
> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> > needed to interpret this.
> > terminate called after throwing an instance of 'ceph::FailedAssertion'
> > Aborted
> >
> > I had to toggle writeback/forward and min_read_recency_for_promote a
> > few times to get it, but I don't know if it is because I only have one
> > job running. Even with six jobs running, it is not easy to trigger
> > with ceph_test_rados, but it is very instant in the RBD VMs.
> >
> > Here are the six run crashes (I have about the last 2000 lines of each
> > if needed):
> >
> > nodev:
> > update_object_version oid 1015 v 1255 (ObjNum 1014 snap 0 seq_num
> > 1014) dirty exists
> > 1015:  left oid 1015 (ObjNum 1014 snap 0 seq_num 1014)
> > 1016:  finishing write tid 1 to nodev21799-1016
> > 1016:  finishing write tid 2 to nodev21799-1016
> > 1016:  finishing write tid 3 to nodev21799-1016
> > 1016:  finishing write tid 4 to nodev21799-1016
> > 1016:  finishing write tid 6 to nodev21799-1016
> > 1016:  finishing write tid 7 to nodev21799-1016
> > update_object_version oid 1016 v 1957 (ObjNum 1015 snap 0 seq_num
> > 1015) dirty exists
> > 1016:  left oid 1016 (ObjNum 1015 snap 0 seq_num 1015)
> > 1017:  finishing write tid 1 to nodev21799-1017
> > 1017:  finishing write tid 2 to nodev21799-1017
> > 1017:  finishing write tid 3 to nodev21799-1017
> > 1017:  finishing write tid 5 to nodev21799-1017
> > 1017:  finishing write tid 6 to nodev21799-1017
> > update_object_version oid 1017 v 1010 (ObjNum 1016 snap 0 seq_num
> > 1016) dirty exists
> > 1017:  left oid 1017 (ObjNum 1016 snap 0 seq_num 1016)
> > 1018:  finishing write tid 1 to nodev21799-1018
> > 1018:  finishing write tid 2 to nodev21799-1018
> > 1018:  finishing write tid 3 to nodev21799-1018
> > 1018:  finishing write tid 4 to nodev21799-1018
> > 1018:  finishing write tid 6 to nodev21799-1018
> > 1018:  finishing write tid 7 to nodev21799-1018
> > update_object_version oid 1018 v 1093 (ObjNum 1017 snap 0 seq_num
> > 1017) dirty exists
> > 1018:  left oid 1018 (ObjNum 1017 snap 0 seq_num 1017)
> > 1019:  finishing write tid 1 to nodev21799-1019
> > 1019:  finishing write tid 2 to nodev21799-1019
> > 1019:  finishing write tid 3 to nodev21799-1019
> > 1019:  finishing write tid 5 to nodev21799-1019
> > 1019:  finishing write tid 6 to nodev21799-1019
> > update_object_version oid 1019 v 462 (ObjNum 1018 snap 0 seq_num 1018)
> > dirty exists
> > 1019:  left oid 1019 (ObjNum 1018 snap 0 seq_num 1018)
> > 1021:  finishing write tid 1 to nodev21799-1021
> > 1020:  finishing write tid 1 to nodev21799-1020
> > 1020:  finishing write tid 2 to nodev21799-1020
> > 1020:  finishing write tid 3 to nodev21799-1020
> > 1020:  finishing write tid 5 to nodev21799-1020
> > 1020:  finishing write tid 6 to nodev21799-1020
> > update_object_version oid 1020 v 1287 (ObjNum 1019 snap 0 seq_num
> > 1019) dirty exists
> > 1020:  left oid 1020 (ObjNum 1019 snap 0 seq_num 1019)
> > 1021:  finishing write tid 2 to nodev21799-1021
> > 1021:  finishing write tid 3 to nodev21799-1021
> > 1021:  finishing write tid 5 to nodev21799-1021
> > 1021:  finishing write tid 6 to nodev21799-1021
> > update_object_version oid 1021 v 1077 (ObjNum 1020 snap 0 seq_num
> > 1020) dirty exists
> > 1021:  left oid 1021 (ObjNum 1020 snap 0 seq_num 1020)
> > 1022:  finishing write tid 1 to nodev21799-1022
> > 1022:  finishing write tid 2 to nodev21799-1022
> > 1022:  finishing write tid 3 to nodev21799-1022
> > 1022:  finishing write tid 5 to nodev21799-1022
> > 1022:  finishing write tid 6 to nodev21799-1022
> > update_object_version oid 1022 v 1213 (ObjNum 1021 snap 0 seq_num
> > 1021) dirty exists
> > 1022:  left oid 1022 (ObjNum 1021 snap 0 seq_num 1021)
> > 1023:  finishing write tid 1 to nodev21799-1023
> > 1023:  finishing write tid 2 to nodev21799-1023
> > 1023:  finishing write tid 3 to nodev21799-1023
> > 1023:  finishing write tid 5 to nodev21799-1023
> > 1023:  finishing write tid 6 to nodev21799-1023
> > update_object_version oid 1023 v 2612 (ObjNum 1022 snap 0 seq_num
> > 1022) dirty exists
> > 1023:  left oid 1023 (ObjNum 1022 snap 0 seq_num 1022)
> > 1024:  finishing write tid 1 to nodev21799-1024
> > 1025: Error: oid 219 read returned error code -2
> > ./test/osd/RadosModel.h: In function 'virtual void
> > ReadOp::_finish(TestOp::CallbackInfo*)' thread 7f0df8a16700 time
> > 2016-03-17 10:53:43.493575
> > ./test/osd/RadosModel.h: 1109: FAILED assert(0)
> > ceph version 0.94.6 (e832001feaf8c176593e0325c8298e3f16dfb403)
> > 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > const*)+0x76) [0x4db956]
> > 2: (ReadOp::_finish(TestOp::CallbackInfo*)+0xec) [0x4c959c]
> > 3: (()+0x9791d) [0x7f0e015dd91d]
> > 4: (()+0x72519) [0x7f0e015b8519]
> > 5: (()+0x13c178) [0x7f0e01682178]
> > 6: (()+0x80a4) [0x7f0e011160a4]
> > 7: (clone()+0x6d) [0x7f0dffa9104d]
> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> > needed to interpret this.
> > terminate called after throwing an instance of 'ceph::FailedAssertion'
> > Aborted
> >
> > nodew:
> > 1117:  expect (ObjNum 8 snap 0 seq_num 8)
> > 1120:  expect (ObjNum 95 snap 0 seq_num 95)
> > 1121:  expect (ObjNum 994 snap 0 seq_num 994)
> > 1113:  expect (ObjNum 362 snap 0 seq_num 362)
> > 1118:  expect (ObjNum 179 snap 0 seq_num 179)
> > 1115:  expect (ObjNum 943 snap 0 seq_num 943)
> > 1119:  expect (ObjNum 250 snap 0 seq_num 250)
> > 1124:  finishing write tid 1 to nodew21820-361
> > 1124:  finishing write tid 2 to nodew21820-361
> > 1124:  finishing write tid 3 to nodew21820-361
> > 1124:  finishing write tid 4 to nodew21820-361
> > 1124:  finishing write tid 6 to nodew21820-361
> > 1124:  finishing write tid 7 to nodew21820-361
> > update_object_version oid 361 v 892 (ObjNum 1061 snap 0 seq_num 1061)
> > dirty exists
> > 1124:  left oid 361 (ObjNum 1061 snap 0 seq_num 1061)
> > 1125:  finishing write tid 1 to nodew21820-486
> > 1125:  finishing write tid 2 to nodew21820-486
> > 1125:  finishing write tid 3 to nodew21820-486
> > 1125:  finishing write tid 5 to nodew21820-486
> > 1125:  finishing write tid 6 to nodew21820-486
> > update_object_version oid 486 v 1317 (ObjNum 1062 snap 0 seq_num 1062)
> > dirty exists
> > 1125:  left oid 486 (ObjNum 1062 snap 0 seq_num 1062)
> > 1126:  expect (ObjNum 289 snap 0 seq_num 289)
> > 1127:  finishing write tid 1 to nodew21820-765
> > 1127:  finishing write tid 2 to nodew21820-765
> > 1127:  finishing write tid 3 to nodew21820-765
> > 1127:  finishing write tid 5 to nodew21820-765
> > 1127:  finishing write tid 6 to nodew21820-765
> > update_object_version oid 765 v 1156 (ObjNum 1063 snap 0 seq_num 1063)
> > dirty exists
> > 1127:  left oid 765 (ObjNum 1063 snap 0 seq_num 1063)
> > 1128:  finishing write tid 1 to nodew21820-40
> > 1128:  finishing write tid 2 to nodew21820-40
> > 1128:  finishing write tid 3 to nodew21820-40
> > 1128:  finishing write tid 5 to nodew21820-40
> > 1128:  finishing write tid 6 to nodew21820-40
> > update_object_version oid 40 v 876 (ObjNum 1064 snap 0 seq_num 1064)
> > dirty exists
> > 1128:  left oid 40 (ObjNum 1064 snap 0 seq_num 1064)
> > 1129:  expect (ObjNum 616 snap 0 seq_num 616)
> > 1110: done (14 left)
> > 1113: done (13 left)
> > 1115: done (12 left)
> > 1117: done (11 left)
> > 1118: done (10 left)
> > 1119: done (9 left)
> > 1120: done (8 left)
> > 1121: done (7 left)
> > 1124: done (6 left)
> > 1125: done (5 left)
> > 1126: done (4 left)
> > 1127: done (3 left)
> > 1128: done (2 left)
> > 1129: done (1 left)
> > 1131: read oid 29 snap -1
> > 1131:  expect (ObjNum 28 snap 0 seq_num 28)
> > 1132: read oid 764 snap -1
> > 1132:  expect (ObjNum 763 snap 0 seq_num 763)
> > 1133: read oid 469 snap -1
> > 1133:  expect (ObjNum 468 snap 0 seq_num 468)
> > 1134: write oid 243 current snap is 0
> > 1134:  seq_num 1065 ranges
> > {483354=596553,1514502=531232,2509844=632287,3283353=1}
> > 1134:  writing nodew21820-243 from 483354 to 1079907 tid 1
> > 1134:  writing nodew21820-243 from 1514502 to 2045734 tid 2
> > 1134:  writing nodew21820-243 from 2509844 to 3142131 tid 3
> > 1134:  writing nodew21820-243 from 3283353 to 3283354 tid 4
> > 1135: read oid 569 snap -1
> > 1135:  expect (ObjNum 568 snap 0 seq_num 568)
> > 1133: Error: oid 469 read returned error code -2
> > ./test/osd/RadosModel.h: In function 'virtual void
> > ReadOp::_finish(TestOp::CallbackInfo*)' thread 7fae71d03700 time
> > 2016-03-17 11:00:02.124951
> > ./test/osd/RadosModel.h: 1109: FAILED assert(0)
> > ceph version 0.94.6 (e832001feaf8c176593e0325c8298e3f16dfb403)
> > 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > const*)+0x76) [0x4db956]
> > 2: (ReadOp::_finish(TestOp::CallbackInfo*)+0xec) [0x4c959c]
> > 3: (()+0x9791d) [0x7fae7a8ca91d]
> > 4: (()+0x72519) [0x7fae7a8a5519]
> > 5: (()+0x13c178) [0x7fae7a96f178]
> > 6: (()+0x80a4) [0x7fae7a4030a4]
> > 7: (clone()+0x6d) [0x7fae78d7e04d]
> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> > needed to interpret this.
> > terminate called after throwing an instance of 'ceph::FailedAssertion'
> > Aborted
> >
> > nodex:
> >
> > 1024:  finishing write tid 1 to nodex22014-1024
> > 1025:  expect (ObjNum 75 snap 0 seq_num 75)
> > 1024:  finishing write tid 2 to nodex22014-1024
> > 1024:  finishing write tid 3 to nodex22014-1024
> > 1024:  finishing write tid 5 to nodex22014-1024
> > 1024:  finishing write tid 6 to nodex22014-1024
> > update_object_version oid 1024 v 753 (ObjNum 1023 snap 0 seq_num 1023)
> > dirty exists
> > 1024:  left oid 1024 (ObjNum 1023 snap 0 seq_num 1023)
> > 982: done (44 left)
> > 983: done (43 left)
> > 984: done (42 left)
> > 985: done (41 left)
> > 986: done (40 left)
> > 987: done (39 left)
> > 988: done (38 left)
> > 989: done (37 left)
> > 990: done (36 left)
> > 991: done (35 left)
> > 992: done (34 left)
> > 993: done (33 left)
> > 994: done (32 left)
> > 995: done (31 left)
> > 996: done (30 left)
> > 997: done (29 left)
> > 998: done (28 left)
> > 999: done (27 left)
> > 1000: done (26 left)
> > 1001: done (25 left)
> > 1002: done (24 left)
> > 1003: done (23 left)
> > 1004: done (22 left)
> > 1005: done (21 left)
> > 1006: done (20 left)
> > 1007: done (19 left)
> > 1008: done (18 left)
> > 1009: done (17 left)
> > 1010: done (16 left)
> > 1011: done (15 left)
> > 1012: done (14 left)
> > 1013: done (13 left)
> > 1014: done (12 left)
> > 1015: done (11 left)
> > 1016: done (10 left)
> > 1017: done (9 left)
> > 1018: done (8 left)
> > 1019: done (7 left)
> > 1020: done (6 left)
> > 1021: done (5 left)
> > 1022: done (4 left)
> > 1023: done (3 left)
> > 1024: done (2 left)
> > 1025: done (1 left)
> > 1026: done (0 left)
> > 1027: delete oid 101 current snap is 0
> > 1027: done (0 left)
> > 1028: read oid 156 snap -1
> > 1028:  expect (ObjNum 155 snap 0 seq_num 155)
> > 1029: read oid 691 snap -1
> > 1029:  expect (ObjNum 690 snap 0 seq_num 690)
> > 1030: read oid 282 snap -1
> > 1030:  expect (ObjNum 281 snap 0 seq_num 281)
> > 1031: read oid 979 snap -1
> > 1031:  expect (ObjNum 978 snap 0 seq_num 978)
> > 1032: read oid 203 snap -1
> > 1032:  expect (ObjNum 202 snap 0 seq_num 202)
> > 1033: setattr oid 464 current snap is 0
> > 1032: Error: oid 203 read returned error code -2
> > ./test/osd/RadosModel.h: In function 'virtual void
> > ReadOp::_finish(TestOp::CallbackInfo*)' thread 7fafee64a700 time
> > 2016-03-17 10:53:44.291343
> > ./test/osd/RadosModel.h: 1109: FAILED assert(0)
> > ceph version 0.94.6 (e832001feaf8c176593e0325c8298e3f16dfb403)
> > 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > const*)+0x76) [0x4db956]
> > 2: (ReadOp::_finish(TestOp::CallbackInfo*)+0xec) [0x4c959c]
> > 3: (()+0x9791d) [0x7faff721191d]
> > 4: (()+0x72519) [0x7faff71ec519]
> > 5: (()+0x13c178) [0x7faff72b6178]
> > 6: (()+0x80a4) [0x7faff6d4a0a4]
> > 7: (clone()+0x6d) [0x7faff56c504d]
> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> > needed to interpret this.
> > terminate called after throwing an instance of 'ceph::FailedAssertion'
> > Aborted
> >
> > nodey:
> >
> > 974: done (52 left)
> > 975: done (51 left)
> > 976: done (50 left)
> > 977: done (49 left)
> > 978: done (48 left)
> > 979: done (47 left)
> > 980: done (46 left)
> > 981: done (45 left)
> > 982: done (44 left)
> > 983: done (43 left)
> > 984: done (42 left)
> > 985: done (41 left)
> > 986: done (40 left)
> > 987: done (39 left)
> > 988: done (38 left)
> > 989: done (37 left)
> > 990: done (36 left)
> > 991: done (35 left)
> > 992: done (34 left)
> > 993: done (33 left)
> > 994: done (32 left)
> > 995: done (31 left)
> > 996: done (30 left)
> > 997: done (29 left)
> > 998: done (28 left)
> > 999: done (27 left)
> > 1000: done (26 left)
> > 1001: done (25 left)
> > 1002: done (24 left)
> > 1003: done (23 left)
> > 1004: done (22 left)
> > 1005: done (21 left)
> > 1006: done (20 left)
> > 1007: done (19 left)
> > 1008: done (18 left)
> > 1009: done (17 left)
> > 1010: done (16 left)
> > 1011: done (15 left)
> > 1012: done (14 left)
> > 1013: done (13 left)
> > 1014: done (12 left)
> > 1015: done (11 left)
> > 1016: done (10 left)
> > 1017: done (9 left)
> > 1018: done (8 left)
> > 1019: done (7 left)
> > 1020: done (6 left)
> > 1021: done (5 left)
> > 1022: done (4 left)
> > 1023: done (3 left)
> > 1024: done (2 left)
> > 1025: done (1 left)
> > 1026: done (0 left)
> > 1027: delete oid 101 current snap is 0
> > 1027: done (0 left)
> > 1028: read oid 156 snap -1
> > 1028:  expect (ObjNum 155 snap 0 seq_num 155)
> > 1029: read oid 691 snap -1
> > 1029:  expect (ObjNum 690 snap 0 seq_num 690)
> > 1030: read oid 282 snap -1
> > 1030:  expect (ObjNum 281 snap 0 seq_num 281)
> > 1031: read oid 979 snap -1
> > 1031:  expect (ObjNum 978 snap 0 seq_num 978)
> > 1032: read oid 203 snap -1
> > 1032:  expect (ObjNum 202 snap 0 seq_num 202)
> > 1033: setattr oid 464 current snap is 0
> > 1028: Error: oid 156 read returned error code -2
> > ./test/osd/RadosModel.h: In function 'virtual void
> > ReadOp::_finish(TestOp::CallbackInfo*)' thread 7f55fa3c6700 time
> > 2016-03-17 10:53:57.082571
> > ./test/osd/RadosModel.h: 1109: FAILED assert(0)
> > ceph version 0.94.6 (e832001feaf8c176593e0325c8298e3f16dfb403)
> > 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > const*)+0x76) [0x4db956]
> > 2: (ReadOp::_finish(TestOp::CallbackInfo*)+0xec) [0x4c959c]
> > 3: (()+0x9791d) [0x7f5602f8d91d]
> > 4: (()+0x72519) [0x7f5602f68519]
> > 5: (()+0x13c178) [0x7f5603032178]
> > 6: (()+0x80a4) [0x7f5602ac60a4]
> > 7: (clone()+0x6d) [0x7f560144104d]
> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> > needed to interpret this.
> > terminate called after throwing an instance of 'ceph::FailedAssertion'
> > Aborted
> >
> > nodez:
> >
> > 1014: done (11 left)
> > 1026: delete oid 717 current snap is 0
> > 1015:  finishing write tid 2 to nodez24249-1015
> > 1015:  finishing write tid 4 to nodez24249-1015
> > 1015:  finishing write tid 5 to nodez24249-1015
> > update_object_version oid 1015 v 3003 (ObjNum 1014 snap 0 seq_num
> > 1014) dirty exists
> > 1015:  left oid 1015 (ObjNum 1014 snap 0 seq_num 1014)
> > 1016:  finishing write tid 1 to nodez24249-1016
> > 1016:  finishing write tid 2 to nodez24249-1016
> > 1016:  finishing write tid 3 to nodez24249-1016
> > 1016:  finishing write tid 4 to nodez24249-1016
> > 1016:  finishing write tid 6 to nodez24249-1016
> > 1016:  finishing write tid 7 to nodez24249-1016
> > update_object_version oid 1016 v 1201 (ObjNum 1015 snap 0 seq_num
> > 1015) dirty exists
> > 1016:  left oid 1016 (ObjNum 1015 snap 0 seq_num 1015)
> > 1017:  finishing write tid 1 to nodez24249-1017
> > 1017:  finishing write tid 2 to nodez24249-1017
> > 1017:  finishing write tid 3 to nodez24249-1017
> > 1017:  finishing write tid 5 to nodez24249-1017
> > 1017:  finishing write tid 6 to nodez24249-1017
> > update_object_version oid 1017 v 3007 (ObjNum 1016 snap 0 seq_num
> > 1016) dirty exists
> > 1017:  left oid 1017 (ObjNum 1016 snap 0 seq_num 1016)
> > 1018:  finishing write tid 1 to nodez24249-1018
> > 1018:  finishing write tid 2 to nodez24249-1018
> > 1018:  finishing write tid 3 to nodez24249-1018
> > 1018:  finishing write tid 4 to nodez24249-1018
> > 1018:  finishing write tid 6 to nodez24249-1018
> > 1018:  finishing write tid 7 to nodez24249-1018
> > update_object_version oid 1018 v 1283 (ObjNum 1017 snap 0 seq_num
> > 1017) dirty exists
> > 1018:  left oid 1018 (ObjNum 1017 snap 0 seq_num 1017)
> > 1019:  finishing write tid 1 to nodez24249-1019
> > 1019:  finishing write tid 2 to nodez24249-1019
> > 1019:  finishing write tid 3 to nodez24249-1019
> > 1019:  finishing write tid 5 to nodez24249-1019
> > 1019:  finishing write tid 6 to nodez24249-1019
> > update_object_version oid 1019 v 999 (ObjNum 1018 snap 0 seq_num 1018)
> > dirty exists
> > 1019:  left oid 1019 (ObjNum 1018 snap 0 seq_num 1018)
> > 1020:  finishing write tid 1 to nodez24249-1020
> > 1020:  finishing write tid 2 to nodez24249-1020
> > 1020:  finishing write tid 3 to nodez24249-1020
> > 1020:  finishing write tid 5 to nodez24249-1020
> > 1020:  finishing write tid 6 to nodez24249-1020
> > update_object_version oid 1020 v 813 (ObjNum 1019 snap 0 seq_num 1019)
> > dirty exists
> > 1020:  left oid 1020 (ObjNum 1019 snap 0 seq_num 1019)
> > 1021:  finishing write tid 1 to nodez24249-1021
> > 1021:  finishing write tid 2 to nodez24249-1021
> > 1021:  finishing write tid 3 to nodez24249-1021
> > 1021:  finishing write tid 5 to nodez24249-1021
> > 1021:  finishing write tid 6 to nodez24249-1021
> > update_object_version oid 1021 v 1038 (ObjNum 1020 snap 0 seq_num
> > 1020) dirty exists
> > 1021:  left oid 1021 (ObjNum 1020 snap 0 seq_num 1020)
> > 1022:  finishing write tid 1 to nodez24249-1022
> > 1022:  finishing write tid 2 to nodez24249-1022
> > 1022:  finishing write tid 3 to nodez24249-1022
> > 1022:  finishing write tid 5 to nodez24249-1022
> > 1022:  finishing write tid 6 to nodez24249-1022
> > update_object_version oid 1022 v 781 (ObjNum 1021 snap 0 seq_num 1021)
> > dirty exists
> > 1022:  left oid 1022 (ObjNum 1021 snap 0 seq_num 1021)
> > 1023:  finishing write tid 1 to nodez24249-1023
> > 1023:  finishing write tid 2 to nodez24249-1023
> > 1023:  finishing write tid 3 to nodez24249-1023
> > 1023:  finishing write tid 5 to nodez24249-1023
> > 1023:  finishing write tid 6 to nodez24249-1023
> > update_object_version oid 1023 v 1537 (ObjNum 1022 snap 0 seq_num
> > 1022) dirty exists
> > 1023:  left oid 1023 (ObjNum 1022 snap 0 seq_num 1022)
> > 1024:  finishing write tid 1 to nodez24249-1024
> > 1025: Error: oid 230 read returned error code -2
> > ./test/osd/RadosModel.h: In function 'virtual void
> > ReadOp::_finish(TestOp::CallbackInfo*)' thread 7fd9bb7fe700 time
> > 2016-03-17 10:53:41.757921
> > ./test/osd/RadosModel.h: 1109: FAILED assert(0)
> >  ceph version 0.94.6 (e832001feaf8c176593e0325c8298e3f16dfb403)
> >  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > const*)+0x76) [0x4db956]
> >  2: (ReadOp::_finish(TestOp::CallbackInfo*)+0xec) [0x4c959c]
> >  3: (()+0x9791d) [0x7fd9d088d91d]
> >  4: (()+0x72519) [0x7fd9d0868519]
> >  5: (()+0x13c178) [0x7fd9d0932178]
> >  6: (()+0x80a4) [0x7fd9d03c60a4]
> >  7: (clone()+0x6d) [0x7fd9ced4104d]
> >  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> > needed to interpret this.
> > terminate called after throwing an instance of 'ceph::FailedAssertion'
> > Aborted
> >
> > nodezz:
> >
> > 1015:  finishing write tid 1 to nodezz25161-1015
> > 1015:  finishing write tid 2 to nodezz25161-1015
> > 1015:  finishing write tid 4 to nodezz25161-1015
> > 1015:  finishing write tid 5 to nodezz25161-1015
> > update_object_version oid 1015 v 900 (ObjNum 1014 snap 0 seq_num 1014)
> > dirty exists
> > 1015:  left oid 1015 (ObjNum 1014 snap 0 seq_num 1014)
> > 1016:  finishing write tid 1 to nodezz25161-1016
> > 1016:  finishing write tid 2 to nodezz25161-1016
> > 1016:  finishing write tid 3 to nodezz25161-1016
> > 1016:  finishing write tid 4 to nodezz25161-1016
> > 1016:  finishing write tid 6 to nodezz25161-1016
> > 1016:  finishing write tid 7 to nodezz25161-1016
> > update_object_version oid 1016 v 1021 (ObjNum 1015 snap 0 seq_num
> > 1015) dirty exists
> > 1016:  left oid 1016 (ObjNum 1015 snap 0 seq_num 1015)
> > 1017:  finishing write tid 1 to nodezz25161-1017
> > 1017:  finishing write tid 2 to nodezz25161-1017
> > 1017:  finishing write tid 3 to nodezz25161-1017
> > 1017:  finishing write tid 5 to nodezz25161-1017
> > 1017:  finishing write tid 6 to nodezz25161-1017
> > update_object_version oid 1017 v 3011 (ObjNum 1016 snap 0 seq_num
> > 1016) dirty exists
> > 1017:  left oid 1017 (ObjNum 1016 snap 0 seq_num 1016)
> > 1018:  finishing write tid 1 to nodezz25161-1018
> > 1018:  finishing write tid 2 to nodezz25161-1018
> > 1018:  finishing write tid 3 to nodezz25161-1018
> > 1018:  finishing write tid 4 to nodezz25161-1018
> > 1018:  finishing write tid 6 to nodezz25161-1018
> > 1018:  finishing write tid 7 to nodezz25161-1018
> > update_object_version oid 1018 v 1099 (ObjNum 1017 snap 0 seq_num
> > 1017) dirty exists
> > 1018:  left oid 1018 (ObjNum 1017 snap 0 seq_num 1017)
> > 1019:  finishing write tid 1 to nodezz25161-1019
> > 1019:  finishing write tid 2 to nodezz25161-1019
> > 1019:  finishing write tid 3 to nodezz25161-1019
> > 1019:  finishing write tid 5 to nodezz25161-1019
> > 1019:  finishing write tid 6 to nodezz25161-1019
> > update_object_version oid 1019 v 1300 (ObjNum 1018 snap 0 seq_num
> > 1018) dirty exists
> > 1019:  left oid 1019 (ObjNum 1018 snap 0 seq_num 1018)
> > 1020:  finishing write tid 1 to nodezz25161-1020
> > 1020:  finishing write tid 2 to nodezz25161-1020
> > 1020:  finishing write tid 3 to nodezz25161-1020
> > 1020:  finishing write tid 5 to nodezz25161-1020
> > 1020:  finishing write tid 6 to nodezz25161-1020
> > update_object_version oid 1020 v 1324 (ObjNum 1019 snap 0 seq_num
> > 1019) dirty exists
> > 1020:  left oid 1020 (ObjNum 1019 snap 0 seq_num 1019)
> > 1021:  finishing write tid 1 to nodezz25161-1021
> > 1021:  finishing write tid 2 to nodezz25161-1021
> > 1021:  finishing write tid 3 to nodezz25161-1021
> > 1021:  finishing write tid 5 to nodezz25161-1021
> > 1021:  finishing write tid 6 to nodezz25161-1021
> > update_object_version oid 1021 v 890 (ObjNum 1020 snap 0 seq_num 1020)
> > dirty exists
> > 1021:  left oid 1021 (ObjNum 1020 snap 0 seq_num 1020)
> > 1022:  finishing write tid 1 to nodezz25161-1022
> > 1022:  finishing write tid 2 to nodezz25161-1022
> > 1022:  finishing write tid 3 to nodezz25161-1022
> > 1022:  finishing write tid 5 to nodezz25161-1022
> > 1022:  finishing write tid 6 to nodezz25161-1022
> > update_object_version oid 1022 v 464 (ObjNum 1021 snap 0 seq_num 1021)
> > dirty exists
> > 1022:  left oid 1022 (ObjNum 1021 snap 0 seq_num 1021)
> > 1023:  finishing write tid 1 to nodezz25161-1023
> > 1023:  finishing write tid 2 to nodezz25161-1023
> > 1023:  finishing write tid 3 to nodezz25161-1023
> > 1023:  finishing write tid 5 to nodezz25161-1023
> > 1023:  finishing write tid 6 to nodezz25161-1023
> > update_object_version oid 1023 v 1516 (ObjNum 1022 snap 0 seq_num
> > 1022) dirty exists
> > 1023:  left oid 1023 (ObjNum 1022 snap 0 seq_num 1022)
> > 1024:  finishing write tid 1 to nodezz25161-1024
> > 1024:  finishing write tid 2 to nodezz25161-1024
> > 1025: Error: oid 219 read returned error code -2
> > ./test/osd/RadosModel.h: In function 'virtual void
> > ReadOp::_finish(TestOp::CallbackInfo*)' thread 7fbb1bfff700 time
> > 2016-03-17 10:53:53.071338
> > ./test/osd/RadosModel.h: 1109: FAILED assert(0)
> > ceph version 0.94.6 (e832001feaf8c176593e0325c8298e3f16dfb403)
> > 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > const*)+0x76) [0x4db956]
> > 2: (ReadOp::_finish(TestOp::CallbackInfo*)+0xec) [0x4c959c]
> > 3: (()+0x9791d) [0x7fbb30ff191d]
> > 4: (()+0x72519) [0x7fbb30fcc519]
> > 5: (()+0x13c178) [0x7fbb31096178]
> > 6: (()+0x80a4) [0x7fbb30b2a0a4]
> > 7: (clone()+0x6d) [0x7fbb2f4a504d]
> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> > needed to interpret this.
> > terminate called after throwing an instance of 'ceph::FailedAssertion'
> > Aborted
> > ----------------
> > Robert LeBlanc
> > PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> >
> >
> > On Thu, Mar 17, 2016 at 10:39 AM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >> On Thu, 17 Mar 2016, Robert LeBlanc wrote:
> >>> -----BEGIN PGP SIGNED MESSAGE-----
> >>> Hash: SHA256
> >>>
> >>> I'm having trouble finding documentation about using ceph_test_rados. Can I
> >>> run this on the existing cluster and will that provide useful info? It seems
> >>>  running it in the build will not have the caching set up (vstart.sh).
> >>>
> >>> I have accepted a job with another company and only have until Wednesday to
> >>> help with getting information about this bug. My new job will not be using C
> >>> eph, so I won't be able to provide any additional info after Tuesday. I want
> >>>  to leave the company on a good trajectory for upgrading, so any input you c
> >>> an provide will be helpful.
> >>
> >> I'm sorry to hear it!  You'll be missed.  :)
> >>
> >>> I've found:
> >>>
> >>> ./ceph_test_rados --op read 100 --op write 100 --op delete 50
> >>> - --max-ops 400000 --objects 1024 --max-in-flight 64 --size 4000000
> >>> - --min-stride-size 400000 --max-stride-size 800000 --max-seconds 600
> >>> - --op copy_from 50 --op snap_create 50 --op snap_remove 50 --op
> >>> rollback 50 --op setattr 25 --op rmattr 25 --pool unique_pool_0
> >>>
> >>> Is that enough if I change --pool to the cached pool and do the toggling whi
> >>> le ceph_test_rados is running? I think this will run for 10 minutes.
> >>
> >> Precisely.  You can probably drop copy_from and snap ops from the list
> >> since your workload wasn't exercising those.
> >>
> >> Thanks!
> >> sage
> >>
> >>
> 
> 
