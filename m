From: Drunkard Zhang <gongfan193@gmail.com>
Subject: Redundancy when mount with multiple mon IP
Date: Sun, 25 Nov 2012 23:37:06 +0800
Message-ID: <CAJiejCRq2wcRVivDpXDGcQ4t5r=3ZM8-ywVh0EiuPdS+nuDqRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50732 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610Ab2KYPh3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 25 Nov 2012 10:37:29 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so5192855iea.19
        for <ceph-devel@vger.kernel.org>; Sun, 25 Nov 2012 07:37:28 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I'm using ceph-0.51. I setup 3 monitors. then mount with 3 mon IP at
another host with either kernel mode or fuse, neither give me
redundancy.

Here's commands I used at client (IP: 10.0.0.2) side;
mount -t ceph log3,log21,squid86-log12:/ /mnt/bc
ceph-fuse -m log3,log21,squid86-log12 /mnt/bc

When mounted, read/write is OK, then add a iptables rule at log3 to
REJECT/DROP packets from client 10.0.0.2, operation at client stuck
due to IO problem.

Related stuck processes on client look like this:
log1 ~ # ps auwx |g bc
root      1325  0.0  0.0 120100  3536 pts/0    Sl   23:10   0:00
ceph-fuse -m log3,log21,squid86-log12 /mnt/bc
root      1404  0.0  0.0  16192   700 pts/0    S    23:10   0:00 ls
--color=auto /mnt/bc

Is my test method wrong, or missed something while mount?

From the mount.ceph man page, when I mounted with multiple monitor, it
should be OK when one monitor dead. Has the monitor must be really
dead. or just isn't reachable from the client?

One more question, is there any timeout option could be used at mount
time? osdtimeout and mount_timeout doesn't look like.
