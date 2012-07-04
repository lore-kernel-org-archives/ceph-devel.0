From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] Generate URL-safe base64 strings for keys.
Date: Wed, 4 Jul 2012 09:18:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207040913420.6931@cobra.newdream.net>
References: <CADvuQRERYhuFiz07Kp_YxOo_ya6-jACJ3X2gNihp=5F83BJQiQ@mail.gmail.com>
 <1341405987-26469-1-git-send-email-wido@widodh.nl>
 <Pine.LNX.4.64.1207040816350.6931@cobra.newdream.net>
 <1341418257.18922.2.camel@Nokia-N900-02-8>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1694727381-1341418704=:6931"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34220 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810Ab2GDQS1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Jul 2012 12:18:27 -0400
In-Reply-To: <1341418257.18922.2.camel@Nokia-N900-02-8>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1694727381-1341418704=:6931
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 4 Jul 2012, Wido den Hollander wrote:
> > On Wed, 4 Jul 2012, Wido den Hollander wrote:
> > > By using this we prevent scenarios where cephx keys are not accepted
> > > in various situations.
> > >=20
> > > Replacing the + and / by - and _ we generate URL-safe base64 keys
> > >=20
> > > Signed-off-by: Wido den Hollander <wido@widodh.nl>
> >=20
> > Do already properly decode URL-sage base64 encoding?
> >=20
>=20
> Yes, it decodes URL-safe base64 as well.
>=20
> See the if statements for 62 and 63, + and - are treated equally, just=20
> like / and _.

Oh, got it.  The commit description confused me... I thought this was=20
related encoding only.

I think we should break the encode and decode patches into separate=20
versions, and apply the decode to a stable branch (argonaut) and the=20
encode to the master.  That should avoid most problems with a=20
rolling/staggered upgrade...

sage


>=20
> Wido
>=20
>=20
> > sage
> >=20
> > > ---
> > > src/common/armor.c |=A0 =A0 =A0  6 +++---
> > > 1 file changed, 3 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/src/common/armor.c b/src/common/armor.c
> > > index d1d5664..7f73da1 100644
> > > --- a/src/common/armor.c
> > > +++ b/src/common/armor.c
> > > @@ -9,7 +9,7 @@
> > > * base64 encode/decode.
> > > */
> > >=20
> > > -const char *pem_key =3D
> > > "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> > > +const char *pem_key =3D
> > > "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
> > >=20
> > > static int encode_bits(int c)
> > > {
> > > @@ -24,9 +24,9 @@ static int decode_bits(char c)
> > > =A0=A0=A0 =A0=A0=A0 return c - 'a' + 26;
> > > =A0=A0=A0 if (c >=3D '0' && c <=3D '9')
> > > =A0=A0=A0 =A0=A0=A0 return c - '0' + 52;
> > > -=A0=A0=A0 if (c =3D=3D '+')
> > > +=A0=A0=A0 if (c =3D=3D '+' || c =3D=3D '-')
> > > =A0=A0=A0 =A0=A0=A0 return 62;
> > > -=A0=A0=A0 if (c =3D=3D '/')
> > > +=A0=A0=A0 if (c =3D=3D '/' || c =3D=3D '_')
> > > =A0=A0=A0 =A0=A0=A0 return 63;
> > > =A0=A0=A0 if (c =3D=3D '=3D')
> > > =A0=A0=A0 =A0=A0=A0 return 0; /* just non-negative, please */
> > > --=20
> > > 1.7.9.5
> > >=20
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > > in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at=A0  http://vger.kernel.org/majordomo-info.html
> > >=20
> > >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at=A0  http://vger.kernel.org/majordomo-info.html
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1694727381-1341418704=:6931--
