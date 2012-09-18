From: Tren Blackburn <tren@eotnetworks.com>
Subject: Why does mkcephfs take approximately 30 seconds per osd on ceph 0.51?
Date: Tue, 18 Sep 2012 13:57:47 -0700
Message-ID: <CANLRBoy-rNWadmVt=ZcCZNLWFG-oaH2bsZp6Yvjd9DUqtn4xOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:56108 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab2IRU5s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Sep 2012 16:57:48 -0400
Received: by vcbfo13 with SMTP id fo13so407317vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 18 Sep 2012 13:57:47 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List;

I've been working with ceph 0.51 lately, and have noticed this for a
while now, but it hasn't been a big enough issue for me to report.
However today I'm turning up a 192 OSD cluster, and 30 seconds per OSD
adds up pretty quick. For some reason it's taking 30 seconds between
checking the OSD for a pre-existing store:

2012-09-18 13:53:28.400590 7fe895d25780 -1 filestore(/var/ceph/disk11)
could not find 23c2fcde/osd_superblock/0//-1 in index: (2) No such
file or directory

And then actually creating the new store:

2012-09-18 13:53:57.371396 7fe895d25780 -1 created object store
/var/ceph/disk11 journal /dev/mapper/vg-journal.disk11 for osd.34 fsid
bca82801-04d7-402e-917f-8023a4b161a8
2012-09-18 13:53:57.371449 7fe895d25780 -1 auth: error reading file:
/var/ceph/disk11/keyring: can't open /var/ceph/disk11/keyring: (2) No
such file or directory
2012-09-18 13:53:57.371527 7fe895d25780 -1 created new key in keyring
/var/ceph/disk11/keyring

I can provide many examples as I'm watching it slowly plod through
currently. Also, the horse power of the server makes no difference.
The servers in question here are dual E5-2600's with 96GB ram and
12x2TB drives.

What information can I provide to help debug this? Or is this an
already known issue?

Thanks in advance!

t.
