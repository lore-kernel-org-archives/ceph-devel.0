From: Ravi Pinjala <pstatic@gmail.com>
Subject: Re: Ceph distributed over slow link: possible?
Date: Sat, 22 Jan 2011 01:58:37 -0800
Message-ID: <AANLkTi=1R9-BA9-iw2mJSNC8dfHE6AswZEW+MEcsLVa5@mail.gmail.com>
References: <ihcobl$bal$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38002 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab1AVJ6j convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 22 Jan 2011 04:58:39 -0500
Received: by bwz15 with SMTP id 15so2307548bwz.19
        for <ceph-devel@vger.kernel.org>; Sat, 22 Jan 2011 01:58:38 -0800 (PST)
In-Reply-To: <ihcobl$bal$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matthias Urlichs <matthias@urlichs.de>
Cc: ceph-devel@vger.kernel.org

On Fri, Jan 21, 2011 at 11:55 AM, Matthias Urlichs <matthias@urlichs.de=
> wrote:
> Hello ceph people,
>
> My situation is this: my Ceph cluster is distributed over multiple
> sites. The links between sites are rather slow. :-/
>
> Storing one copy of a file at each site should not be a problem with
> a reasonable crushmap, but ..:
>
> * how can I verify on which devices a file is stored?
>
> * is it possible to teach clients to read/write from "their", i.e.
> =C2=A0the local site's, copy of a file, instead of pulling stuff from
> =C2=A0a remote site? Or does ceph notice the speed difference by itse=
lf?
>
> * My crushmap looks like this:
> type 0 =C2=A0device
> type 1 =C2=A0host
> type 2 =C2=A0site
> type 3 =C2=A0root
> ... (root =3D> 2 sites =3D> 2 hosts each =3D> 3 devices each)
> rule =C2=A0data {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ruleset 0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0type replicated
> =C2=A0 =C2=A0 =C2=A0 =C2=A0min_size 2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0max_size 2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0step take =C2=A0root
> =C2=A0 =C2=A0 =C2=A0 =C2=A0step chooseleaf firstn 2 type site
> =C2=A0 =C2=A0 =C2=A0 =C2=A0step emit
> }
>
> but when only one site is reachable, will there be one or two
> copies of a file? If the former, how do I fix that? If the latter,
> will the copy be redistributed when (the link to) the second site
> comes back?
>

Not an expert by any stretch, but here goes:

* I don't know of a solid way to verify where your file data is going,
but if you just want to test your replication strategy, you can write
a large file to the cluster and see which OSDs grow. (OSDs store data
in a file-based structure, so 'df' on your storage nodes will actually
give you an accurate account of where the space is used.)

* I don't think it's possible to control where clients go for reads -
Ceph is pretty much optimized to the case where all nodes are in a
single datacenter, over a more or less homogeneous network. For
writes, though, you'd be stuck with WAN speeds no matter what, because
the data has to go out to all replicas before the writes complete. So
unless your workload is very read-heavy, your performance would still
suffer if Ceph could read from the closest replica.

* With that crushmap, there'll be only one copy of your data at each
site. If you want higher replication, I think you have to put another
layer in there, something like:

min_size 4
max_size 8
step take  root
step choose firstn 0 type site
step chooseleaf firstn 2 type host
step emit

'chooseleaf' goes straight down to the device level, so we only want
to use it in the last rule. Choosing 0 in a rule selects all that are
available, so this should distribute two copies of your data at each
of your sites, even if you add more sites later on. (min_size and
max_size are updated accordingly.) CRUSH is a pretty neat system; you
could probably get fancier with the data placement rules if you want.

Again: I'm hardly an expert on this, so I'm hoping that people with
more experience will come along and correct whatever glaring errors
I've made. :)

--Ravi
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
