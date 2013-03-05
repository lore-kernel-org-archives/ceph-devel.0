From: Greg Farnum <greg@inktank.com>
Subject: Re: CephFS First product release discussion
Date: Tue, 5 Mar 2013 10:17:02 -0800
Message-ID: <1F15E079964848B9BE079E974A1946B4@inktank.com>
References: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com>
 <51363490.4070408@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:46294 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755899Ab3CESRI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 13:17:08 -0500
Received: by mail-pb0-f52.google.com with SMTP id ma3so4804412pbc.39
        for <ceph-devel@vger.kernel.org>; Tue, 05 Mar 2013 10:17:07 -0800 (PST)
In-Reply-To: <51363490.4070408@42on.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org

On Tuesday, March 5, 2013 at 10:08 AM, Wido den Hollander wrote:
> On 03/05/2013 06:03 PM, Greg Farnum wrote:
> > This is a companion discussion to the blog post at http://ceph.com/=
dev-notes/cephfs-mds-status-discussion/ =E2=80=94 go read that!
> > =20
> > The short and slightly alternate version: I spent most of about two=
 weeks working on bugs related to snapshots in the MDS, and we started =
realizing that we could probably do our first supported release of Ceph=
=46S and the related infrastructure much sooner if we didn't need to su=
pport all of the whizbang features. (This isn't to say that the base fe=
ature set is stable now, but it's much closer than when you turn on som=
e of the other things.) I'd like to get feedback from you in the commun=
ity on what minimum supported feature set would prompt or allow you to =
start using CephFS in real environments =E2=80=94 not what you'd *like*=
 to see, but what you *need* to see. This will allow us at Inktank to p=
rioritize more effectively and hopefully get out a supported release mu=
ch more quickly! :)
> > =20
> > The current proposed feature set is basically what's left over afte=
r we've trimmed off everything we can think to split off, but if any of=
 the proposed included features are also particularly important or don'=
t matter, be sure to mention them (NFS export in particular =E2=80=94 i=
t works right now but isn't in great shape due to NFS filehandle cachin=
g).
> =20
> Great news! Although RBD and RADOS itself are already great, a lot of=
 =20
> applications would still require a shared filesystem.
> =20
> Think about a (Cloud|Open)Stack environment with thousands of instanc=
es =20
> running but also need some form of shared filesystem.
> =20
> One thing I'm missing though is user-quotas, have they been discussed=
 at =20
> all and what would the work to implement those involve?
> =20
> I know it would require a lot more tracking per file so it's not that=
 =20
> easy and would certainly not make it into a first release, but are th=
ey =20
> on the roadmap at all?

Not at present. I think there are some tickets related to this in the t=
racker as feature requests, but CephFS needs more groundwork about mult=
i-tenancy in general before we can do reasonable planning around a robu=
st user quota feature. (Near-real-time hacks are possible now based aro=
und the rstats infrastructure and I believe somebody has built them, th=
ough I've never seen them myself.)
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
