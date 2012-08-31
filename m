From: Xiaopong Tran <xiaopong.tran@gmail.com>
Subject: mon memory issue
Date: Fri, 31 Aug 2012 17:02:24 +0800
Message-ID: <50407DA0.7070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53221 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103Ab2HaJCM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 05:02:12 -0400
Received: by pbbrr13 with SMTP id rr13so4495725pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 31 Aug 2012 02:02:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Is there any known memory issue with mon? We have 3 mons running, and
on keeps on crashing after 2 or 3 days, and I think it's because mon
sucks up all memory.

Here's mon after starting for 10 minutes:

   PID USER      PR  NI  VIRT  RES  SHR S  %CPU %MEM    TIME+  COMMAND 

13700 root      20   0  163m  32m 3712 S   4.3  0.1   0:05.15 ceph-mon 

  2595 root      20   0 1672m 523m    0 S   1.7  1.6 954:33.56 ceph-osd 

  1941 root      20   0 1292m 220m    0 S   0.7  0.7 946:40.69 ceph-osd 

  2316 root      20   0 1169m 198m    0 S   0.7  0.6 420:26.74 ceph-osd 

  2395 root      20   0 1149m 184m    0 S   0.7  0.6 364:29.08 ceph-osd 

  2487 root      20   0 1354m 373m    0 S   0.7  1.2 401:13.97 ceph-osd 

   235 root      20   0     0    0    0 S   0.3  0.0   0:37.68 
kworker/4:1
  1304 root      20   0     0    0    0 S   0.3  0.0   0:00.16 
jbd2/sda3-8
  1327 root      20   0     0    0    0 S   0.3  0.0  13:07.00 
xfsaild/sdf1
  2011 root      20   0 1240m 177m    0 S   0.3  0.6 411:52.91 ceph-osd 

  2153 root      20   0 1095m 166m    0 S   0.3  0.5 370:56.01 ceph-osd 

  2725 root      20   0 1214m 186m    0 S   0.3  0.6 378:16.59 ceph-osd 


Here's the memory situation of mon on another machine, after mon has
been running for 3 hours:

   PID USER      PR  NI  VIRT  RES  SHR S  %CPU %MEM    TIME+  COMMAND 

  1716 root      20   0 1923m 1.6g 4028 S   7.6  5.2   8:45.82 ceph-mon 

  1923 root      20   0  774m 138m 5052 S   0.7  0.4   1:28.56 ceph-osd 

  2114 root      20   0  836m 143m 4864 S   0.7  0.4   1:20.14 ceph-osd 

  2304 root      20   0  863m 176m 4988 S   0.7  0.5   1:13.30 ceph-osd 

  2578 root      20   0  823m 150m 5056 S   0.7  0.5   1:24.55 ceph-osd 

  2781 root      20   0  819m 131m 4900 S   0.7  0.4   1:12.14 ceph-osd 

  2995 root      20   0  863m 179m 5024 S   0.7  0.6   1:41.96 ceph-osd 

  3474 root      20   0  888m 208m 5608 S   0.7  0.6   7:08.08 ceph-osd 

  1228 root      20   0     0    0    0 S   0.3  0.0   0:07.01 
jbd2/sda3-8
  1853 root      20   0  859m 176m 4820 S   0.3  0.5   1:17.01 ceph-osd 

  3373 root      20   0  789m 118m 4916 S   0.3  0.4   1:06.26 ceph-osd

And here is the situation on a third node, mon has been running
for over a week:

   PID USER      PR  NI  VIRT  RES  SHR S  %CPU %MEM    TIME+  COMMAND 

  1717 root      20   0 68.8g  26g 2044 S  91.5 84.1   9220:40 ceph-mon 

  1986 root      20   0 1281m 226m    0 S   1.7  0.7   1225:28 ceph-osd 

  2196 root      20   0 1501m 538m    0 S   1.0  1.7   1221:54 ceph-osd 

  2266 root      20   0 1121m 176m    0 S   0.7  0.5 399:23.70 ceph-osd 

  2056 root      20   0 1072m 167m    0 S   0.3  0.5 403:49.76 ceph-osd 

  2126 root      20   0 1412m 458m    0 S   0.3  1.4   1215:48 ceph-osd 

  2337 root      20   0 1128m 188m    0 S   0.3  0.6 408:31.88 ceph-osd 


So, after a while, sooner or later, mon is going to crash, just
a matter of time.

Does anyone see anything like this? This is kinda scary.

OS: Debian Wheezy 3.2.0-3-amd64
Ceph: 0.48argonaut (commit:c2b20ca74249892c8e5e40c12aa14446a2bf2030)

With this issue on hand, I'll have to monitor it closely and
restart mon once in a while, or I will get a crash (which is
still good enough), or a system that does not respond at
all because memory is exhausted, and the whole ceph cluster
is unreachable. We had this problem in the morning, mon on one
node exhausted the memory, none of the ceph command responds
anymore, the only thing left to do is to hard reset the node.
The whole cluster was basically done at that time.

Here is our usage situation:

1) A few applications which read and write data through
librados API, we have about 20-30 connections at any one time.
So far, our apps have no such memory issue, we have been
monitoring them closely.

2) We have a few scripts which pull data from an old storage
system, and use the rados command to put it into ceph.
Basically, just shell script. Each rados command is run
to write one object (one file), and exit. We run about
25 scripts simultaneously, which means at any one time,
there are at most 25 connections.

I don't think this is a very busy system. But this
memory issue is definitely a problem for us.

Thanks for helping.

Xiaopong
