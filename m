From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: RadosGW objects to Rados object mapping
Date: Wed, 17 Sep 2014 23:53:29 +0530
Message-ID: <87iokm86lz.fsf@gmail.com>
References: <87wq92ia4z.fsf@gmail.com> <CABBk=J8a-Wh4x8mbR83Ympk2zeYCS1ko1z92ffru-XbtwE+FRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34970 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756050AbaIQSZD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Sep 2014 14:25:03 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so2671342pab.19
        for <ceph-devel@vger.kernel.org>; Wed, 17 Sep 2014 11:25:03 -0700 (PDT)
In-reply-to: <CABBk=J8a-Wh4x8mbR83Ympk2zeYCS1ko1z92ffru-XbtwE+FRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Yehuda Sadeh writes:

> On Wed, Sep 17, 2014 at 7:39 AM, Abhishek L
> <abhishek.lekshmanan@gmail.com> wrote:
>>
>> Hi,
>>
>> I'm trying to understand the internals of RadosGW, on how
>> buckets/containers, objects are mapped back to rados objects. I couldn't
>> find any docs, however a previous mailing list discussion[1] explained
>> how an S3/Swift objects are cut into rados objects and about manifests. =
I was
>> able to construct back a file uploaded to RadosGW by getting the rados
>> objects by using the manifest to figure out the rados object names.
>> For eg:
>> ```
>> # random.txt is an 8 MB text file
>> [r@ra:~/ceph/src]$ s3 -us put my-first-bucket/random filename=3Drandom.t=
xt
>> [r@ra:~/ceph/src]$ ./radosgw-admin object stat --bucket=3Dmy-first-bucke=
t --object=3Drandom  | grep prefix
>>       "prefix": "._op2xmptte2DD7z3_9EjQKgmmRcWRWL_",
>>
>> ```
>>
>> And then getting the objects via rados and joining back
>>
>> ```
>> [r@ra:~/ceph/src]$ ./rados --pool .rgw.buckets ls | grep _op2xm
>> default.4124.1__shadow_._op2xmptte2DD7z3_9EjQKgmmRcWRWL_2
>> default.4124.1__shadow_._op2xmptte2DD7z3_9EjQKgmmRcWRWL_1
>> [r@ra:~/ceph/src]$ ./rados get default.4124.1_random random.part0 --pool=
 .rgw.buckets
>> [r@ra:~/ceph/src]$ ./rados get default.4124.1__shadow_._op2xmptte2DD7z3_=
9EjQKgmmRcWRWL_1 random.part1 --pool .rgw.buckets
>> [r@ra:~/ceph/src]$ ./rados get default.4124.1__shadow_._op2xmptte2DD7z3_=
9EjQKgmmRcWRWL_2 random.part2 --pool .rgw.buckets
>>
>> # Now join the objects back
>> [r@ra:~/ceph/src]$ cat random.part0 random.part1 random.part2 > random.r=
ados.txt
>> [r@ra:~/ceph/src]$ diff random.txt random.rados.txt
>> ```
>>
>> I'm trying to find similiar information on how radosgw ends up storing
>> the buckets & metadata into rados objects, what information is
>> contained within them and how they are updated when say an object is
>> added etc. I was able to find the bucket name & bucket meta data being
>> stored in .rgw pool, but not sure how the bucket knows the objects it
>> has or buckets owned by user etc.
>>
>
> The bucket doesn't know who owns each object, this info is stored in
> the object's info. The bucket index is stored as omap information in
> the bucket instance object.=20

Ah thanks, I was able to list the objects for the buckets, by getting
omapkeys from the buckets.index pool

```
[r@ra:~/ceph/src](=E2=8E=87 master)$ ./rados -p .rgw.buckets.index ls
.dir.defualt.4124.2
.dir.default.4124.1

[r@ra:~/ceph/src](=E2=8E=87 master)$ ./rados -p .rgw.buckets.index listomap=
keys .dir.default.4124.1
big-object
file-1
object-8
random
```
=20
> The list of buckets per user is kept in
> the user metadata object (also as omap information). There's a rados
> command that lets you list the omap keys for each rados object.

This also I was able to get by inspecting the <uid>.buckets objects in
users.uid pool.

```

./rados -p .users.uid listomapkeys testid.buckets
another-bucket
my-first-bucket
```

Thanks for the info. I'll try to combine these mailing list discussions
to something of a starting point for storage in radosgw developer docs.=20

Cheers
=2D-=20
Abhishek

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUGdGhAAoJEPnwZB8bZe1fk+kH/iz7JEjBzdp+O1JRUSrgZAS5
N1hgLcKNsxbnhhOVh/k1PL74MR/0JCacC/JCNgJPx6YNGvVWMBqt/rEgyaCK+j1m
vDs7q6ZYByjRsNI3JkSeDyV2acsUaDglKFsotruFdt7elQ05ysdM13moLo0xUL2B
iogGeFZteoqRtR8gyy3DbCulPzGq7hl4iy9vzFLnB8fYcFiIXqKzIOuc84xWAO5a
Ro9z/xOGzD8BnFYPlnTgXLku4Mt53wuGbmUHgmIy70n84iLxXFpiTiOCzyK22xgD
+GfiHWIULSgNf2SBl3LVBrcrR/jBQDFGqrTZy30CYumHfCPNrwNWCb1X7VshD9s=
=hLn6
-----END PGP SIGNATURE-----
--=-=-=--
