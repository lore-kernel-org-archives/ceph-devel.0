From: Sage Weil <sage@newdream.net>
Subject: Re: Problems with cephfs, rsync and xattr because cephfs internal
 xattrs are exposed to clients.
Date: Tue, 21 Jun 2016 21:30:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606212128450.21827@piezo.us.to>
References: <5769A4C0.70905@wyraz.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from batalion.com ([64.111.99.127]:56264 "EHLO localhost.localdomain"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751577AbcFUWYp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Jun 2016 18:24:45 -0400
In-Reply-To: <5769A4C0.70905@wyraz.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michael Wyraz <michael@wyraz.de>
Cc: ceph-devel@vger.kernel.org

On Tue, 21 Jun 2016, Michael Wyraz wrote:
> Hi,
> 
> I do rsync based backups against a cephfs. If I do sync xattrs, rsync tries to
> delete ceph-internal xattrs (e.g. ceph.dir.entries) which fails with an error.
> xattrs does not get synchronized in this case.
> IMO the problem is, that ceph's internal attributes are exposed to the mounted
> fileystem (I can do "getfattr -n ceph.dir.entries *" on the mounted cephfs and
> get results). So rsync sees these xattrs and tries to remove it.
> 
> Example output:
> 
>    rsync: rsync_xal_set:
>    lremovexattr(""/backups/2016-05-31_00-09-32/etc/acpi/events"","ceph.dir.entries")
>    failed: Operation not supported (95)
>    rsync: rsync_xal_set:
>    lremovexattr(""/backups/2016-05-31_00-09-32/etc/acpi/events"","ceph.dir.files")
>    failed: Operation not supported (95)
>    rsync: rsync_xal_set:
>    lremovexattr(""/backups/2016-05-31_00-09-32/etc/acpi/events"","ceph.dir.subdirs")
>    failed: Operation not supported (95)
>    rsync: rsync_xal_set:
>    lremovexattr(""/backups/2016-05-31_00-09-32/etc/acpi/events"","ceph.dir.rentries")
>    failed: Operation not supported (95)
>    rsync: rsync_xal_set:
>    lremovexattr(""/backups/2016-05-31_00-09-32/etc/acpi/events"","ceph.dir.rfiles")
>    failed: Operation not supported (95)
>    rsync: rsync_xal_set:
>    lremovexattr(""/backups/2016-05-31_00-09-32/etc/acpi/events"","ceph.dir.rsubdirs")
>    failed: Operation not supported (95)
>    rsync: rsync_xal_set:
>    lremovexattr(""/backups/2016-05-31_00-09-32/etc/acpi/events"","ceph.dir.rbytes")
>    failed: Operation not supported (95)
>    rsync: rsync_xal_set:
>    lremovexattr(""/backups/2016-05-31_00-09-32/etc/acpi/events"","ceph.dir.rctime")
>    failed: Operation not supported (95)

I think the right fix here is to patch rsync to ignore ceph.* xattrs.  
Does that seem reasonable?

Other possible workarounds might be:

 - ignore setxattr and removexattr requests on these xattrs (return 
success but do nothing)
 - never show these xattrs in listxattr.  this makes them less useful or 
friendly :(

sage
