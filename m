From: Sergey Tsalkov <stsalkov@gmail.com>
Subject: strange issues recovering from inconsistent state
Date: Fri, 28 Sep 2012 22:12:33 -0700
Message-ID: <CAJvS2pqSE6LicpDAz_DBYwHwWkS6F3uE78gn+dostmLhNNY7Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:43833 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab2I2FMf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 29 Sep 2012 01:12:35 -0400
Received: by vbbff1 with SMTP id ff1so3886648vbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 28 Sep 2012 22:12:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

So we're running a 3-machine cluster with ceph 0.52 on ubuntu precise.
Our cluster has 2 machines with 5 osds each, and a third machine with
a rados gateway. Each machine has a mon. The default crushmap is
putting a copy of the data on each machine, so 2 copies total. All of
our reads and writes are done over the S3 gateway.

We were curious about how it handled inconsistent file states so we
uploaded a text file, then went into the osd data
(/var/lib/ceph/osd/ceph-9/...) and changed that file on disk on one of
the two osds. The cluster didn't automatically discover any errors,
still reported HEALTH_OK, and S3 happily returned the broken copy of
the file.

We then did "ceph osd repair 9" (which is cheating since we knew which
osd we'd broken it on). It discovered the error but didn't fix it, and
now "ceph health detail" was returning "pg 9.7 is
active+clean+inconsistent, acting [9,4]". Additional repair attempts
didn't help.

We then restarted all of the osds. The cluster was now reporting
HEALTH_OK again, and kept reporting that even after we re-ran the
repair command. The repair command still detected the inconsistency,
though:
2012-09-28 21:46:58.068140 osd.9 [ERR] repair 9.7
994c51ff/4712.1_functions_admin.php/head//9 on disk size (90965) does
not match object info size (91183)

We then tried using S3 to download the broken file again. Every time
we tried, it sent us the broken copy of the file, and then the rados
gateway crashed as soon as the send was done. I restarted the gateway,
and was able to reproduce this.

Just curious to know more about the recovery behavior. How is ceph
designed to recover from inconsistent states?

Thanks!
Sergey
