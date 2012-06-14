From: Sage Weil <sage@inktank.com>
Subject: Re: ceph next branch: error creating empty object store in /srv/osd.10:
 (22) Invalid argument
Date: Thu, 14 Jun 2012 13:17:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206141315390.23137@cobra.newdream.net>
References: <4FD9D187.8030601@profihost.ag> <4FD9D366.3060305@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47192 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264Ab2FNUUn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jun 2012 16:20:43 -0400
In-Reply-To: <4FD9D366.3060305@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 14 Jun 2012, Stefan Priebe - Profihost AG wrote:
> I got this fixed by deleting all content in /srv/osd.X. But now i get with the
> next branch this one:
> 
> === osd.32 ===
> pushing conf and monmap to ssdstor002:/tmp/mkfs.ceph.4885
> 2012-06-14 14:02:09.333309 7f815cd26780 -1 journal FileJournal::_open: unable
> to open journal: open() failed: (2) No such file or directory
> 2012-06-14 14:02:09.690097 7f815cd26780 -1 filestore(/srv/osd.32) could not
> find 23c2fcde/osd_superblock/0//-1 in index: (2) No such file or directory
> 2012-06-14 14:02:09.758456 7f815cd26780 -1 created object store /srv/osd.32
> journal /journal/osd.32.journal for osd.32 fsid
> 308b2ada-5c2a-4b54-b094-b7035413d247
> creating private key for osd.32 keyring /etc/ceph/osd.32.keyring
> creating /etc/ceph/osd.32.keyring
> collecting osd.32 key

Is it possible that the osd journal you configured is a file in the osd 
data directory that doesn't already exist, and you didn't specify the 'osd 
journal size' option in ceph.conf?

The change here is that ceph-osd --mkfs no longer wipes out previous data, 
so that's now your job.  But it only creates the journal file when the 
size is specified, otherwise it needs to already be present...

sage

