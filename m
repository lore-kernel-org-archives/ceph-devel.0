From: Wido den Hollander <wido@widodh.nl>
Subject: Re: [PATCH] Generate URL-safe base64 strings for keys.
Date: Wed, 04 Jul 2012 18:10:57 +0200
Message-ID: <1341418257.18922.2.camel@Nokia-N900-02-8>
References: <CADvuQRERYhuFiz07Kp_YxOo_ya6-jACJ3X2gNihp=5F83BJQiQ@mail.gmail.com>
	 <1341405987-26469-1-git-send-email-wido@widodh.nl>
	  <Pine.LNX.4.64.1207040816350.6931@cobra.newdream.net>
Reply-To: Wido den Hollander <wido@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:36906 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274Ab2GDQIq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 12:08:46 -0400
In-Reply-To: <Pine.LNX.4.64.1207040816350.6931@cobra.newdream.net>
Content-ID: <1341418257.18922.1.camel@Nokia-N900-02-8>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org


----- Oorspronkelijk bericht -----
> On Wed, 4 Jul 2012, Wido den Hollander wrote:
> > By using this we prevent scenarios where cephx keys are not accepte=
d
> > in various situations.
> >=20
> > Replacing the + and / by - and _ we generate URL-safe base64 keys
> >=20
> > Signed-off-by: Wido den Hollander <wido@widodh.nl>
>=20
> Do already properly decode URL-sage base64 encoding?
>=20

Yes, it decodes URL-safe base64 as well.

See the if statements for 62 and 63, + and - are treated equally, just =
like / and _.

Wido


> sage
>=20
> > ---
> > src/common/armor.c |=C2=A0 =C2=A0 =C2=A0  6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/src/common/armor.c b/src/common/armor.c
> > index d1d5664..7f73da1 100644
> > --- a/src/common/armor.c
> > +++ b/src/common/armor.c
> > @@ -9,7 +9,7 @@
> > * base64 encode/decode.
> > */
> >=20
> > -const char *pem_key =3D
> > "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> > +const char *pem_key =3D
> > "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
> >=20
> > static int encode_bits(int c)
> > {
> > @@ -24,9 +24,9 @@ static int decode_bits(char c)
> > =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return c - 'a' + 26;
> > =C2=A0=C2=A0=C2=A0 if (c >=3D '0' && c <=3D '9')
> > =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return c - '0' + 52;
> > -=C2=A0=C2=A0=C2=A0 if (c =3D=3D '+')
> > +=C2=A0=C2=A0=C2=A0 if (c =3D=3D '+' || c =3D=3D '-')
> > =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return 62;
> > -=C2=A0=C2=A0=C2=A0 if (c =3D=3D '/')
> > +=C2=A0=C2=A0=C2=A0 if (c =3D=3D '/' || c =3D=3D '_')
> > =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return 63;
> > =C2=A0=C2=A0=C2=A0 if (c =3D=3D '=3D')
> > =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return 0; /* just non-negativ=
e, please */
> > --=20
> > 1.7.9.5
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at=C2=A0  http://vger.kernel.org/majordomo-info=
=2Ehtml
> >=20
> >=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0  http://vger.kernel.org/majordomo-info.h=
tml

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
