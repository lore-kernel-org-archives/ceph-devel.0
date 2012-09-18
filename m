From: Sage Weil <sage@inktank.com>
Subject: Re: Why does mkcephfs take approximately 30 seconds per osd on ceph
 0.51?
Date: Tue, 18 Sep 2012 13:58:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209181358270.23570@cobra.newdream.net>
References: <CANLRBoy-rNWadmVt=ZcCZNLWFG-oaH2bsZp6Yvjd9DUqtn4xOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33322 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185Ab2IRU6y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Sep 2012 16:58:54 -0400
In-Reply-To: <CANLRBoy-rNWadmVt=ZcCZNLWFG-oaH2bsZp6Yvjd9DUqtn4xOA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tren Blackburn <tren@eotnetworks.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 18 Sep 2012, Tren Blackburn wrote:
> Hi List;
> 
> I've been working with ceph 0.51 lately, and have noticed this for a
> while now, but it hasn't been a big enough issue for me to report.
> However today I'm turning up a 192 OSD cluster, and 30 seconds per OSD
> adds up pretty quick. For some reason it's taking 30 seconds between
> checking the OSD for a pre-existing store:
> 
> 2012-09-18 13:53:28.400590 7fe895d25780 -1 filestore(/var/ceph/disk11)
> could not find 23c2fcde/osd_superblock/0//-1 in index: (2) No such
> file or directory
> 
> And then actually creating the new store:
> 
> 2012-09-18 13:53:57.371396 7fe895d25780 -1 created object store
> /var/ceph/disk11 journal /dev/mapper/vg-journal.disk11 for osd.34 fsid
> bca82801-04d7-402e-917f-8023a4b161a8
> 2012-09-18 13:53:57.371449 7fe895d25780 -1 auth: error reading file:
> /var/ceph/disk11/keyring: can't open /var/ceph/disk11/keyring: (2) No
> such file or directory
> 2012-09-18 13:53:57.371527 7fe895d25780 -1 created new key in keyring
> /var/ceph/disk11/keyring
> 
> I can provide many examples as I'm watching it slowly plod through
> currently. Also, the horse power of the server makes no difference.
> The servers in question here are dual E5-2600's with 96GB ram and
> 12x2TB drives.
> 
> What information can I provide to help debug this? Or is this an
> already known issue?

If you add -x to the #!/bin/bash line in mkcephfs we can see exactly which 
command(s) are going slow...

sage

> 
> Thanks in advance!
> 
> t.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
