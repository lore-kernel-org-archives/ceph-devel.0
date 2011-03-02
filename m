From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 2 Mar 2011 14:59:04 -0700
Message-ID: <1299103144.4750.49.camel@sale659.sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
 <1297957574.25491.152.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
 <1298483538.25491.233.camel@sale659.sandia.gov>
 <460F770CEB1C499F8B87593762171483@gmail.com>
 <1298489031.25491.250.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103011646140.32424@cobra.newdream.net>
 <1299079262.4750.19.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103020909170.27567@cobra.newdream.net>
 <1299099295.4750.41.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103021342540.27567@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:52858 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757341Ab1CBV7Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2011 16:59:16 -0500
In-Reply-To: <Pine.LNX.4.64.1103021342540.27567@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Wed, 2011-03-02 at 14:45 -0700, Sage Weil wrote:
> On Wed, 2 Mar 2011, Jim Schutt wrote:
> > 
> > On Wed, 2011-03-02 at 10:10 -0700, Sage Weil wrote:
> > > > I'll see if I see the same signature with master,
> > > > and post logs.
> > > 
> > > Thanks!  Keep us posted.
> > 
> > Hmmm, I'm not having much luck with master (commit 
> > 0fb5ef2ce92 + extra debugging) on a 96-osd filesystem;
> > lots of dead OSDs during startup.
> 
> Commit c916905a8a14029653aae45f0a9fb6c9b4c39e05 (master) should fix this.

I try it out, thanks!

> 
> > I used to use a global chdir option to redirect
> > my core files; my servers are readonly NFS-root, 
> > with /root on a ramdisk, so being able to point
> > those core files at persistent storage was useful.
> > That seems to have changed somewhat.
> 
> Hmm, I don't think this behavior should have changed.  Can you look at a 
> running daemon's /proc/$pid/cwd and see if it's incorrect?

# cat /proc/13120/cmdline
/usr/bin/cosd-i0-c/etc/ceph/ceph.conf

# ls -l /proc/13120/cwd
lrwxrwxrwx 1 root root 0 Mar  2 14:49 /proc/13120/cwd -> /ram/root

# head -3 /etc/ceph/ceph.conf 

[global]
        chdir = /var/log/ceph ; Core files end up here

# ls /var/log/ceph
lost+found  osd.0.log  osd.1.log  osd.2.log  osd.3.log  osd.4.log  osd.5.log  osd.6.log  osd.7.log

# df -h /var/log/ceph
Filesystem            Size  Used Avail Use% Mounted on
/dev/disk/by-path/scsi-0:2:00:00p1
                       33G  2.0G   31G   6% /ram/var/log/ceph

I'm not sure either what could have happened.  I'll 
try to figure out if I'm doing something differently...

Thanks -- Jim

> 
> Thanks-
> sage
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


