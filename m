From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Problems with cephfs, rsync and xattr because cephfs internal
 xattrs are exposed to clients.
Date: Fri, 24 Jun 2016 06:53:43 -0700
Message-ID: <CAJ4mKGbw=JVCoLD=K0Fm7U6O27=n2RaH2NwcYqFdFMREtym4EQ@mail.gmail.com>
References: <5769A4C0.70905@wyraz.de> <alpine.DEB.2.11.1606212128450.21827@piezo.us.to>
 <CY1PR0201MB153287AC1F0E255401237EA6E82B0@CY1PR0201MB1532.namprd02.prod.outlook.com>
 <CAJ4mKGazjjLN45XWB8n+Ft_mchgy=+DC6a0X_rg25aC2ea+uKQ@mail.gmail.com>
 <CALe9h7eR9+vpMFer53f-oKg8Ggws_z-0v7uvqX_fi-_B_UGjcQ@mail.gmail.com> <alpine.DEB.2.11.1606241223090.3223@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33497 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbcFXNxp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jun 2016 09:53:45 -0400
Received: by mail-vk0-f46.google.com with SMTP id d185so151141503vkg.0
        for <ceph-devel@vger.kernel.org>; Fri, 24 Jun 2016 06:53:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1606241223090.3223@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: John Spray <jspray@redhat.com>, Allen Samuels <Allen.Samuels@sandisk.com>, Michael Wyraz <michael@wyraz.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jun 24, 2016 at 5:27 AM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 24 Jun 2016, John Spray wrote:
>> On Wed, Jun 22, 2016 at 9:15 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
>> > On Tue, Jun 21, 2016 at 3:30 PM, Allen Samuels
>> > <Allen.Samuels@sandisk.com> wrote:
>> >> I doubt that rsync is the only application that's going to be confused by the presence of attributes it doesn't understand.
>> >>
>> >> What is the value in having these attributes be visible to user-space applications? Is there a better mechanism for conveying this information?
>> >
>> > This is something I think we've talked about before, and I keep on
>> > being surprised to learn we *do* list them without a specific query.
>> > So, what are the upsides of listing them without being asked?
>> >
>> > *) Easier to view for users
>> > *) If syncing between Ceph clusters with the same pool names, you can
>> > transfer layouts properly (except...probably xattrs are set after data
>> > is written in most systems, so that doesn't work?)
>> > *) ...I've got nothing else
>> >
>> > Downsides:
>> > *) Other tools get very confused by viewing xattrs they can't set
>> >
>> > Personally, I'd rather only list them when the Ceph namespace is
>> > specifically queried (or the xattr itself is, at whatever granularity
>> > we can do). This isn't like directory sizes; xattrs have defined
>> > semantics that we're breaking, *and* exposing them all the time just
>> > doesn't seem that useful. Why would anybody care about the data
>> > they're sharing, who doesn't already know that it's available?
>> > -Greg
>>
>> I'm inclined to agree that we shouldn't include ceph.* xattrs in the
>> normal listing of xattrs.  Created tickets:
>> http://tracker.ceph.com/issues/16468
>> http://tracker.ceph.com/issues/16467
>>
>> I do think it would be more correct for rsync to avoid xattrs in any
>> namespace it doesn't know about though; given that xattrs are meant to
>> be for potentially-filesystem-specific ones, it should assume that any
>> other namespaces are non-standard and are not necessarily safe to
>> copy.  Realistically though, rsync probably won't be the only tool
>> that ever tries to do this, so we should try to be safe against people
>> running any other tools that make the same assumption that listed
>> xattrs are copyable.
>
> Yeah.
>
> My main concern is that currently getfattr -d or attr -l are an
> easy/convenient way for users to discover what interesting information
> Ceph is exposing, without any special tools.  Without this, the user has
> to know what information is there, and remember the exact name of the
> xattr(s).  It's also one way to discover whether a quota or layout is set
> on a particular directory.
>
> Maybe we could make a ceph.all vxattr that, when you get it, will dump a
> list of key/value pairs with everything?  e.g.,
>
> $ getfattr -n ceph.all .
> # file: .
> ceph.all="ceph.dir.entries=14832
> ceph.dir.files=755
> ceph.dir.rbytes=18300954645291
> ceph.dir.rctime=1466771118.09752118291
> ceph.dir.rentries=22378800
> ceph.dir.rfiles=21586687
> ceph.dir.rsubdirs=792113
> ceph.dir.subdirs=14077
> "
>
> ?  Then it's just one magic xattr to remember to discover the rest
> (including anything new we add in the future).

That's analogous to how we handle snapshot directories and is what I'd
like to see. (Unless there's some way of requesting listing of a
specific xattr namespace?)
-Greg
