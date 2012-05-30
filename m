From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: rbd command : is it possible to pass authkey in argument ?
Date: Wed, 30 May 2012 18:04:44 +0200 (CEST)
Message-ID: <5b9719d1-3349-4a5c-99f4-fa6fbd3cb4e8@mailpro>
References: <Pine.LNX.4.64.1205300825230.4642@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:47720 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729Ab2E3QFR convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 12:05:17 -0400
In-Reply-To: <Pine.LNX.4.64.1205300825230.4642@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, Wido den Hollander <wido@widodh.nl>

Thanks Sage.

I didn't have found it,it seem to be undocumented (man or rbd -h).

I have tested it, it's works !

Alexandre

----- Mail original -----=20

De: "Sage Weil" <sage@inktank.com>=20
=C3=80: "Wido den Hollander" <wido@widodh.nl>=20
Cc: "Alexandre DERUMIER" <aderumier@odiso.com>, ceph-devel@vger.kernel.=
org=20
Envoy=C3=A9: Mercredi 30 Mai 2012 17:25:33=20
Objet: Re: rbd command : is it possible to pass authkey in argument ?=20

On Wed, 30 May 2012, Wido den Hollander wrote:=20
> Hi,=20
>=20
> On 05/30/2012 11:15 AM, Alexandre DERUMIER wrote:=20
> > Hi,=20
> >=20
> > I'm writing rbd module for proxmox kvm distribution,=20
> >=20
> > Is it possible to pass authkey as argument in rbd command line ? (I=
 can do=20
> > in with qemu-rbd drive option)=20
>=20
> I'm not sure yet, have you tried with they argument "--key" ?=20

Yep, --key is what you want.=20

sage=20

>=20
> I tried and that failed and looking through the source-code it seems =
that it=20
> isn't possible yet.=20
>=20
> Adding it seems rather simple however, so it could be added.=20
>=20
> Wido=20
>=20
> >=20
> > Or does it need to use a keyring file ?=20
> >=20
> > Regards,=20
> >=20
> > Alexandre=20
> >=20
> > --=20
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in=20
> > the body of a message to majordomo@vger.kernel.org=20
> > More majordomo info at http://vger.kernel.org/majordomo-info.html=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20
>=20



--=20

--=20




	Alexandre D erumier=20
Ing=C3=A9nieur Syst=C3=A8me=20
=46ixe : 03 20 68 88 90=20
=46ax : 03 20 68 90 81=20
45 Bvd du G=C3=A9n=C3=A9ral Leclerc 59100 Roubaix - France=20
12 rue Marivaux 75002 Paris - France=20
=09
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
