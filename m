From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Problems with cephfs, rsync and xattr because cephfs internal
 xattrs are exposed to clients.
Date: Tue, 21 Jun 2016 22:30:43 +0000
Message-ID: <CY1PR0201MB153287AC1F0E255401237EA6E82B0@CY1PR0201MB1532.namprd02.prod.outlook.com>
References: <5769A4C0.70905@wyraz.de>
 <alpine.DEB.2.11.1606212128450.21827@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0098.outbound.protection.outlook.com ([157.56.111.98]:30735
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751380AbcFUXHS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jun 2016 19:07:18 -0400
In-Reply-To: <alpine.DEB.2.11.1606212128450.21827@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Michael Wyraz <michael@wyraz.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I doubt that rsync is the only application that's going to be confused by the presence of attributes it doesn't understand.

What is the value in having these attributes be visible to user-space applications? Is there a better mechanism for conveying this information?

There's nothing to prevent having a debug-ish toggle to expose them when you really want to see them.

Allen Samuels
SanDisk |a Western Digital brand
2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com


> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Tuesday, June 21, 2016 2:30 PM
> To: Michael Wyraz <michael@wyraz.de>
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Problems with cephfs, rsync and xattr because cephfs internal
> xattrs are exposed to clients.
> 
> On Tue, 21 Jun 2016, Michael Wyraz wrote:
> > Hi,
> >
> > I do rsync based backups against a cephfs. If I do sync xattrs, rsync
> > tries to delete ceph-internal xattrs (e.g. ceph.dir.entries) which fails with an
> error.
> > xattrs does not get synchronized in this case.
> > IMO the problem is, that ceph's internal attributes are exposed to the
> > mounted fileystem (I can do "getfattr -n ceph.dir.entries *" on the
> > mounted cephfs and get results). So rsync sees these xattrs and tries to
> remove it.
> >
> > Example output:
> >
> >    rsync: rsync_xal_set:
> >    lremovexattr(""/backups/2016-05-31_00-09-
> 32/etc/acpi/events"","ceph.dir.entries")
> >    failed: Operation not supported (95)
> >    rsync: rsync_xal_set:
> >    lremovexattr(""/backups/2016-05-31_00-09-
> 32/etc/acpi/events"","ceph.dir.files")
> >    failed: Operation not supported (95)
> >    rsync: rsync_xal_set:
> >    lremovexattr(""/backups/2016-05-31_00-09-
> 32/etc/acpi/events"","ceph.dir.subdirs")
> >    failed: Operation not supported (95)
> >    rsync: rsync_xal_set:
> >    lremovexattr(""/backups/2016-05-31_00-09-
> 32/etc/acpi/events"","ceph.dir.rentries")
> >    failed: Operation not supported (95)
> >    rsync: rsync_xal_set:
> >    lremovexattr(""/backups/2016-05-31_00-09-
> 32/etc/acpi/events"","ceph.dir.rfiles")
> >    failed: Operation not supported (95)
> >    rsync: rsync_xal_set:
> >    lremovexattr(""/backups/2016-05-31_00-09-
> 32/etc/acpi/events"","ceph.dir.rsubdirs")
> >    failed: Operation not supported (95)
> >    rsync: rsync_xal_set:
> >    lremovexattr(""/backups/2016-05-31_00-09-
> 32/etc/acpi/events"","ceph.dir.rbytes")
> >    failed: Operation not supported (95)
> >    rsync: rsync_xal_set:
> >    lremovexattr(""/backups/2016-05-31_00-09-
> 32/etc/acpi/events"","ceph.dir.rctime")
> >    failed: Operation not supported (95)
> 
> I think the right fix here is to patch rsync to ignore ceph.* xattrs.
> Does that seem reasonable?
> 
> Other possible workarounds might be:
> 
>  - ignore setxattr and removexattr requests on these xattrs (return success
> but do nothing)
>  - never show these xattrs in listxattr.  this makes them less useful or friendly
> :(
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
