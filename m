From: DongJin Lee <dongjin.lee@auckland.ac.nz>
Subject: Re: Ceph distributed over slow link: possible?
Date: Sat, 22 Jan 2011 21:45:01 +1300
Message-ID: <AANLkTi=CWdmF_TwnCieEofYKcGZKnwU==dCuLLwOVOXm@mail.gmail.com>
References: <ihcobl$bal$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2-int.auckland.ac.nz ([130.216.12.41]:14482 "EHLO
	mx2-int.auckland.ac.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab1AVIpP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 22 Jan 2011 03:45:15 -0500
Received: by vws16 with SMTP id 16so1115264vws.19
        for <ceph-devel@vger.kernel.org>; Sat, 22 Jan 2011 00:45:02 -0800 (PST)
In-Reply-To: <ihcobl$bal$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matthias Urlichs <matthias@urlichs.de>
Cc: ceph-devel@vger.kernel.org

On Sat, Jan 22, 2011 at 8:55 AM, Matthias Urlichs <matthias@urlichs.de>=
 wrote:
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
> =A0the local site's, copy of a file, instead of pulling stuff from
> =A0a remote site? Or does ceph notice the speed difference by itself?
>
> * My crushmap looks like this:
> type 0 =A0device
> type 1 =A0host
> type 2 =A0site
> type 3 =A0root
> ... (root =3D> 2 sites =3D> 2 hosts each =3D> 3 devices each)
> rule =A0data {
> =A0 =A0 =A0 =A0ruleset 0
> =A0 =A0 =A0 =A0type replicated
> =A0 =A0 =A0 =A0min_size 2
> =A0 =A0 =A0 =A0max_size 2
> =A0 =A0 =A0 =A0step take =A0root
> =A0 =A0 =A0 =A0step chooseleaf firstn 2 type site
> =A0 =A0 =A0 =A0step emit
> }
>
> but when only one site is reachable, will there be one or tw
> copies of a file? If the former, how do I fix that? If the latter,
> will the copy be redistributed when (the link to) the second site
> comes back?

I've got the similar questions, using the above example, we'd have 2 x
(2x3) setup, ok.
- e.g., using with 2x replic, I'd see that each site storing the same
replicas (i.e., mirrored)
- but I'm unsure what would happen when one of the site goes down and l=
ater up.
- more, how's the objects stored in the remaining 2 hosts with 3osds ea=
ch? (2x3)
I think there needs a multiple take or choose type to have a bit more
specific behaviors?
e.g., to further prevent the host loosing the 3osds worth of objects,
we do another 'step chooseleaf type host' ?

Thanks, DJ
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
