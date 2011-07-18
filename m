From: huang jun <hjwsm1989@gmail.com>
Subject: read performance not perfect
Date: Mon, 18 Jul 2011 12:51:38 +0800
Message-ID: <CABAwU-YJ8DFjphavMQ+NjqPU7=fFBtwsEMzE7xT1G8gp4LywSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46989 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab1GREvj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jul 2011 00:51:39 -0400
Received: by wwe5 with SMTP id 5so2813697wwe.1
        for <ceph-devel@vger.kernel.org>; Sun, 17 Jul 2011 21:51:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
We test ceph's read performance last week, and find something weird
we use ceph v0.30 on linux 2.6.37
mount ceph on back-platform consist of 2 osds \1 mon \1 mds
$mount -t ceph 192.168.1.103:/ /mnt -vv
$ dd if=/dev/zero of=/mnt/test bs=4M count=200
$ cd .. && umount /mnt
$mount -t ceph 192.168.1.103:/ /mnt -vv
$dd if=test of=/dev/zero bs=4M
  200+0 records in
  200+0 records out
  838860800 bytes (839 MB) copied, 16.2327 s, 51.7 MB/s
but if we use rados to test it
$ rados -m 192.168.1.103:6789 -p data bench 60 write
$ rados -m 192.168.1.103:6789 -p data bench 60 seq
  the result is:
  Total time run:        24.733935
  Total reads made:     438
  Read size:            4194304
  Bandwidth (MB/sec):    70.834

  Average Latency:       0.899429
  Max latency:           1.85106
  Min latency:           0.128017
this phenomenon attracts our attention, then we begin to analysis the
osd debug log.
we find that :
1) the kernel client send READ request, at first it requests 1MB, and
after that it is 512KB
2) from rados test cmd log, OSD recept the READ op with 4MB data to handle
we know the ceph developers pay their attention to read and write
performance, so i just want to confrim that
if the communication between the client and OSD spend  more time than
it should be? can we request  bigger size, just like default object
size 4MB, when it occurs to READ operation? or this is related to OS
management, if so, what can we do to promote the performance?

thanks very much!
