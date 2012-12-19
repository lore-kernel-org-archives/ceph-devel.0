From: Sage Weil <sage@inktank.com>
Subject: Re: Empty directory size greater than zero and can't remove
Date: Tue, 18 Dec 2012 19:51:47 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212181949370.7294@cobra.newdream.net>
References: <CAJiejCRi8QOfQB5Y0rN5vQz-xiTeA1SKdku=8Xa_+3CZAjysLA@mail.gmail.com> <CAJiejCQWQK2RKvMJ-08WW+3Y+23oaghFYTWQ+u7-37grF+Liug@mail.gmail.com> <50D122AD.4070609@catalyst.net.nz> <CAJiejCTTHVOXHK71Quw4SfXHL7R2NXJDV-S+JdZ0ZVWbLQqOwQ@mail.gmail.com>
 <50D138FD.3090502@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60416 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab2LSDvs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Dec 2012 22:51:48 -0500
In-Reply-To: <50D138FD.3090502@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: Drunkard Zhang <gongfan193@gmail.com>, maillist-linux <ceph-devel@vger.kernel.org>

On Wed, 19 Dec 2012, Mark Kirkwood wrote:
> On 19/12/12 15:56, Drunkard Zhang wrote:
> > 2012/12/19 Mark Kirkwood <mark.kirkwood@catalyst.net.nz>:
> > > On 19/12/12 14:44, Drunkard Zhang wrote:
> > > > 2012/12/16 Drunkard Zhang <gongfan193@gmail.com>:
> > > > > I couldn't rm files in ceph, which was backuped files of one osd. It
> > > > > reports direcory not empty, but there's nothing under that directory,
> > > > > just the directory itself held some spaces. How could I shoot down the
> > > > > problem ?
> > > > > 
> > > > > log30 /mnt/bc # ls -aR osd.28/
> > > > > osd.28/:
> > > > > .  ..  osd.28
> > > > > 
> > > > > osd.28/osd.28:
> > > > > .  ..  current
> > > > > 
> > > > > osd.28/osd.28/current:
> > > > > .  ..  0.537_head
> > > > > 
> > > > > osd.28/osd.28/current/0.537_head:
> > > > > .  ..
> > > > > log30 /mnt/bc # ls -lhd osd.28/osd.28/current/0.537_head
> > > > > drwxr-xr-x 1 root root 119M Dec 14 19:22
> > > > > osd.28/osd.28/current/0.537_head
> > > > > log30 /mnt/bc #
> > > > > log30 /mnt/bc # rm -rf osd.28/
> > > > > rm: cannot remove ?osd.28/osd.28/current/0.537_head?: Directory not
> > > > > empty
> > > > > log30 /mnt/bc # rm -rf osd.28/osd.28/current/0.537_head
> > > > > rm: cannot remove ?osd.28/osd.28/current/0.537_head?: Directory not
> > > > > empty
> > > > > 
> > > > > The cluster seems health:
> > > > > log3 ~ # ceph -s
> > > > >      health HEALTH_OK
> > > > >      monmap e1: 3 mons at
> > > > > 
> > > > > {log21=10.205.118.21:6789/0,log3=10.205.119.2:6789/0,squid86-log12=150.164.100.218:6789/0},
> > > > > election epoch 640, quorum 0,1,2 log21,log3,squid86-log12
> > > > >      osdmap e1864: 45 osds: 45 up, 45 in
> > > > >       pgmap v163907: 9224 pgs: 9224 active+clean; 3168 GB data, 9565
> > > > > GB
> > > > > used, 111 TB / 120 TB avail
> > > > >      mdsmap e134: 1/1/1 up {0=log14=up:active}, 1 up:standby
> > > > > 
> > > > After mds restart, I got this error message:
> > > > 2012-12-19 09:16:24.837045 mds.0 [ERR] unmatched fragstat size on
> > > > single dirfrag 100000006c7, inode has f(v6 m2012-11-24 23:18:34.947266
> > > > 1773=1773+0), dirfrag has f(v6 m2012-12-17 12:43:52.203358
> > > > 2038=2038+0)
> > > > 
> > > > How can I fix this?
> > > > 
> > > Is it a btrfs filesystem? If so will have sub volumes hiding in there you
> > > need to remove 1st.
> > Thanks for reply, osds all lives on xfs filesystem.
> 
> Ah, right - might be worth showing us output of 'ls -la' in the dir concerned.
> In particular the link counts might be wrong (indicating fs corruption,
> probably fixable with xfs_repair).

This is a problem in the MDS, not the fs underneath the OSDs.  There was 
at least one bug that was corrupting the 'rstats' recursive info that 
could lead to this that has been fixed recently.

The MDS is actually repairing this as it goes, unless you specify the 'mds 
verify scatter = true' option, in which case it will assert and kill 
itself.

sage
