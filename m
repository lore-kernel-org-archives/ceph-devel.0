From: =?UTF-8?B?0JrQvtC90YHRgtCw0L3RgtC40L0g0KHQsNGF0LjQvdC+0LI=?=
	<sakhinov@gmail.com>
Subject: inconsistent pgs
Date: Sat, 8 Aug 2015 17:13:16 +0300
Message-ID: <CAJnOFAqRjXcuO0bJN8PSLsnnMhBjYMOTJTFY8T+4Z36LaBiMfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36634 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102AbbHHONh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Aug 2015 10:13:37 -0400
Received: by wicgj17 with SMTP id gj17so91294887wic.1
        for <ceph-devel@vger.kernel.org>; Sat, 08 Aug 2015 07:13:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi!

I have a large number of inconsistent pgs 229 of 656, and it's
increasing every hour.
I'm using ceph version 0.94.2 (5fb85614ca8f354284c713a2f9c610860720bbf3).

For example, pg 3.d8:
# ceph health detail | grep 3.d8
pg 3.d8 is active+clean+scrubbing+deep+inconsistent, acting [1,7]

# grep 3.d8 /var/log/ceph/ceph-osd.1.log | less -S
2015-08-07 13:10:48.311810 7f5903f7a700 0 log_channel(cluster) log
[INF] : 3.d8 repair starts 2015-08-07 13:12:05.703084 7f5903f7a700 -1
log_channel(cluster) log [ERR] : repair 3.d8
cbd2d0d8/rbd_data.6a5cf474b0dc51.0000000000000b1f/head//3 on disk data
digest 0x6e4d80bf != 0x6fb5b103 2015-08-07 13:13:26.837524
7f5903f7a700 -1 log_channel(cluster) log [ERR] : repair 3.d8
b5892d8/rbd_data.dbe674b0dc51.00000000000001b9/head//3 on disk data
digest 0x79082779 != 0x9f102f3d 2015-08-07 13:13:44.874725
7f5903f7a700 -1 log_channel(cluster) log [ERR] : repair 3.d8
ee6dc2d8/rbd_data.e7592ae8944a.0000000000000833/head//3 on disk data
digest 0x63ab49d0 != 0x68778496 2015-08-07 13:14:19.378582
7f5903f7a700 -1 log_channel(cluster) log [ERR] : repair 3.d8
d93e14d8/rbd_data.3ef8442ae8944a.0000000000000729/head//3 on disk data
digest 0x3cdb1f5c != 0x4e0400c2 2015-08-07 13:23:38.668080
7f5903f7a700 -1 log_channel(cluster) log [ERR] : 3.d8 repair 4 errors,
0 fixed 2015-08-07 13:23:38.714668 7f5903f7a700 0 log_channel(cluster)
log [INF] : 3.d8 deep-scrub starts 2015-08-07 13:25:00.656306
7f5903f7a700 -1 log_channel(cluster) log [ERR] : deep-scrub 3.d8
cbd2d0d8/rbd_data.6a5cf474b0dc51.0000000000000b1f/head//3 on disk data
digest 0x6e4d80bf != 0x6fb5b103 2015-08-07 13:26:18.775362
7f5903f7a700 -1 log_channel(cluster) log [ERR] : deep-scrub 3.d8
b5892d8/rbd_data.dbe674b0dc51.00000000000001b9/head//3 on disk data
digest 0x79082779 != 0x9f102f3d 2015-08-07 13:26:42.084218
7f5903f7a700 -1 log_channel(cluster) log [ERR] : deep-scrub 3.d8
ee6dc2d8/rbd_data.e7592ae8944a.0000000000000833/head//3 on disk data
digest 0x59a6e7e0 != 0x68778496 2015-08-07 13:26:56.495207
7f5903f7a700 -1 log_channel(cluster) log [ERR] : be_compare_scrubmaps:
3.d8 shard 1: soid
cc49f2d8/rbd_data.3ef8442ae8944a.0000000000000aff/head//3 data_digest
0x4e20a792 != known data_digest 0xc0e9b2d2 from auth shard 7
2015-08-07 13:27:12.134765 7f5903f7a700 -1 log_channel(cluster) log
[ERR] : deep-scrub 3.d8
d93e14d8/rbd_data.3ef8442ae8944a.0000000000000729/head//3 on disk data
digest 0x3cdb1f5c != 0x4e0400c2

osd.7.log is clean for that period of time.
/var/log/dmesg is also clean.

Please help to heal my cluster.
