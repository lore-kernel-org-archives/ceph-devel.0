From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: mds: failed to decode msg EXPORT_DIR
Date: Sat, 21 Oct 2017 17:42:58 +0800
Message-ID: <CAEYCsVJWvRz-ndaanfpcbEwWYTL3AJW3sSa4anvDDymkNBHfSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:54253 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753248AbdJUJnA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Oct 2017 05:43:00 -0400
Received: by mail-io0-f178.google.com with SMTP id 189so15558710iow.10
        for <ceph-devel@vger.kernel.org>; Sat, 21 Oct 2017 02:43:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <ukernel@gmail.com>, John Spray <jspray@redhat.com>

Hi , I hit this on one of my MDS rank, it looks to me like the
export_dir message is way much too big , the hux dump take more than
20GB(stop by no more disk space...).


The only crazy thing in the FS is we have 6 mdses and 5000+ export binding.f


2017-10-21 00:47:18.731219 7f27463e0700  0 --
10.148.245.141:6800/4152861050 >> 10.148.245.48:0/3250358670
conn(0x558aeb4ac800 :6800 s=STATE_OPEN pgs=44 cs=1 l=0).fault server,
going to standby
2017-10-21 00:47:44.500382 7f27463e0700 -1 failed to decode message of
type 1110 v1: buffer::end_of_buffer
2017-10-21 00:47:44.503923 7f27463e0700 -1 *** Caught signal (Aborted) **
 in thread 7f27463e0700 thread_name:msgr-worker-1

 ceph version 12.2.0 (32ce2a3ae5239ee33d6150705cdb24d43bab910c) luminous (rc)
 1: (()+0x59b344) [0x558ad5d94344]
 2: (()+0x11390) [0x7f274910d390]
 3: (gsignal()+0x38) [0x7f274809d428]
 4: (abort()+0x16a) [0x7f274809f02a]
 5: (__gnu_cxx::__verbose_terminate_handler()+0x16d) [0x7f27489e084d]
 6: (()+0x8d6b6) [0x7f27489de6b6]
 7: (()+0x8d701) [0x7f27489de701]
 8: (()+0xb8d38) [0x7f2748a09d38]
 9: (()+0x76ba) [0x7f27491036ba]
 10: (clone()+0x6d) [0x7f274816f3dd]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.


-9877> 2017-10-21 00:24:41.764088 7f2745bdf700  1 dump:
00000000  f1 03 00 00 00 01 00 00  00 00 00 00 26 01 00 00  |............&...|
00000010  ee a3 0e 00 00 05 00 00  00 00 00 00 77 e6 37 00  |............w.7.|
00000020  00 02 00 00 00 00 00 00  46 50 13 00 00 04 00 00  |........FP......|
00000030  00 00 00 00 24 57 a8 00  00 02 00 00 00 00 00 00  |....$W..........|
00000040  ef aa 20 00 00 03 00 00  00 00 00 00 30 65 16 00  |.. .........0e..|
00000050  00 04 00 00 00 00 00 00  de e3 93 00 00 02 00 00  |................|
00000060  00 00 00 00 38 6f a5 00  00 02 00 00 00 00 00 00  |....8o..........|
00000070  e9 71 16 00 00 03 00 00  00 00 00 00 59 e8 16 00  |.q..........Y...|
00000080  00 04 00 00 00 00 00 00  95 1a 96 00 00 02 00 00  |................|
00000090  00 00 00 00 40 52 6a 00  00 02 00 00 00 00 00 00  |....@Rj.........|
000000a0  98 c7 a6 00 00 02 00 00  00 00 00 00 4b 97 80 00  |............K...|
000000b0  00 02 00 00 00 00 00 00  b4 7e 1e 00 00 03 00 00  |.........~......|
000000c0  00 00 00 00 3b 58 a3 00  00 02 00 00 00 00 00 00  |....;X..........|
000000d0  da b7 15 00 00 04 00 00  00 00 00 00 5e 61 17 00  |............^a..|
000000e0  00 04 00 00 00 00 00 00  0e 12 98 00 00 01 00 00  |................|
000000f0  00 00 00 00 0e 03 1e 00  00 03 00 00 00 00 00 00  |................|
00000100  93 d6 14 00 00 04 00 00  00 00 00 00 74 a4 97 00  |............t...|
00000110  00 01 00 00 00 00 00 00  65 6a 13 00 00 04 00 00  |........ej......|
00000120  00 00 00 00 cc 76 1f 00  00 03 00 00 00 00 00 00  |.....v..........|
00000130  9b da 1f 00 00 03 00 00  00 00 00 00 5d 41 0d 00  |............]A..|
00000140  00 04 00 00 00 00 00 00  e1 58 18 00 00 04 00 00  |.........X......|
00000150  00 00 00 00 0a b8 1e 00  00 03 00 00 00 00 00 00  |................|
00000160  97 f6 13 00 00 04 00 00  00 00 00 00 1b 50 20 00  |.............P .|
00000170  00 03 00 00 00 00 00 00  10 e8 93 00 00 02 00 00  |................|
00000180  00 00 00 00 77 71 6a 00  00 02 00 00 00 00 00 00  |....wqj.........|
00000190  fc d2 b7 00 00 02 00 00  00 00 00 00 bf 6e 95 00  |.............n..|
000001a0  00 02 00 00 00 00 00 00  fd 0d 93 00 00 02 00 00  |................|
000001b0  00 00 00 00 fe e5 37 00  00 02 00 00 00 00 00 00  |......7.........|
000001c0  3f e6 37 00 00 02 00 00  00 00 00 00 55 b5 16 00  |?.7.........U...|
000001d0  00 03 00 00 00 00 00 00  1a 41 12 00 00 04 00 00  |.........A......|
000001e0  00 00 00 00 96 e5 37 00  00 02 00 00 00 00 00 00  |......7.........|
000001f0  a2 dc 10 00 00 04 00 00  00 00 00 00 8c a1 a4 00  |................|
00000200  00 02 00 00 00 00 00 00  a0 3f 0d 00 00 04 00 00  |.........?......|
00000210  00 00 00 00 2c 4b 16 00  00 03 00 00 00 00 00 00  |....,K..........|
00000220  d7 8e 14 00 00 04 00 00  00 00 00 00 45 4d 0d 00  |............EM..|
00000230  00 04 00 00 00 00 00 00  1a c9 a4 00 00 02 00 00  |................|
00000240  00 00 00 00 75 ab 16 00  00 03 00 00 00 00 00 00  |....u...........|
00000250  6f 53 37 00 00 02 00 00  00 00 00 00 c5 8a 37 00  |oS7...........7.|
00000260  00 02 00 00 00 00 00 00  5c c9 ba 00 00 02 00 00  |........\.......|
00000270  00 00 00 00 9a 44 ab 00  00 02 00 00 00 00 00 00  |.....D..........|
