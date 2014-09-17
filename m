From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: RadosGW objects to Rados object mapping
Date: Wed, 17 Sep 2014 20:09:40 +0530
Message-ID: <87wq92ia4z.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33329 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831AbaIQOlY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Sep 2014 10:41:24 -0400
Received: by mail-pa0-f47.google.com with SMTP id ey11so2242086pad.34
        for <ceph-devel@vger.kernel.org>; Wed, 17 Sep 2014 07:41:23 -0700 (PDT)
Received: from trusty ([49.32.0.222])
        by mx.google.com with ESMTPSA id by6sm17684513pab.15.2014.09.17.07.41.21
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Sep 2014 07:41:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "'ceph-devel@vger.kernel.org'" <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to understand the internals of RadosGW, on how
buckets/containers, objects are mapped back to rados objects. I couldn't
find any docs, however a previous mailing list discussion[1] explained
how an S3/Swift objects are cut into rados objects and about manifests. I w=
as
able to construct back a file uploaded to RadosGW by getting the rados
objects by using the manifest to figure out the rados object names.=20
For eg:
```
# random.txt is an 8 MB text file
[r@ra:~/ceph/src]$ s3 -us put my-first-bucket/random filename=3Drandom.txt=
=20
[r@ra:~/ceph/src]$ ./radosgw-admin object stat --bucket=3Dmy-first-bucket -=
-object=3Drandom  | grep prefix=20
      "prefix": "._op2xmptte2DD7z3_9EjQKgmmRcWRWL_",

```

And then getting the objects via rados and joining back

```
[r@ra:~/ceph/src]$ ./rados --pool .rgw.buckets ls | grep _op2xm
default.4124.1__shadow_._op2xmptte2DD7z3_9EjQKgmmRcWRWL_2
default.4124.1__shadow_._op2xmptte2DD7z3_9EjQKgmmRcWRWL_1
[r@ra:~/ceph/src]$ ./rados get default.4124.1_random random.part0 --pool .r=
gw.buckets
[r@ra:~/ceph/src]$ ./rados get default.4124.1__shadow_._op2xmptte2DD7z3_9Ej=
QKgmmRcWRWL_1 random.part1 --pool .rgw.buckets
[r@ra:~/ceph/src]$ ./rados get default.4124.1__shadow_._op2xmptte2DD7z3_9Ej=
QKgmmRcWRWL_2 random.part2 --pool .rgw.buckets

# Now join the objects back=20
[r@ra:~/ceph/src]$ cat random.part0 random.part1 random.part2 > random.rado=
s.txt
[r@ra:~/ceph/src]$ diff random.txt random.rados.txt=20
```

I'm trying to find similiar information on how radosgw ends up storing
the buckets & metadata into rados objects, what information is
contained within them and how they are updated when say an object is
added etc. I was able to find the bucket name & bucket meta data being
stored in .rgw pool, but not sure how the bucket knows the objects it
has or buckets owned by user etc.

[1] https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg19747.html=20

Thanks
=2D-=20
Abhishek

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUGZ0tAAoJEPnwZB8bZe1fE4IH/0QXDQr5RdKjt97m+jo2nIpY
dhmgDjf1Ez45awjTY/hCDlTD8xESS+DD67SepZEIJnrW7cwmgcOoexkQivu7B/jQ
6JXGxdvoRqHd92TecynHwIvxBrrnIJb/wG3+aV5EURKRkrORy8183gYdOeQHyY1I
jlCpL5s2DUr+/C2MXg6A6sDMBEWNQcmuYyFiVmmHbKM9cZk2cayJeSG+2pq//3Tj
x+ZIi4de1dpHn6R4NWVhSSvGafw2IUhTdbqL1rjb2kao3cHErxy8BMx6SGvRywTc
uvho7pL4XacaUoegpzF7gBHXTEOuA4hEATC4h4G0hWbhzEgV+PRVb8i+MvdJ7io=
=CdnB
-----END PGP SIGNATURE-----
--=-=-=--
