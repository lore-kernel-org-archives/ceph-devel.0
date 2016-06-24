From: John Spray <jspray@redhat.com>
Subject: Re: Problems with cephfs, rsync and xattr because cephfs internal
 xattrs are exposed to clients.
Date: Fri, 24 Jun 2016 11:08:56 +0100
Message-ID: <CALe9h7eR9+vpMFer53f-oKg8Ggws_z-0v7uvqX_fi-_B_UGjcQ@mail.gmail.com>
References: <5769A4C0.70905@wyraz.de> <alpine.DEB.2.11.1606212128450.21827@piezo.us.to>
 <CY1PR0201MB153287AC1F0E255401237EA6E82B0@CY1PR0201MB1532.namprd02.prod.outlook.com>
 <CAJ4mKGazjjLN45XWB8n+Ft_mchgy=+DC6a0X_rg25aC2ea+uKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36618 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbcFXKJR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jun 2016 06:09:17 -0400
Received: by mail-oi0-f52.google.com with SMTP id f189so108980653oig.3
        for <ceph-devel@vger.kernel.org>; Fri, 24 Jun 2016 03:09:16 -0700 (PDT)
In-Reply-To: <CAJ4mKGazjjLN45XWB8n+Ft_mchgy=+DC6a0X_rg25aC2ea+uKQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>, Michael Wyraz <michael@wyraz.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jun 22, 2016 at 9:15 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Tue, Jun 21, 2016 at 3:30 PM, Allen Samuels
> <Allen.Samuels@sandisk.com> wrote:
>> I doubt that rsync is the only application that's going to be confused by the presence of attributes it doesn't understand.
>>
>> What is the value in having these attributes be visible to user-space applications? Is there a better mechanism for conveying this information?
>
> This is something I think we've talked about before, and I keep on
> being surprised to learn we *do* list them without a specific query.
> So, what are the upsides of listing them without being asked?
>
> *) Easier to view for users
> *) If syncing between Ceph clusters with the same pool names, you can
> transfer layouts properly (except...probably xattrs are set after data
> is written in most systems, so that doesn't work?)
> *) ...I've got nothing else
>
> Downsides:
> *) Other tools get very confused by viewing xattrs they can't set
>
> Personally, I'd rather only list them when the Ceph namespace is
> specifically queried (or the xattr itself is, at whatever granularity
> we can do). This isn't like directory sizes; xattrs have defined
> semantics that we're breaking, *and* exposing them all the time just
> doesn't seem that useful. Why would anybody care about the data
> they're sharing, who doesn't already know that it's available?
> -Greg

I'm inclined to agree that we shouldn't include ceph.* xattrs in the
normal listing of xattrs.  Created tickets:
http://tracker.ceph.com/issues/16468
http://tracker.ceph.com/issues/16467

I do think it would be more correct for rsync to avoid xattrs in any
namespace it doesn't know about though; given that xattrs are meant to
be for potentially-filesystem-specific ones, it should assume that any
other namespaces are non-standard and are not necessarily safe to
copy.  Realistically though, rsync probably won't be the only tool
that ever tries to do this, so we should try to be safe against people
running any other tools that make the same assumption that listed
xattrs are copyable.

John

>>
>> There's nothing to prevent having a debug-ish toggle to expose them when you really want to see them.
>>
>> Allen Samuels
>> SanDisk |a Western Digital brand
>> 2880 Junction Avenue, San Jose, CA 95134
>> T: +1 408 801 7030| M: +1 408 780 6416
>> allen.samuels@SanDisk.com
>>
>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>>> owner@vger.kernel.org] On Behalf Of Sage Weil
>>> Sent: Tuesday, June 21, 2016 2:30 PM
>>> To: Michael Wyraz <michael@wyraz.de>
>>> Cc: ceph-devel@vger.kernel.org
>>> Subject: Re: Problems with cephfs, rsync and xattr because cephfs internal
>>> xattrs are exposed to clients.
>>>
>>> On Tue, 21 Jun 2016, Michael Wyraz wrote:
>>> > Hi,
>>> >
>>> > I do rsync based backups against a cephfs. If I do sync xattrs, rsync
>>> > tries to delete ceph-internal xattrs (e.g. ceph.dir.entries) which fails with an
>>> error.
>>> > xattrs does not get synchronized in this case.
>>> > IMO the problem is, that ceph's internal attributes are exposed to the
>>> > mounted fileystem (I can do "getfattr -n ceph.dir.entries *" on the
>>> > mounted cephfs and get results). So rsync sees these xattrs and tries to
>>> remove it.
>>> >
>>> > Example output:
>>> >
>>> >    rsync: rsync_xal_set:
>>> >    lremovexattr(""/backups/2016-05-31_00-09-
>>> 32/etc/acpi/events"","ceph.dir.entries")
>>> >    failed: Operation not supported (95)
>>> >    rsync: rsync_xal_set:
>>> >    lremovexattr(""/backups/2016-05-31_00-09-
>>> 32/etc/acpi/events"","ceph.dir.files")
>>> >    failed: Operation not supported (95)
>>> >    rsync: rsync_xal_set:
>>> >    lremovexattr(""/backups/2016-05-31_00-09-
>>> 32/etc/acpi/events"","ceph.dir.subdirs")
>>> >    failed: Operation not supported (95)
>>> >    rsync: rsync_xal_set:
>>> >    lremovexattr(""/backups/2016-05-31_00-09-
>>> 32/etc/acpi/events"","ceph.dir.rentries")
>>> >    failed: Operation not supported (95)
>>> >    rsync: rsync_xal_set:
>>> >    lremovexattr(""/backups/2016-05-31_00-09-
>>> 32/etc/acpi/events"","ceph.dir.rfiles")
>>> >    failed: Operation not supported (95)
>>> >    rsync: rsync_xal_set:
>>> >    lremovexattr(""/backups/2016-05-31_00-09-
>>> 32/etc/acpi/events"","ceph.dir.rsubdirs")
>>> >    failed: Operation not supported (95)
>>> >    rsync: rsync_xal_set:
>>> >    lremovexattr(""/backups/2016-05-31_00-09-
>>> 32/etc/acpi/events"","ceph.dir.rbytes")
>>> >    failed: Operation not supported (95)
>>> >    rsync: rsync_xal_set:
>>> >    lremovexattr(""/backups/2016-05-31_00-09-
>>> 32/etc/acpi/events"","ceph.dir.rctime")
>>> >    failed: Operation not supported (95)
>>>
>>> I think the right fix here is to patch rsync to ignore ceph.* xattrs.
>>> Does that seem reasonable?
>>>
>>> Other possible workarounds might be:
>>>
>>>  - ignore setxattr and removexattr requests on these xattrs (return success
>>> but do nothing)
>>>  - never show these xattrs in listxattr.  this makes them less useful or friendly
>>> :(
>>>
>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
>>> body of a message to majordomo@vger.kernel.org More majordomo info at
>>> http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
