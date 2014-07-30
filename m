From: Sage Weil <sweil@redhat.com>
Subject: Re: [PATCH]init-ceph: Adding do_cmd_okfail when calling
 ceph-crush-location
Date: Tue, 29 Jul 2014 18:02:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407291801010.5022@cobra.newdream.net>
References: <C8CF870384EBCF4CAB89D2041A5C80B301135242@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1505559202-1406682164=:5022"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55117 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbaG3BCo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jul 2014 21:02:44 -0400
In-Reply-To: <C8CF870384EBCF4CAB89D2041A5C80B301135242@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Xue, Chendi" <chendi.xue@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1505559202-1406682164=:5022
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 30 Jul 2014, Xue, Chendi wrote:
> >From 797dbf4f027200bb22ba89d2f616e254321ec023 Mon Sep 17 00:00:00 2001
> From: Chendi Xue <chendi.xue@intel.com>
> Date: Tue, 29 Jul 2014 16:45:45 +0800
> Subject: [PATCH 8/8] Adding do_cmd_okfail when calling ceph-crush-locat=
ion
>=20
> Original init-ceph doesn't use do_cmd_okfail when getting osd_location,=
=20
> which results in osds wrong mapping( verified by using "ceph osd tree" =
)

Is this when you are using the -a switch, or when you are starting daemon=
s=20
on the local host?  The -a stuff isn't well supported any more (and I've=20
half a mind to kill support for it entirely if the world weren't going=20
toward systemd anyway).

Anyway, I'm worried about what the _okfail variant will change the=20
behavior here if the location hook script exits with an error for some=20
reason...

sage


>=20
> Signed-off-by: Chendi Xue <chendi.xue@intel.com>
> ---
> src/init-ceph.in | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/init-ceph.in b/src/init-ceph.in
> index 86eb87f..09c7cbc 100644
> --- a/src/init-ceph.in
> +++ b/src/init-ceph.in
> @@ -327,7 +327,7 @@ for name in $what; do
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 if [ "${update_crush:-1}" =3D "1" -o "${update_crush:-=
1}" =3D "true" ]; then
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0# update location in crush
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0get_conf osd_location_hook "$BINDIR/ceph-c=
rush-location" "osd crush location hook"
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0=A0=A0 osd_location=3D`$osd_location_hook --cluster ce=
ph --id $id --type osd`
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 =A0=A0=A0 osd_location=3D$(do_cmd_okfail "$osd_location_hook=
 --cluster ceph --id $id --type osd")
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0get_conf osd_weight "" "osd crush initial =
weight"
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0defaultweight=3D"$(df -P -k $osd_data/. | =
tail -1 | awk '{ print sprintf("%.2f",$2/1073741824) }')"
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0get_conf osd_keyring "$osd_data/keyring" "=
keyring"
> --=20
> 1.9.1
>=20
>=20
> Best Regards,
> -Chendi
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1505559202-1406682164=:5022--
