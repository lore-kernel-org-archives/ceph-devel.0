From: yue longguang <yuelongguang@gmail.com>
Subject: osd cpu usage is bigger than 100%
Date: Thu, 11 Sep 2014 15:44:24 +0800
Message-ID: <CAPaK2r_nZDsDoHmUk6kPXCDmZcHweUM4+zEcu8c4KL8gg1QWQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:43104 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbaIKHoY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Sep 2014 03:44:24 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar1so5446866iec.7
        for <ceph-devel@vger.kernel.org>; Thu, 11 Sep 2014 00:44:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi,all
i am testing   rbd performance, now there is only one vm which is
using  rbd as its disk, and inside it  fio is doing r/w.
the big diffenence is that i set a big iodepth other than iodepth=1.
according to my test,  the bigger iodepth, the bigger cpu usage.

analyse  the output of top command.
1.
12% wa,  if it means disk speed is not fast enough?

2. from where  we  can know  whether ceph's number of threads  is
enough or not?


how do you think about it,  which part is using up cpu? i want to find
the root cause, why big iodepth leads to high cpu usage.


---default options----
osd_op_threads": "2",
  "osd_disk_threads": "1",
  "osd_recovery_threads": "1",
"filestore_op_threads": "2",


thanks

----------top---------------iodepth=16-----------------
top - 15:27:34 up 2 days,  6:03,  2 users,  load average: 0.49, 0.56, 0.62
Tasks:  97 total,   1 running,  96 sleeping,   0 stopped,   0 zombie
Cpu(s): 19.0%us,  8.1%sy,  0.0%ni, 59.3%id, 12.1%wa,  0.0%hi,  0.8%si,  0.7%st
Mem:   1922540k total,  1853180k used,    69360k free,     7012k buffers
Swap:  1048568k total,    76796k used,   971772k free,  1034272k cached
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 2763 root      20   0 1112m 386m 5028 S 60.8 20.6 200:43.47 ceph-osd

 -------------top--------------------------------------------
top - 19:50:08 up 1 day, 10:26,  2 users,  load average: 1.55, 0.97, 0.81
Tasks:  97 total,   1 running,  96 sleeping,   0 stopped,   0 zombie
Cpu(s): 37.6%us, 14.2%sy,  0.0%ni, 37.0%id,  9.4%wa,  0.0%hi,  1.3%si,  0.5%st
Mem:   1922540k total,  1820196k used,   102344k free,    23100k buffers
Swap:  1048568k total,    91724k used,   956844k free,  1052292k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 4312 root      20   0 1100m 337m 5192 S 107.3 18.0  88:33.27 ceph-osd
 1704 root      20   0  514m 272m 3648 S  0.7 14.5   3:27.19 ceph-mon



--------------iostat------------------

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s
avgrq-sz avgqu-sz   await  svctm  %util
vdd               5.50   137.50  247.00  782.00  2896.00  8773.00
11.34     7.08    3.55   0.63  65.05

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s
avgrq-sz avgqu-sz   await  svctm  %util
vdd               9.50   119.00  327.50  458.50  3940.00  4733.50
11.03    12.03   19.66   0.70  55.40

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s
avgrq-sz avgqu-sz   await  svctm  %util
vdd              15.50    10.50  324.00  559.50  3784.00  3398.00
8.13     1.98    2.22   0.81  71.25

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s
avgrq-sz avgqu-sz   await  svctm  %util
vdd               4.50   253.50  273.50  803.00  3056.00 12155.00
14.13     4.70    4.32   0.55  59.55

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s
avgrq-sz avgqu-sz   await  svctm  %util
vdd              10.00     6.00  294.00  488.00  3200.00  2933.50
7.84     1.10    1.49   0.70  54.85

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s
avgrq-sz avgqu-sz   await  svctm  %util
vdd              10.00    14.00  333.00  645.00  3780.00  3846.00
7.80     2.13    2.15   0.90  87.55

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s
avgrq-sz avgqu-sz   await  svctm  %util
vdd              11.00   240.50  259.00  579.00  3144.00 10035.50
15.73     8.51   10.18   0.84  70.20

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s
avgrq-sz avgqu-sz   await  svctm  %util
vdd              10.50    17.00  318.50  707.00  3876.00  4084.50
7.76     1.32    1.30   0.61  62.65

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s
avgrq-sz avgqu-sz   await  svctm  %util
vdd               4.50   208.00  233.50  918.00  2648.00 19214.50
18.99     5.43    4.71   0.55  63.20

Device:         rrqm/s   wrqm/s     r/s     w/s   rsec/s   wsec/s
avgrq-sz avgqu-sz   await  svctm  %util
vdd               7.00     1.50  306.00  212.00  3376.00  2176.50
10.72     1.03    1.83   0.96  49.70
