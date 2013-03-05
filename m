From: Wido den Hollander <wido@42on.com>
Subject: Re: CephFS First product release discussion
Date: Tue, 05 Mar 2013 19:08:16 +0100
Message-ID: <51363490.4070408@42on.com>
References: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:44866 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758044Ab3CESIT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 Mar 2013 13:08:19 -0500
In-Reply-To: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/05/2013 06:03 PM, Greg Farnum wrote:
> This is a companion discussion to the blog post at http://ceph.com/de=
v-notes/cephfs-mds-status-discussion/ =E2=80=94 go read that!
>
> The short and slightly alternate version: I spent most of about two w=
eeks working on bugs related to snapshots in the MDS, and we started re=
alizing that we could probably do our first supported release of CephFS=
 and the related infrastructure much sooner if we didn't need to suppor=
t all of the whizbang features. (This isn't to say that the base featur=
e set is stable now, but it's much closer than when you turn on some of=
 the other things.) I'd like to get feedback from you in the community =
on what minimum supported feature set would prompt or allow you to star=
t using CephFS in real environments =E2=80=94 not what you'd *like* to =
see, but what you *need* to see. This will allow us at Inktank to prior=
itize more effectively and hopefully get out a supported release much m=
ore quickly! :)
>
> The current proposed feature set is basically what's left over after =
we've trimmed off everything we can think to split off, but if any of t=
he proposed included features are also particularly important or don't =
matter, be sure to mention them (NFS export in particular =E2=80=94 it =
works right now but isn't in great shape due to NFS filehandle caching)=
=2E
>

Great news! Although RBD and RADOS itself are already great, a lot of=20
applications would still require a shared filesystem.

Think about a (Cloud|Open)Stack environment with thousands of instances=
=20
running but also need some form of shared filesystem.

One thing I'm missing though is user-quotas, have they been discussed a=
t=20
all and what would the work to implement those involve?

I know it would require a lot more tracking per file so it's not that=20
easy and would certainly not make it into a first release, but are they=
=20
on the roadmap at all?

> Thanks,
> -Greg
>
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>

^ awesome title ;)

>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--=20
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
