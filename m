From: Sage Weil <sweil@redhat.com>
Subject: RE: [PATCH]init-ceph: Adding do_cmd_okfail when calling
 ceph-crush-location
Date: Tue, 29 Jul 2014 20:44:03 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407292042020.18917@cobra.newdream.net>
References: <C8CF870384EBCF4CAB89D2041A5C80B301135242@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1407291801010.5022@cobra.newdream.net> <C8CF870384EBCF4CAB89D2041A5C80B301135373@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1112312789-1406691844=:18917"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55710 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083AbaG3DoF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jul 2014 23:44:05 -0400
In-Reply-To: <C8CF870384EBCF4CAB89D2041A5C80B301135373@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Xue, Chendi" <chendi.xue@intel.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1112312789-1406691844=:18917
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Jul 2014, Xue, Chendi wrote:
> Hi, Sage
>=20
> Yes, this happened when I use the -a switch.
>=20
> If I use do_cmd instead of do_cmd_okfail to call the location hook here=
,=20
> is it being more suitable?

I think that'll work, yeah!

> I think there are still a bunch of people using "/etc/init.d/ceph -a=20
> start" to start ceph deamon, so why leave this small problem in=20
> init-ceph when "-a" is still supported?

I think it's fine.  The main issue is that the -a mode only works for=20
clusters deployed the 'old' way (not with ceph-deploy or chef or puppet).

Anyway, I'll take a patch with do_cmd (provided you tested it and it work=
s=20
for you).  :)

sage


>=20
>=20
> Best Regards,
> -Chendi
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.ke=
rnel.org] On Behalf Of Sage Weil
> Sent: Wednesday, July 30, 2014 9:03 AM
> To: Xue, Chendi
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: [PATCH]init-ceph: Adding do_cmd_okfail when calling ceph-c=
rush-location
>=20
> Hi,
>=20
> On Wed, 30 Jul 2014, Xue, Chendi wrote:
> > >From 797dbf4f027200bb22ba89d2f616e254321ec023 Mon Sep 17 00:00:00=20
> > >2001
> > From: Chendi Xue <chendi.xue@intel.com>
> > Date: Tue, 29 Jul 2014 16:45:45 +0800
> > Subject: [PATCH 8/8] Adding do_cmd_okfail when calling=20
> > ceph-crush-location
> >=20
> > Original init-ceph doesn't use do_cmd_okfail when getting=20
> > osd_location, which results in osds wrong mapping( verified by using=20
> > "ceph osd tree" )
>=20
> Is this when you are using the -a switch, or when you are starting daem=
ons on the local host?  The -a stuff isn't well supported any more (and I=
've half a mind to kill support for it entirely if the world weren't goin=
g toward systemd anyway).
>=20
> Anyway, I'm worried about what the _okfail variant will change the beha=
vior here if the location hook script exits with an error for some reason=
...
>=20
> sage
>=20
>=20
> >=20
> > Signed-off-by: Chendi Xue <chendi.xue@intel.com>
> > ---
> > src/init-ceph.in | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/src/init-ceph.in b/src/init-ceph.in index=20
> > 86eb87f..09c7cbc 100644
> > --- a/src/init-ceph.in
> > +++ b/src/init-ceph.in
> > @@ -327,7 +327,7 @@ for name in $what; do
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 if [ "${update_crush:-1}" =3D "1" -o=20
> > "${update_crush:-1}" =3D "true" ]; then
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0# update location in crush
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0get_conf osd_location_hook "$BINDIR/cep=
h-crush-location" "osd crush location hook"
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0 osd_location=3D`$osd_location_hook=20
> > --cluster ceph --id $id --type osd`
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0=A0=A0 osd_location=3D$(do_cmd_okfail=20
> > +"$osd_location_hook --cluster ceph --id $id --type osd")
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0get_conf osd_weight "" "osd crush initi=
al weight"
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0defaultweight=3D"$(df -P -k $osd_data/.=
 | tail -1 | awk '{ print sprintf("%.2f",$2/1073741824) }')"
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0get_conf osd_keyring "$osd_data/keyring=
" "keyring"
> > --
> > 1.9.1
> >=20
> >=20
> > Best Regards,
> > -Chendi
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> > in the body of a message to majordomo@vger.kernel.org More majordomo=20
> > info at  http://vger.kernel.org/majordomo-info.html
> >=20
> >=20
>=20
>=20
--557981400-1112312789-1406691844=:18917--
