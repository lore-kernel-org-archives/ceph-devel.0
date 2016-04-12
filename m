From: Wido den Hollander <wido@42on.com>
Subject: Re: RBD image name constraints
Date: Tue, 12 Apr 2016 14:47:45 +0200 (CEST)
Message-ID: <1738732185.2918.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
References: <5707A2C4.3030102@corp.ovh.com>
 <20160408202919.GA8043@gmail.com> <570B6436.9040109@corp.ovh.com>
 <20160411093703.GA17959@gmail.com>
 <1377018242.49644766.1460384950765.JavaMail.zimbra@redhat.com>
 <CAOi1vP9a1qtB0RjbEuoj=Lwy99h32KRh6OArGQO-xzAZpOndUA@mail.gmail.com>
 <570CEACA.9020104@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:56397 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418AbcDLMrv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2016 08:47:51 -0400
In-Reply-To: <570CEACA.9020104@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, Jason Dillaman <dillaman@redhat.com>, =?UTF-8?Q?Bart=C5=82omiej_=C5=9Awi=C4=99cki?= <bartlomiej.swiecki@corp.ovh.com>
Cc: Mykola Golub <mgolub@mirantis.com>, Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>


> Op 12 april 2016 om 14:32 schreef Bart=C5=82omiej =C5=9Awi=C4=99cki
> <bartlomiej.swiecki@corp.ovh.com>:
>=20
>=20
>=20
> On 04/11/2016 05:08 PM, Ilya Dryomov wrote:
> > On Mon, Apr 11, 2016 at 4:29 PM, Jason Dillaman <dillaman@redhat.co=
m> wrote:
> >
> >> It would probably make sense to relax it for non-create operations=
 and use
> >> a strict regex for create/clone/import/rename operations.
> > I think it would also make sense to start enforcing a limit on the
> > length of the image name on create/clone/etc.  I'm not pushing for =
it
> > to be 96 chars (although I do believe it'd be sensible), just that =
we
> > don't want it to be RADOS - strlen("rbd_id.").
> >
> > Thanks,
> >
> >                  Ilya
> Sounds like a good plan to me, maybe we should also consider allowed=20
> character set? Non-ascii or control characters make little sense here=
 too.
>=20

Seems like a sane thing to me:

a-z, A-Z, 0-9, -, _ and . are the characters you want to allow in a ima=
ge's
name. I can't think of anything more.

Wido

> Regards,
> Bartek
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
