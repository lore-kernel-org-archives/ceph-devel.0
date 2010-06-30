From: =?ISO-8859-1?Q?S=E9bastien_Paolacci?=
	<sebastien.paolacci@gmail.com>
Subject: Re: pg 0.xxxx on [] is laggy
Date: Wed, 30 Jun 2010 23:06:07 +0200
Message-ID: <AANLkTikG7OsUyBtXXfO2tI-T2LzwVOlIb32UFtPFs41z@mail.gmail.com>
References: <AANLkTimJpJeHVMvhLSyASwo3DjE9sd1njJ7PGG9yhPa1@mail.gmail.com>
	<Pine.LNX.4.64.1006290850420.12768@cobra.newdream.net>
	<AANLkTini3YGPjANBw-FgWDld2J1cpe2GXsimpMI-0y1Z@mail.gmail.com>
	<Pine.LNX.4.64.1006301104320.29167@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45880 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756782Ab0F3VMw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jun 2010 17:12:52 -0400
Received: by wwi18 with SMTP id 18so29790wwi.1
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jun 2010 14:12:49 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1006301104320.29167@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 6/30/10, Sage Weil <sage@newdream.net> wrote:
> Hmm.. is this reproducible?  I just pushed something to ceph.git unstable
> that prints out useful debugging info when that happens, but the question
> remains what is causing it to happen in the first place.  Do you mind
> giving the latest a go and seeing what it tells us?
>
Yes it's definitely reproducible. I gave a try to your last commit
(that is actually triggered), here is the log output:

10.06.30_22:49:37.214544 --- opened log /var/log/ceph/debian-vm1.11418 ---
ceph version 0.21~rc (3235abe91863b3bffe5638b2169603f7d89ea375)
10.06.30_22:49:37.214655 7fec9a01c720 ---- renamed symlink
/var/log/ceph/osd0 -> /var/log/ceph/osd0.0 ----
10.06.30_22:49:37.214689 7fec9a01c720 ---- created symlink
/var/log/ceph/osd0 -> debian-vm1.11418 ----
10.06.30_22:49:37.214747 7fec9a01c720 -- :/0 register_entity client?
10.06.30_22:49:37.214876 7fec9a01c720 -- :/0 register_entity client? at :/0
10.06.30_22:49:37.214953 7fec9a01c720 -- :/0 ready :/0
10.06.30_22:49:37.215019 7fec9a01c720 -- :/11418 messenger.start
10.06.30_22:49:37.215076 7fec9a01c720 -- :/11418 shutdown :/11418
10.06.30_22:49:37.215091 7fec9a01c720 -- :/11418 shutdown i am not
dispatch, setting stop flag and joining thread.
10.06.30_22:49:37.215107 7fec9a01c720 -- :/11418 wait: still active
10.06.30_22:49:37.215145 7fec9a01c720 -- :/11418 wait: woke up
10.06.30_22:49:37.215165 7fec9a01c720 -- :/11418 wait: everything stopped
10.06.30_22:49:37.215177 7fec9a01c720 -- :/11418 wait: closing pipes
10.06.30_22:49:37.215191 7fec9a01c720 -- :/11418 reaper
10.06.30_22:49:37.215202 7fec9a01c720 -- :/11418 reaper done
10.06.30_22:49:37.215214 7fec9a01c720 -- :/11418 wait: waiting for
pipes  to close
10.06.30_22:49:37.215225 7fec9a01c720 -- :/11418 wait: done.
10.06.30_22:49:37.215236 7fec9a01c720 -- :/11418 shutdown complete.
10.06.30_22:49:37.215398 7fec9a01c720 filestore(/data/osd0) mkfs in /data/osd0
10.06.30_22:49:37.215477 7fec9a01c720 filestore(/data/osd0) mkfs
removing old directory current
10.06.30_22:49:37.218588 7fec9a01c720 filestore(/data/osd0) mkfs
removing old file magic
10.06.30_22:49:37.218644 7fec9a01c720 filestore(/data/osd0) mkfs
removing old file fsid
10.06.30_22:49:37.218674 7fec9a01c720 filestore(/data/osd0) mkfs
removing old file ceph_fsid
10.06.30_22:49:37.218703 7fec9a01c720 filestore(/data/osd0) mkfs
removing old file whoami
10.06.30_22:49:37.219248 7fec9a01c720 filestore(/data/osd0) mkjournal
created journal on /ceph-journal/osd0
10.06.30_22:49:37.219279 7fec9a01c720 filestore(/data/osd0) mkfs done
in /data/osd0
10.06.30_22:49:37.219329 7fec9a01c720 filestore(/data/osd0) mount did
NOT detect btrfs
10.06.30_22:49:37.219376 7fec9a01c720 filestore(/data/osd0) mount found snaps <>
10.06.30_22:49:37.220478 7fec98932710 journal rebuild_page_aligned
failed, buffer::list(len=5120,
        buffer::ptr(0~5120 0xab3410 in raw 0xab3410 len 5120 nref 1)
)
os/FileJournal.cc: In function 'void FileJournal::write_bl(off64_t&,
ceph::bufferlist&)':
os/FileJournal.cc:508: FAILED assert((bl.length() & ~ceph::_page_mask) == 0)
 1: (FileJournal::do_write(ceph::buffer::list&)+0x2a2) [0x55b362]
 2: (FileJournal::write_thread_entry()+0x1fa) [0x55da6a]
 3: (FileJournal::Writer::entry()+0xd) [0x54f04d]
 4: (Thread::_entry_func(void*)+0x7) [0x46ca97]
 5: (()+0x68ba) [0x7fec999fe8ba]
 6: (clone()+0x6d) [0x7fec98c1901d]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

Would you prefer to have the core dump?

Sebastien
