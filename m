From: Dong Wu <archer.wudong@gmail.com>
Subject: How to release Hammer osd RAM when compiled with jemalloc
Date: Tue, 13 Dec 2016 10:22:57 +0800
Message-ID: <CAAL-TMcjJi7dQrOHiBUwQCgJ5R2cWDeLBB3XzKAogvaAR7yUxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36145 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752913AbcLMCW6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 21:22:58 -0500
Received: by mail-qk0-f193.google.com with SMTP id h201so12996306qke.3
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 18:22:58 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

Hi, all
   I have a cluster with nearly 1000 osds, and each osd already
occupied 2.5G physical memory on average, which cause each host 90%
memory useage. when use tcmalloc, we can use "ceph tell osd.* release"
to release unused memory, but in my cluster, ceph is build with
jemalloc, so can't use "ceph tell osd.* release", is there any methods
to release some memory?

another question:
can I decrease the following config value which used for cached osdmap
 to lower osd's memory?

"mon_min_osdmap_epochs": "500"
"osd_map_max_advance": "200",
"osd_map_cache_size": "500",
"osd_map_message_max": "100",
"osd_map_share_max_epochs": "100"


here is one of my host memory usage:
Tasks: 547 total,   1 running, 546 sleeping,   0 stopped,   0 zombie
%Cpu(s):  0.7 us,  0.4 sy,  0.0 ni, 98.8 id,  0.0 wa,  0.0 hi,  0.1 si,  0.0 st
KiB Mem:  65474900 total, 65174136 used,   300764 free,    63472 buffers
KiB Swap:  4194300 total,  1273384 used,  2920916 free,  7100148 cached

PID USER      PR  NI  VIRT  RES  SHR S  %CPU %MEM    TIME+  COMMAND
190259 root      20   0 12.1g 2.6g 5328 S     8  4.2   5445:38
ceph-osd
177520 root      20   0 11.9g 2.6g 5560 S    10  4.1   4725:24
ceph-osd
166517 root      20   0 12.2g 2.5g 5320 S     4  4.1   5399:44
ceph-osd
171744 root      20   0 11.9g 2.5g 5984 S     4  4.1   4911:13
ceph-osd
   958 root      20   0 11.9g 2.5g 4652 S     6  4.0   4821:20
ceph-osd
 16134 root      20   0 12.4g 2.5g 5252 S     4  4.0   5336:00
ceph-osd
183738 root      20   0 12.1g 2.5g 4500 S     6  4.0   4748:43
ceph-osd
  8482 root      20   0 11.6g 2.5g 5760 S     4  4.0   4937:24
ceph-osd
161514 root      20   0 12.1g 2.5g 5712 S     6  3.9   4937:30
ceph-osd
 37148 root      20   0 5919m 2.4g 4164 S     2  3.9   2709:53
ceph-osd
 48327 root      20   0 5956m 2.4g 3872 S     0  3.8   2782:25
ceph-osd
 31214 root      20   0 5990m 2.4g 4336 S     4  3.8   3020:38
ceph-osd
 24254 root      20   0 5762m 2.4g 4404 S     4  3.8   2852:50
ceph-osd
 19524 root      20   0 5782m 2.4g 4608 S     2  3.8   2752:12
ceph-osd
 40557 root      20   0 5875m 2.4g 4492 S     4  3.8   2808:41
ceph-osd
 22458 root      20   0 5769m 2.3g 4084 S     2  3.8   2820:34
ceph-osd
 28668 root      20   0 5796m 2.3g 4424 S     2  3.8   2728:06
ceph-osd
 20885 root      20   0 5867m 2.3g 4368 S     2  3.7   2802:10
ceph-osd
 26382 root      20   0 5857m 2.3g 4176 S     4  3.7   3012:35
ceph-osd
 44276 root      20   0 5828m 2.3g 4792 S     0  3.6   2891:12
ceph-osd
 34035 root      20   0 5887m 2.2g 3984 S     4  3.5   2836:21 ceph-osd


Thanks.
Regards.
