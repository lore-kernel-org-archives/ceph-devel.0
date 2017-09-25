From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: help fixing inconsistent pg
Date: Mon, 25 Sep 2017 13:07:01 -0400
Message-ID: <CAGbvivL5Ev3Ry9D27VtE2u60JCtJkL+aygfdYf0U7M=EYfdHhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:48238 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935407AbdIYRHE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Sep 2017 13:07:04 -0400
Received: by mail-wr0-f179.google.com with SMTP id 108so9000164wra.5
        for <ceph-devel@vger.kernel.org>; Mon, 25 Sep 2017 10:07:03 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

ceph 10.2.9
Ubuntu 16.04.2

I have an inconsistent PG that I cannot get to repair, either manually
or using the "repair" command.

The log for the repairing OSD looks like this:

2017-09-25 12:46:14.974590 7f2a2f91a700  0 log_channel(cluster) log
[INF] : 1.5b8 repair starts
2017-09-25 12:46:14.974595 7f2a2f91a700  0 log_channel(cluster) do_log
log to syslog
2017-09-25 12:48:36.919362 7f2a2f91a700 -1 log_channel(cluster) log
[ERR] : 1.5b8 shard 7: soid 1:1daab06b:::100004d6662.00000000:head
data_digest 0x923deb74 != data_digest 0x23f10be8 from auth oi
1:1daab06b:::100004d6662.00000000:head(204442'221517
client.5654254.1:2371279 dirty|data_digest|omap_digest s 1421644 uv
203993 dd 23f10be8 od ffffffff alloc_hint [0 0])
2017-09-25 12:48:36.919366 7f2a2f91a700  0 log_channel(cluster) do_log
log to syslog
2017-09-25 12:48:36.919412 7f2a2f91a700 -1 log_channel(cluster) log
[ERR] : 1.5b8 shard 26: soid 1:1daab06b:::100004d6662.00000000:head
data_digest 0x923deb74 != data_digest 0x23f10be8 from auth oi
1:1daab06b:::100004d6662.00000000:head(204442'221517
client.5654254.1:2371279 dirty|data_digest|omap_digest s 1421644 uv
203993 dd 23f10be8 od ffffffff alloc_hint [0 0])
2017-09-25 12:48:36.919414 7f2a2f91a700  0 log_channel(cluster) do_log
log to syslog
2017-09-25 12:48:36.919425 7f2a2f91a700 -1 log_channel(cluster) log
[ERR] : 1.5b8 shard 44 missing 1:1daab06b:::100004d6662.00000000:head
2017-09-25 12:48:36.919427 7f2a2f91a700  0 log_channel(cluster) do_log
log to syslog
2017-09-25 12:48:36.919433 7f2a2f91a700 -1 log_channel(cluster) log
[ERR] : 1.5b8 soid 1:1daab06b:::100004d6662.00000000:head: failed to
pick suitable auth object
2017-09-25 12:48:36.919435 7f2a2f91a700  0 log_channel(cluster) do_log
log to syslog
2017-09-25 12:48:36.919616 7f2a2f91a700 -1 log_channel(cluster) log
[ERR] : repair 1.5b8 1:1daab06b:::100004d6662.00000000:dd4 is an
unexpected clone
2017-09-25 12:48:36.919617 7f2a2f91a700  0 log_channel(cluster) do_log
log to syslog
2017-09-25 12:51:05.941315 7f2a2f91a700 -1 log_channel(cluster) log
[ERR] : 1.5b8 repair 4 errors, 0 fixed
2017-09-25 12:51:05.941322 7f2a2f91a700  0 log_channel(cluster) do_log
log to syslog


I located the object in question (100004d6662.00000000) and removed
it, restarted the OSD and re-ran the repair request but it still
reports the same thing even after removing the object entirely.


Trying to flush the journal results in crashes:

root@ss004:~# ceph-osd -i 44 --flush-journal
 HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
 HDIO_DRIVE_CMD(identify) failed: Inappropriate ioctl for device
*** Caught signal (Segmentation fault) **
 in thread 7f54568fb700 thread_name:ceph-osd
 ceph version 10.2.9 (2ee413f77150c0f375ff6f10edd6c8f9c7d060d0)
 1: (()+0x984c4e) [0x55990b365c4e]
 2: (()+0x11390) [0x7f546048d390]
 3: [0x559915e33400]
2017-09-25 12:59:02.064846 7f54568fb700 -1 *** Caught signal
(Segmentation fault) **
 in thread 7f54568fb700 thread_name:ceph-osd

 ceph version 10.2.9 (2ee413f77150c0f375ff6f10edd6c8f9c7d060d0)
 1: (()+0x984c4e) [0x55990b365c4e]
 2: (()+0x11390) [0x7f546048d390]
 3: [0x559915e33400]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

     0> 2017-09-25 12:59:02.064846 7f54568fb700 -1 *** Caught signal
(Segmentation fault) **
 in thread 7f54568fb700 thread_name:ceph-osd

 ceph version 10.2.9 (2ee413f77150c0f375ff6f10edd6c8f9c7d060d0)
 1: (()+0x984c4e) [0x55990b365c4e]
 2: (()+0x11390) [0x7f546048d390]
 3: [0x559915e33400]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

Segmentation fault
