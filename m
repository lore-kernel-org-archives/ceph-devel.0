From: Shinobu Kinjo <skinjo@redhat.com>
Subject: Re: pet project: OSD compatible daemon
Date: Fri, 11 Sep 2015 21:57:38 -0400 (EDT)
Message-ID: <465582353.15791765.1442023058578.JavaMail.zimbra@redhat.com>
References: <55EFF1A6.9060201@dachary.org> <CAFdRU728GucijsJgcw+do9dp=JLx6KpLvr42apUU1vrgxLT7Ug@mail.gmail.com> <1005119049.15552536.1441980521113.JavaMail.zimbra@redhat.com> <55F2EEF3.9060603@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:33325 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922AbbILB6n convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 21:58:43 -0400
In-Reply-To: <55F2EEF3.9060603@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Yes, that is what I'm thinking.

Shinobu

----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Shinobu Kinjo" <skinjo@redhat.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
Sent: Saturday, September 12, 2015 12:10:43 AM
Subject: Re: pet project: OSD compatible daemon



On 11/09/2015 16:08, Shinobu Kinjo wrote:
> What I'm thinking of is to use fluentd to get log with
> quite human-readable format.

If you refer to https://github.com/fluent/fluentd it's different. Or is=
 it something else ?

>=20
> Is it same of what you are thinking of?
>=20
> Shinobu
>=20
> ----- Original Message -----
> From: "Shinobu" <shinobu.kj@gmail.com>
> To: skinjo@redhat.com
> Sent: Friday, September 11, 2015 6:16:18 PM
> Subject: Fwd: pet project: OSD compatible daemon
>=20
> ---------- Forwarded message ----------
> From: Loic Dachary <loic@dachary.org>
> Date: Wed, Sep 9, 2015 at 5:45 PM
> Subject: pet project: OSD compatible daemon
> To: Ceph Development <ceph-devel@vger.kernel.org>
>=20
>=20
> Hi Ceph,
>=20
> I would like to try to write an OSD compatible daemon, as a pet proje=
ct, to
> learn Go and better understand the message flow. I suspect it may als=
o be
> useful for debug purposes but that's not my primary incentive.
>=20
> Has anyone tried something similar ? If so I'd happily contribute ins=
tead
> of starting something from scratch.
>=20
> Cheers
>=20
> P.S. Since it's a pet project it's likely to take months before there=
 is
> any kind of progress ;-)
>=20
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
