From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: RBD image name constraints
Date: Tue, 12 Apr 2016 09:01:53 -0400 (EDT)
Message-ID: <842665427.50033069.1460466113899.JavaMail.zimbra@redhat.com>
References: <5707A2C4.3030102@corp.ovh.com> <20160408202919.GA8043@gmail.com> <570B6436.9040109@corp.ovh.com> <20160411093703.GA17959@gmail.com> <1377018242.49644766.1460384950765.JavaMail.zimbra@redhat.com> <CAOi1vP9a1qtB0RjbEuoj=Lwy99h32KRh6OArGQO-xzAZpOndUA@mail.gmail.com> <570CEACA.9020104@corp.ovh.com> <1738732185.2918.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:40271 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756807AbcDLNCN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2016 09:02:13 -0400
In-Reply-To: <1738732185.2918.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, =?utf-8?Q?Bart=C5=82omiej_=C5=9Awi=C4=99cki?= <bartlomiej.swiecki@corp.ovh.com>, Mykola Golub <mgolub@mirantis.com>, Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

> > Op 12 april 2016 om 14:32 schreef Bart=C5=82omiej =C5=9Awi=C4=99cki
> > <bartlomiej.swiecki@corp.ovh.com>:
> >=20
> >=20
> >=20
> > On 04/11/2016 05:08 PM, Ilya Dryomov wrote:
> > > On Mon, Apr 11, 2016 at 4:29 PM, Jason Dillaman <dillaman@redhat.=
com>
> > > wrote:
> > >
> > >> It would probably make sense to relax it for non-create operatio=
ns and
> > >> use
> > >> a strict regex for create/clone/import/rename operations.
> > > I think it would also make sense to start enforcing a limit on th=
e
> > > length of the image name on create/clone/etc.  I'm not pushing fo=
r it
> > > to be 96 chars (although I do believe it'd be sensible), just tha=
t we
> > > don't want it to be RADOS - strlen("rbd_id.").
> > >
> > > Thanks,
> > >
> > >                  Ilya
> > Sounds like a good plan to me, maybe we should also consider allowe=
d
> > character set? Non-ascii or control characters make little sense he=
re too.
> >=20
>=20
> Seems like a sane thing to me:
>=20
> a-z, A-Z, 0-9, -, _ and . are the characters you want to allow in a i=
mage's
> name. I can't think of anything more.
>=20
> Wido
>=20
> > Regards,
> > Bartek
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

All of this sounds good to me -- we should circulate a proposal in ceph=
-users before making any change.  Assuming we can reach a plan that doe=
sn't break someone's Ceph deployment, this could be included as part of=
 the Kraken-release.

Ilya -- just so that I am clear, is the current kernel limitation 96 ch=
aracters minus the "rbd_id."-prefix (format 2) or ".rbd"-suffix (format=
 1)?

--=20

Jason Dillaman=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
