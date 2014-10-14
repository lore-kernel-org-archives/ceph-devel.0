From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] the state of cephfs in giant
Date: Tue, 14 Oct 2014 06:11:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410140609400.31128@cobra.newdream.net>
References: <alpine.DEB.2.00.1410131114130.10561@cobra.newdream.net> <1413280631.2515.39.camel@tlemarchand.wmi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34956 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282AbaJNNLn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Oct 2014 09:11:43 -0400
In-Reply-To: <1413280631.2515.39.camel@tlemarchand.wmi>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Lemarchand <thomas.lemarchand@cloud-solutions.fr>
Cc: ceph-users@ceph.com, ceph-devel@vger.kernel.org

On Tue, 14 Oct 2014, Thomas Lemarchand wrote:
> Thanks for theses informations.
> 
> I plan to use CephFS on Giant, with production workload, knowing the
> risks and having a hot backup near. I hope to be able to provide useful
> feedback.
> 
> My cluster is made of 7 servers (3mon, 3osd (27 osd inside), 1mds). I
> use ceph-fuse on clients.

Cool!  Please be careful, and have a plan B.  :)

> You wrote about hardlinks, but what about symlinks ? I use some (on
> cephFS firefly) without any problem for now.

Symlinks are simple and cheap; no issues there.

> Do you suggest something for backup of CephFS ? For now I use a simple
> rsync, it works quite well.

rsync is fine.  There is some opportunity to do clever things with the 
recursive ctime metadata, but nobody has wired it up to any tools yet.

sage


> 
> Thanks !
> 
> -- 
> Thomas Lemarchand
> Cloud Solutions SAS - Responsable des syst?mes d'information
> 
> 
> 
> On lun., 2014-10-13 at 11:16 -0700, Sage Weil wrote:
> > We've been doing a lot of work on CephFS over the past few months. This
> > is an update on the current state of things as of Giant.
> > 
> > What we've working on:
> > 
> > * better mds/cephfs health reports to the monitor
> > * mds journal dump/repair tool
> > * many kernel and ceph-fuse/libcephfs client bug fixes
> > * file size recovery improvements
> > * client session management fixes (and tests)
> > * admin socket commands for diagnosis and admin intervention
> > * many bug fixes
> > 
> > We started using CephFS to back the teuthology (QA) infrastructure in the
> > lab about three months ago. We fixed a bunch of stuff over the first
> > month or two (several kernel bugs, a few MDS bugs). We've had no problems
> > for the last month or so. We're currently running 0.86 (giant release
> > candidate) with a single MDS and ~70 OSDs. Clients are running a 3.16
> > kernel plus several fixes that went into 3.17.
> > 
> > 
> > With Giant, we are at a point where we would ask that everyone try
> > things out for any non-production workloads. We are very interested in
> > feedback around stability, usability, feature gaps, and performance. We
> > recommend:
> > 
> > * Single active MDS. You can run any number of standby MDS's, but we are
> >   not focusing on multi-mds bugs just yet (and our existing multimds test
> >   suite is already hitting several).
> > * No snapshots. These are disabled by default and require a scary admin
> >   command to enable them. Although these mostly work, there are
> >   several known issues that we haven't addressed and they complicate
> >   things immensely. Please avoid them for now.
> > * Either the kernel client (kernel 3.17 or later) or userspace (ceph-fuse
> >   or libcephfs) clients are in good working order.
> > 
> > The key missing feature right now is fsck (both check and repair). This is 
> > *the* development focus for Hammer.
> > 
> > 
> > Here's a more detailed rundown of the status of various features:
> > 
> > * multi-mds: implemented. limited test coverage. several known issues.
> >   use only for non-production workloads and expect some stability
> >   issues that could lead to data loss.
> > 
> > * snapshots: implemented. limited test coverage. several known issues.
> >   use only for non-production workloads and expect some stability issues
> >   that could lead to data loss.
> > 
> > * hard links: stable. no known issues, but there is somewhat limited
> >   test coverage (we don't test creating huge link farms).
> > 
> > * direct io: implemented and tested for kernel client. no special
> >   support for ceph-fuse (the kernel fuse driver handles this).
> > 
> > * xattrs: implemented, stable, tested. no known issues (for both kernel
> >   and userspace clients).
> > 
> > * ACLs: implemented, tested for kernel client. not implemented for
> >   ceph-fuse.
> > 
> > * file locking (fcntl, flock): supported and tested for kernel client.
> >   limited test coverage. one known minor issue for kernel with fix
> >   pending. implemention in progress for ceph-fuse/libcephfs.
> > 
> > * kernel fscache support: implmented. no test coverage. used in
> >   production by adfin.
> > 
> > * hadoop bindings: implemented, limited test coverage. a few known
> >   issues.
> > 
> > * samba VFS integration: implemented, limited test coverage.
> > 
> > * ganesha NFS integration: implemented, no test coverage.
> > 
> > * kernel NFS reexport: implemented. limited test coverage. no known
> >   issues.
> > 
> > 
> > Anybody who has experienced bugs in the past should be excited by:
> > 
> > * new MDS admin socket commands to look at pending operations and client 
> >   session states. (Check them out with "ceph daemon mds.a help"!) These 
> >   will make diagnosing, debugging, and even fixing issues a lot simpler.
> > 
> > * the cephfs_journal_tool, which is capable of manipulating mds journal 
> >   state without doing difficult exports/imports and using hexedit.
> > 
> > Thanks!
> > sage
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users@lists.ceph.com
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> > 
> 
> 
> -- 
> This message has been scanned for viruses and
> dangerous content by MailScanner, and is
> believed to be clean.
> 
> 
