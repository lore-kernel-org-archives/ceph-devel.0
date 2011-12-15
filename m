From: Stratos Psomadakis <psomas@grnet.gr>
Subject: Re: Random blocks when accessing rbd images
Date: Thu, 15 Dec 2011 19:24:40 +0200
Message-ID: <4EEA2D58.2090601@grnet.gr>
References: <1404301.on6okQVZ04@pc10> <3807778.ycpoZxnZL4@pc10> <CACLRD_1LPhCC3szKfsj_pZ6-5rr=pr+P8KyWO76CxU6x0K17mA@mail.gmail.com> <6461662.le4U8ybEo2@pc10>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig177B5A82B5537C2BFC0007C2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:41882 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759156Ab1LORYs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Dec 2011 12:24:48 -0500
In-Reply-To: <6461662.le4U8ybEo2@pc10>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig177B5A82B5537C2BFC0007C2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/15/2011 06:44 PM, Guido Winkelmann wrote:
> Am Donnerstag, 15. Dezember 2011, 08:30:26 schrieben Sie:
>> 'ceph pg dump' will tell you the status (active/clean/scrubbing/etc)
>> for each pg.  Does the same pg remain in state active+clean+scrubbing
>> for more than 10 minutes?
> Well, I used ceph -s, which only gave me a summary, but there definitel=
y was a=20
> PG that was in active+clean+scrubbing for a long time (a lot longer tha=
n 10=20
> minutes), and remained so until I restarted one of the osds.
>
> Unfortunately I don't know how to reliably reproduce the problem, so I =
can't=20
> check now...
When I hit that bug, I was able to trigger it (more easily) by setting:
    osd scrub max interval =3D 120
in the [osd] section in ceph.conf, forcing the cluster to send pg scrubs
more often.

Now, if you stress the cluster a bit (some heavy I/O), coupled with
singe OSD restarts, I think you could be able to trigger it.

Btw, I was using the rbd in-kernel driver.

Some info from the debugging I did, I think that at some point after
setting finalizing_scrub =3D true, it turns out that (last_update_applied=

!=3D info.last_update), but the scrub operation is never requeued by
op_applied for some reason, and so the PG is stuck as scrubbing.

> 	Guido
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--=20
Stratos Psomadakis
<psomas@grnet.gr>



--------------enig177B5A82B5537C2BFC0007C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7qLVwACgkQid1lVeNDMmDxbQCfVNUFEG/KhKAq0ZTRRo3RH/CH
9NQAoKTjzD9txrxcER0HPfT+7uNl4Gl3
=zFaP
-----END PGP SIGNATURE-----

--------------enig177B5A82B5537C2BFC0007C2--
