From: Gregory Farnum <greg@inktank.com>
Subject: Re: mds: first stab at lookup-by-ino problem/soln description
Date: Wed, 16 Jan 2013 16:07:39 -0800
Message-ID: <CAPYLRzhoWNj1gyjxDiasF6gCJvLUMkdLAQ8m0_EY+02+cTFT1Q@mail.gmail.com>
References: <alpine.DEB.2.00.1301142231260.12153@cobra.newdream.net>
	<CAPYLRzg8j02fgMBC1cgUnot4XH4y--BR=PnbLo+J-RUkPBVpGQ@mail.gmail.com>
	<CAKMAVE9Y4C4VvGzXL3kS5nCpqzFMOO43m2XRgwre7OLXz+nvRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:42464 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab3AQAHk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 19:07:40 -0500
Received: by mail-qa0-f41.google.com with SMTP id o19so3835153qap.7
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 16:07:39 -0800 (PST)
In-Reply-To: <CAKMAVE9Y4C4VvGzXL3kS5nCpqzFMOO43m2XRgwre7OLXz+nvRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <sam.lang@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jan 16, 2013 at 3:54 PM, Sam Lang <sam.lang@inktank.com> wrote:
>
> On Wed, Jan 16, 2013 at 3:52 PM, Gregory Farnum <greg@inktank.com> wr=
ote:
>>
>> My biggest concern with this was how it worked on cluster with
>> multiple data pools, and Sage's initial response was to either
>> 1) create an object for each inode that lives in the metadata pool,
>> and holds the backtraces (rather than putting them as attributes on
>> the first object in the file), or
>> 2) use a more sophisticated data structure, perhaps built on Eleanor=
's
>> b-tree project from last summer
>> (http://ceph.com/community/summer-adventures-with-ceph-building-a-b-=
tree/)
>>
>> I had thought that we could just query each data pool for the object=
,
>> but Sage points out that 100-pool clusters aren't exactly unreasonab=
le
>> and that would take quite a lot of query time. And having the
>> backtraces in the data pools significantly complicates things with o=
ur
>> rules about setting layouts on new files.
>>
>> So this is going to need some kind of revision, please suggest
>> alternatives!
>
>
> Correct me if I'm wrong, but this seems like its only an issue in the=
 NFS
> reexport case, as fsck can walk through the data objects in each pool=
 (in
> parallel?) and verify back/forward consistency, so we won't have to g=
uess
> which pool an ino is in.
>
> Given that, if we could stuff the pool id in the ino for the file ret=
urned
> through the client interfaces, then we wouldn't have to guess.
>
> -sam

I'm not familiar with the interfaces at work there. Do we have a free
32 bits we can steal in order to do that stuffing? (I *think* it would
go in the NFS filehandle structure rather than the ino, right?)
We would need to also store that information in order to eventually
replace the anchor table, but of course that's much easier to deal
with. If we can just do it this way, that still leaves handling files
which don't have any data written yet =97 under our current system,
users can apply a data layout to any inode which has not had data
written to it yet. Unfortunately that gets hard to deal with if a user
touches a bunch of files and then comes back to place them the next
day. :/ I suppose un-touched files could have the special property
that their lookup data is stored in the metadata pool and it gets
moved as soon as they have data =97 in the typical case files are
written right away and so this wouldn't be any more writes, just a bit
more logic.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
