From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: radosgw + s3 + keystone + Browser-Based POST bug
Date: Thu, 29 Jan 2015 22:39:40 +0530
Message-ID: <87k3054irn.fsf@gmail.com>
References: <54CA50CF.5010109@switch.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:42854 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbbA2RKQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jan 2015 12:10:16 -0500
Received: by mail-pa0-f43.google.com with SMTP id eu11so41376615pac.2
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2015 09:10:15 -0800 (PST)
In-reply-to: <54CA50CF.5010109@switch.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Valery Tschopp <valery.tschopp@switch.ch>
Cc: ceph-devel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

Valery Tschopp writes:

> Hi guys,
>
> We have integrated our radosgw (v0.80.7) with our OpenStack Keystone=20
> server (icehouse) successfully.
>
> The "normal" S3 operations can be executed with the Keystone user's EC2=20
> credentials (EC2_ACCESS_KEY, EC2_SECRET_KEY). The radosgw correctly=20
> handles these user credentials, ask keystone to validate them, and the=20
> resulting objects belong to the Keystone tenant/project or the user=20
> (user is member of the tenant/project).
>
> But for the "Browser-based upload POST" [1] it doesn't work! The user is=
=20
> not correctly resolved, and the radosgw returns a 403 code!
>
> It looks like the s3 keystone integration doesn't work correctly when a=20
> S3 browser-based upload POST is used.
>
> See the attached log file (radosgw.log), you can clearly see the user=20
> lookup failing, and the status being set to 403:
>
>
> 2015-01-29 15:11:30.151157 7f25616fa700  0 User lookup failed!
> 2015-01-29 15:11:30.151171 7f25616fa700 15 Read=20
> RGWCORSConfiguration<CORSConfiguration><CORSRule><AllowedMethod>POST</All=
owedMethod><AllowedOrigin>https://staging.tube.switch.ch</AllowedOrigin><Al=
lowedHeader>*</AllowedHeader></CORSRule></CORSConfiguration>
> 2015-01-29 15:11:30.151184 7f25616fa700 10 Method POST is supported
> 2015-01-29 15:11:30.151195 7f25616fa700  2 req 1123:0.013204:s3:POST=20
> /:post_obj:http status=3D403
>
>
> Is this a bug? Or did we miss something else?

Looks like you may be hitting http://tracker.ceph.com/issues/10062,
where s3 POST requests were failing with keystone. There is a patch that
is merged in master[1] that addresses this. We would also love
to see this ported back to firefly/giant.

[1] https://github.com/ceph/ceph/pull/3251


Regards=20
=2D-
Abhishek

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUymlUAAoJEPnwZB8bZe1f6MMH/0Mz7PR+DZ1R2vc8IV2t/AlD
Kl6jBX/QJqXYBTEJfZYKRTNGEQDrD2aIID+K7N3fCFE1l/stE7zpZL1VoY3X1SVb
OgIKlnfsvsnauQymhI97+cYT215J86205CgxR+3XzdMsWDQ1d+fUHs+7jcAj4Iua
j5lCCJnNjqDfWPcEl7u+/LX9rWnfb5x+LQiyV1xN5fpL+Sh77v5t5sqRwi+MZDNh
cugTw7TWY9mMI2Rjq/rVvjzoxj32cRjrVYcTAFheSv2q2H/qiUn5wd5FX455VYmC
slwwQmVu/hbqq8Y7FcaLau+JniGru0RLeX/JWOgF5VgdpDi+qWhbtheQz4JMK+M=
=utwC
-----END PGP SIGNATURE-----
--=-=-=--
