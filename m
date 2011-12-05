From: Steven Crothers <steven.crothers@gmail.com>
Subject: Fwd: Ceph Best Practices
Date: Mon, 5 Dec 2011 16:47:40 -0500
Message-ID: <CABGLbPHuo52tUSWWSt2=fbLNK1FoeLM-qALHKmUfb4P9T6gcZQ@mail.gmail.com>
References: <CABGLbPHXtga0tXYRrF=bLmtJK1U439TDZkEXsvBkc=LFyFiaDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54493 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932464Ab1LEVrl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Dec 2011 16:47:41 -0500
Received: by bkbzv3 with SMTP id zv3so2410362bkb.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Dec 2011 13:47:40 -0800 (PST)
In-Reply-To: <CABGLbPHXtga0tXYRrF=bLmtJK1U439TDZkEXsvBkc=LFyFiaDg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

I have a quick question about the way to layout disks in the OSDs. I
can't really find the information I'm looking for on the Wiki or in
the existing mailing list archives that I have saved (4-5months
worth).

In the even a large OSD is being build (say 20 drives, same make/model
2TB). How would you build the OSD? Is it best to format each disk
individually or build them into a raid group? Is there performance
benefits to having each disk setup individually or perhaps having X
amount of raid groups on the system?

How would someone theoretically utilize this amount of storage as
efficiently as possible?

Or am I missing the larger issue and should I be roping all these
drives into a btrfs pool? The documentation on disk layout isn't very
clear and I'm not quite sure where to head. I'm building out a
smallish cluster right now, but I plan on making it quite large in the
future.

For miscellaneous details assume the following:
A 32GB SLC SSD is presented for Journaling
Each drive is hot-swappable at the OS and hardware level, and tested
The TCP/IP segment is highly bonded (5+ bonds per OSD @ 1G)
Network backplane supports max line rates
RBD drivers will be used nearly exclusively (minus some S3 gateway
usage for minimal storage)
Redundancy is of the highest importance, being able to replace a
single drive is more important than saving storage
Performance is also highly important, however if the tolerance is -/+
5-10% before it sacrifices redundancy then redundancy would be choosen
The ability to build this setup (N+2) and be able to sustain a full
OSD failure is also required

Knowing this, how would you layout the disks and why? My goal is to
basically provision large amounts of media storage to workstations
quickly and cheap, which maintaining that the availability of the
storage will be higher than the workstation itself.

This would include storage of master copies ect ect.

PS: Yes I know that Ceph is not a replacement for backups and no
solution is perfect, I'm going to use a cluster aware filesystem on
the RBD's and mount them also on another machine which will do nightly
rsyncs to a drobo.

--
Steven Crothers
steven.crothers@gmail.com
