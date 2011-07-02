From: Wilfrid Allembrand <wilfrid.allembrand@gmail.com>
Subject: Servers with 40+ disks : to group or not to group ?
Date: Sat, 2 Jul 2011 15:30:40 +0200
Message-ID: <CAJ_6VAejmSA+c61Q5Uj0NNJcTZs0vS=k7VQcEG_VPdD5W4bu5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33056 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159Ab1GBNal (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Jul 2011 09:30:41 -0400
Received: by gwaa18 with SMTP id a18so1610778gwa.19
        for <ceph-devel@vger.kernel.org>; Sat, 02 Jul 2011 06:30:40 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

I'm trying to figure out what is the best OSD solution with an
infrastructure made up of servers with a lot a disks in each. Say, for
exemple you have 4+ nodes like Sun Fire X4500 (code-named Thumper).
Each node is 48 disks.

What are the pros and cons to build a ceph cluster with btrfs on that
kind of high density hardware, considering the different scenarios for
each server :
- 1 OSD daemon per disk, so 48 osd daemons per server
- make 3 btrfs pools of 16 disks, so 3 osd daemons per server
- make 3 raid 5 or 6 volumes, so 3 osd daemons per server

From a performance and management point of view, will you recommand a
lot of small servers of a few numbers of thumper's like servers ?

All the best,
Wilfrid
