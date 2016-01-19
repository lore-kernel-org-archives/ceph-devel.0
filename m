From: Erwan Velu <evelu@redhat.com>
Subject: Re: About ceph_clock_now()
Date: Tue, 19 Jan 2016 11:57:40 -0500 (EST)
Message-ID: <1802162103.13759253.1453222660602.JavaMail.zimbra@redhat.com>
References: <177186823.10053087.1452614184109.JavaMail.zimbra@redhat.com> <892700092.10054838.1452614393452.JavaMail.zimbra@redhat.com> <20160112173248.GA8218@ultraspiritum.redhat.com> <964746730.10566211.1452681675142.JavaMail.zimbra@redhat.com> <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com> <1365711662.13730117.1453220271917.JavaMail.zimbra@redhat.com> <20160119162902.GA21358@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:55104 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881AbcASQ5l convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jan 2016 11:57:41 -0500
In-Reply-To: <20160119162902.GA21358@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Thanks for the review & insights.
I'll propagate the change over the code.

----- Mail original -----
De: "Adam C. Emerson" <aemerson@redhat.com>
=C3=80: "Erwan Velu" <evelu@redhat.com>
Cc: "Sage Weil" <sweil@redhat.com>, "The Sacred Order of the Squid Cybe=
rnetic" <ceph-devel@vger.kernel.org>
Envoy=C3=A9: Mardi 19 Janvier 2016 17:29:03
Objet: Re: About ceph_clock_now()

On 19/01/2016, Erwan Velu wrote:
> Before propagating the change to more code base and offer a PR with t=
hat, what do you think of this style ?
>=20
> Is it aligned with the best-pratices of the project ?
>=20
> https://gist.github.com/ErwanAliasr1/f74f7f046e9300ac2c30

One minor thing, you shouldn't use anything in time_detail directly. It=
 SHOULD
be ceph::coarse_mono_clock::now() ('detail' or leading underscores sign=
al a
'private' namespace.)

Other than that, this looks very good.

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
