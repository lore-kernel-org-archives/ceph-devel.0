From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Ceph distributed over slow link: possible?
Date: Sat, 22 Jan 2011 19:09:39 -0800
Message-ID: <AANLkTin7u__fauaDp50+K69YpB9Kc8fCoDpyBWpxzNz-@mail.gmail.com>
References: <ihcobl$bal$1@dough.gmane.org>
	<AANLkTi=1R9-BA9-iw2mJSNC8dfHE6AswZEW+MEcsLVa5@mail.gmail.com>
	<ihednn$bal$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35818 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab1AWDJk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 22 Jan 2011 22:09:40 -0500
Received: by eye27 with SMTP id 27so1463846eye.19
        for <ceph-devel@vger.kernel.org>; Sat, 22 Jan 2011 19:09:39 -0800 (PST)
In-Reply-To: <ihednn$bal$2@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matthias Urlichs <matthias@urlichs.de>
Cc: ceph-devel@vger.kernel.org

On Sat, Jan 22, 2011 at 3:06 AM, Matthias Urlichs <matthias@urlichs.de>=
 wrote:
> Hi,
>> * I don't think it's possible to control where clients go for reads =
-
>> Ceph is pretty much optimized to the case where all nodes are in a
>> single datacenter, over a more or less homogeneous network.
>
> So, what piece(s) of code decides which replica is read from?
Clients always read from the primary OSD housing the data, for
consistency purposes. We're working on implementing read-from-replicas
at the librados level, but anybody doing that is probably going to
have to manage their own consistency guarantees. We haven't discussed
implementing it in Ceph at all yet

>> For writes,
>> though, you'd be stuck with WAN speeds no matter what, because the d=
ata
>> has to go out to all replicas before the writes complete.
>
> Hmm. Too bad; I'd be more than happy with writing to one or two repli=
cas,
> and trusting CEPH to manage the rest of the copying in the background=
=2E
Unfortunately there's no provision for asynchronous replication in
Ceph's protocols -- they just don't fit within Ceph's overall design.
After all, with asynchronous replication, you don't have the right
number of data copies at all times. This is something that's unlikely
to change.

> My situation is this: my Ceph cluster is distributed over multiple
> sites. The links between sites are rather slow. :-/
>
> Storing one copy of a file at each site should not be a problem with
> a reasonable crushmap, but ..:
>
> * how can I verify on which devices a file is stored?
>
> * is it possible to teach clients to read/write from "their", i.e.
> =A0the local site's, copy of a file, instead of pulling stuff from
> =A0a remote site? Or does ceph notice the speed difference by itself?
=46rom what I've read the best (only?) solution that's designed for thi=
s
situation is xtreemfs, and it's my standard recommendation. I've not
heard back if it actually works from people who ask about it, though.'

That said, depending on your exact needs there are one or two possible
solutions with Ceph. If most of your data spends most of its life in
one data center, you could set up an OSD pool that lives in each data
center and set the appropriate parts of the filesystem to use the
appropriate pool (you can specify default layouts, which include the
pool, on directories that then apply to the hierarchy tree they root).
You'd have to manage off-site backups yourself in this case, perhaps
via something nasty like rsyncing across the FS at night? Then the
current copy of the data would always be available (albeit at slow
speed) from anywhere and you'd have local backups and off-site
nightlies.
I'm not sure how the metadata cluster would handle this in terms of
dividing authority intelligently, but hopefully it's smart enough or
could be adjusted to such reasonably easily.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
