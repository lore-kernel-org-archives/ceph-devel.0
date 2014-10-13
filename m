From: Wido den Hollander <wido@42on.com>
Subject: Re: the state of cephfs in giant
Date: Mon, 13 Oct 2014 20:20:33 +0200
Message-ID: <543C17F1.7060308@42on.com>
References: <alpine.DEB.2.00.1410131114130.10561@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:41644 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754592AbaJMSUh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 Oct 2014 14:20:37 -0400
In-Reply-To: <alpine.DEB.2.00.1410131114130.10561@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-users@ceph.com, ceph-devel@vger.kernel.org

On 13-10-14 20:16, Sage Weil wrote:
> We've been doing a lot of work on CephFS over the past few months. This
> is an update on the current state of things as of Giant.
> 
> What we've working on:
> 
> * better mds/cephfs health reports to the monitor
> * mds journal dump/repair tool
> * many kernel and ceph-fuse/libcephfs client bug fixes
> * file size recovery improvements
> * client session management fixes (and tests)
> * admin socket commands for diagnosis and admin intervention
> * many bug fixes
> 
> We started using CephFS to back the teuthology (QA) infrastructure in the
> lab about three months ago. We fixed a bunch of stuff over the first
> month or two (several kernel bugs, a few MDS bugs). We've had no problems
> for the last month or so. We're currently running 0.86 (giant release
> candidate) with a single MDS and ~70 OSDs. Clients are running a 3.16
> kernel plus several fixes that went into 3.17.
> 
> 
> With Giant, we are at a point where we would ask that everyone try
> things out for any non-production workloads. We are very interested in
> feedback around stability, usability, feature gaps, and performance. We
> recommend:
> 

A question to clarify this for anybody out there. Do you think it is
safe to run CephFS on a cluster which is doing production RBD/RGW I/O?

Will it be the MDS/CephFS part which breaks or are there potential issue
due to OSD classes which might cause OSDs to crash due to bugs in CephFS?

I know you can't fully rule it out, but it would be useful to have this
clarified.

> * Single active MDS. You can run any number of standby MDS's, but we are
>   not focusing on multi-mds bugs just yet (and our existing multimds test
>   suite is already hitting several).
> * No snapshots. These are disabled by default and require a scary admin
>   command to enable them. Although these mostly work, there are
>   several known issues that we haven't addressed and they complicate
>   things immensely. Please avoid them for now.
> * Either the kernel client (kernel 3.17 or later) or userspace (ceph-fuse
>   or libcephfs) clients are in good working order.
> 
> The key missing feature right now is fsck (both check and repair). This is 
> *the* development focus for Hammer.
> 
> 
> Here's a more detailed rundown of the status of various features:
> 
> * multi-mds: implemented. limited test coverage. several known issues.
>   use only for non-production workloads and expect some stability
>   issues that could lead to data loss.
> 
> * snapshots: implemented. limited test coverage. several known issues.
>   use only for non-production workloads and expect some stability issues
>   that could lead to data loss.
> 
> * hard links: stable. no known issues, but there is somewhat limited
>   test coverage (we don't test creating huge link farms).
> 
> * direct io: implemented and tested for kernel client. no special
>   support for ceph-fuse (the kernel fuse driver handles this).
> 
> * xattrs: implemented, stable, tested. no known issues (for both kernel
>   and userspace clients).
> 
> * ACLs: implemented, tested for kernel client. not implemented for
>   ceph-fuse.
> 
> * file locking (fcntl, flock): supported and tested for kernel client.
>   limited test coverage. one known minor issue for kernel with fix
>   pending. implemention in progress for ceph-fuse/libcephfs.
> 
> * kernel fscache support: implmented. no test coverage. used in
>   production by adfin.
> 
> * hadoop bindings: implemented, limited test coverage. a few known
>   issues.
> 
> * samba VFS integration: implemented, limited test coverage.
> 
> * ganesha NFS integration: implemented, no test coverage.
> 
> * kernel NFS reexport: implemented. limited test coverage. no known
>   issues.
> 
> 
> Anybody who has experienced bugs in the past should be excited by:
> 
> * new MDS admin socket commands to look at pending operations and client 
>   session states. (Check them out with "ceph daemon mds.a help"!) These 
>   will make diagnosing, debugging, and even fixing issues a lot simpler.
> 
> * the cephfs_journal_tool, which is capable of manipulating mds journal 
>   state without doing difficult exports/imports and using hexedit.
> 
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
