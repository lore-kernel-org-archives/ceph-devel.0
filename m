From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Giant Backports RGW failure
Date: Sun, 29 Mar 2015 19:15:59 +0530
Message-ID: <87pp7rrk6g.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33265 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbbC2Nrn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Mar 2015 09:47:43 -0400
Received: by pdnc3 with SMTP id c3so147791759pdn.0
        for <ceph-devel@vger.kernel.org>; Sun, 29 Mar 2015 06:47:42 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

We experienced a test failure for radosgw suite on giant
backports[1], the test suite in question which failed was the bucket
quota test,

```
rgw/multifs/{clusters/fixed-2.yaml frontend/civetweb.yaml fs/xfs.yaml
rgw_pool_type/replicated.yaml tasks/rgw_bucket_quota.yaml}
```

failure logs[2] :
http://pulpito.ceph.com/loic-2015-03-27_08:40:06-rgw-giant---basic-multi/82=
4286/

On a rerun of the same test[3], the suite came out green. Though there
wasn't anything to indicate a network failure in the first run, the
primary difference I could find between the 2 runs was that, in the
failed, run we could find this line at start:

2015-03-27T15:31:24.082 INFO:tasks.rgw.client.0.mira012.stdout:2015-03-27 1=
5:31:24.082177
7f1bc0ff9700 -1 failed to list objects pool_iterate returned r=3D-2

The only patch that seemed to have made into giant that affected quotas
were https://github.com/ceph/ceph/pull/3580 (related to setting quotas
to negative values), though the test run had failed much before setting
negative quotas.

What are your thoughts on this?

[1] http://tracker.ceph.com/issues/11153#rgw
[2] http://pulpito.ceph.com/loic-2015-03-27_08:40:06-rgw-giant---basic-mult=
i/824286/
[3] http://pulpito.ceph.com/abhi-2015-03-29_17:16:17-rgw-giant---basic-mult=
i/

=2D-=20
Abhishek

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJVGAIhAAoJEPnwZB8bZe1fjtMH/03vypLBK9B0MPPt6u11G/+1
jSPDfD+Hm4J+EEy5N2IZBlFw7ZiBROojJetr6sZwzaYbMyTugw+Rbu85e71AWKLI
005DUe4EuW4PQnWIamXJVB8sklPnkwXgJYwDrHWUZZ4mztYIdMznze8yVNrslrCz
/rWl6F8dKq6t53RfvuBFNBfcUBWS8JBkltRJQYLZvfo+bncLTPjCra6OGMdx1AbU
MC6T6/HkHbIjqvaaeWxb9lxzYbQAxhb9X9cyd8XRS60UBwZ7g2plmySXumz9Bvae
1DYb2j5reDTrRqwWxRj7OMwAHwP7PwGAChivXOISdxtnxrcpqfR4z33LsaI4wgw=
=NTAz
-----END PGP SIGNATURE-----
--=-=-=--
