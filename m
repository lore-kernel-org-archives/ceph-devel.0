From: Gregory Farnum <greg@inktank.com>
Subject: Re: mds: first stab at lookup-by-ino problem/soln description
Date: Wed, 16 Jan 2013 17:33:00 -0800
Message-ID: <CAPYLRzh+wi1CbiK45QzJkw33yUd7aNYhbPtAf=b7UoejVQTjuw@mail.gmail.com>
References: <alpine.DEB.2.00.1301142231260.12153@cobra.newdream.net>
	<CAPYLRzg8j02fgMBC1cgUnot4XH4y--BR=PnbLo+J-RUkPBVpGQ@mail.gmail.com>
	<CAKMAVE9Y4C4VvGzXL3kS5nCpqzFMOO43m2XRgwre7OLXz+nvRQ@mail.gmail.com>
	<CAPYLRzhoWNj1gyjxDiasF6gCJvLUMkdLAQ8m0_EY+02+cTFT1Q@mail.gmail.com>
	<alpine.DEB.2.00.1301161715090.17435@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:53027 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756821Ab3AQBdB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 20:33:01 -0500
Received: by mail-qa0-f44.google.com with SMTP id o13so42278qaj.17
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 17:33:00 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301161715090.17435@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Sam Lang <sam.lang@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Jan 16, 2013 at 5:17 PM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 16 Jan 2013, Gregory Farnum wrote:
>> I'm not familiar with the interfaces at work there. Do we have a free
>> 32 bits we can steal in order to do that stuffing? (I *think* it would
>> go in the NFS filehandle structure rather than the ino, right?)
>
> Right, there is at least 8 more bytes in a standard fh (16 bytes iirc) to
> stuff whatever we want into.
>
>> We would need to also store that information in order to eventually
>> replace the anchor table, but of course that's much easier to deal
>> with. If we can just do it this way, that still leaves handling files
>> which don't have any data written yet ? under our current system,
>> users can apply a data layout to any inode which has not had data
>> written to it yet. Unfortunately that gets hard to deal with if a user
>> touches a bunch of files and then comes back to place them the next
>> day. :/ I suppose un-touched files could have the special property
>> that their lookup data is stored in the metadata pool and it gets
>> moved as soon as they have data ? in the typical case files are
>> written right away and so this wouldn't be any more writes, just a bit
>> more logic.
>
> We can also change the semantics, here.  It could be that you have to
> specify the file's layout on create, and can't after it was created.
> Otherwise you get the directory/subtree's layout.  We could store the pool
> with the remote dentry link, for instance, and we could stick it in the
> fh.  So the <ino, pool> is really the "locator" that you would need.
>
> That could work...

I'm less a fan of forcing users to specify file layouts on create
since there aren't any standard interfaces which would let them do
that, so a lot of use cases would be restricted to directory-level
layout changes. Granted that covers the big ones, but we do have a
non-zero number of users who have learned our previous semantics,
right?
