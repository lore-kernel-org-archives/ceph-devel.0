From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: About deleting container/bucket from radosgw
Date: Sat, 14 Jul 2012 07:14:53 -0700
Message-ID: <CAC-hyiE7aQ50jJHR4CMcfxv2rsBvONj6z5MFJsg=gfyWVr=w-w@mail.gmail.com>
References: <CAKG+gh-25-9PgjPBpXx4PoGSinjudVtk8xXit-LBuqXDhPyUvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48440 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323Ab2GNOOz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Jul 2012 10:14:55 -0400
Received: by bkwj10 with SMTP id j10so3805481bkw.19
        for <ceph-devel@vger.kernel.org>; Sat, 14 Jul 2012 07:14:53 -0700 (PDT)
In-Reply-To: <CAKG+gh-25-9PgjPBpXx4PoGSinjudVtk8xXit-LBuqXDhPyUvA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6JSh5qyK5pix?= <chuanyu@cs.nctu.edu.tw>
Cc: ceph-devel@vger.kernel.org

On Sat, Jul 14, 2012 at 6:45 AM, =E8=94=A1=E6=AC=8A=E6=98=B1 <chuanyu@c=
s.nctu.edu.tw> wrote:
> Hello everyone,
>
> I try to use radosgw to supply s3/swift storage,
>
> everything is fine, but I found that something strange
>
> after deleting a container/bucket from radosgw,
>
> the following are commands I ran:
>
> 1. check the pool empty or not
> $ rados --pool=3D.rgw ls | grep -v "^\." ; echo =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D; rados
> --pool=3D.rgw.buckets ls
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 2. create a container "buck1"
> $ swift -A http://volume/auth -U account -K key post buck1
>
> 3. show created objs in ceph
> $ rados --pool=3D.rgw ls | grep -v "^\." ; echo =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D; rados
> --pool=3D.rgw.buckets ls
> 9352.10
> buck1
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> .dir.9352.10
>
> 4. delete "buck1"
> swift -A http://volume/auth -U account -K key delete buck1
>
> 5. show objs in ceph
> $ rados --pool=3D.rgw ls | grep -v "^\." ; echo =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D; rados
> --pool=3D.rgw.buckets ls
> 9352.10
>
> Then, the object '9352.10' seems like be leaved in pool forever ?
> I have tried create & delete bucket by s3lib, too,
> and the result is the same.
>
> However, the function works fine,
> I just want to know is this a normal case?
>

This is normal, though we modified this behavior recently, so you
shouldn't see that in the next versions. We used to keep the bucket
index by bucket instance id for archival and also for usage
processing.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
