From: =?UTF-8?B?6JSh5qyK5pix?= <chuanyu@cs.nctu.edu.tw>
Subject: Re: About deleting container/bucket from radosgw
Date: Sat, 14 Jul 2012 23:04:51 +0800
Message-ID: <CAKG+gh--UPGuwqXbSKvJtq2DJG5Z2NCr7E7fJR0nGbTqhwcpHg@mail.gmail.com>
References: <CAKG+gh-25-9PgjPBpXx4PoGSinjudVtk8xXit-LBuqXDhPyUvA@mail.gmail.com>
	<CAC-hyiE7aQ50jJHR4CMcfxv2rsBvONj6z5MFJsg=gfyWVr=w-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48984 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567Ab2GNPEx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Jul 2012 11:04:53 -0400
Received: by eekb15 with SMTP id b15so1182448eek.19
        for <ceph-devel@vger.kernel.org>; Sat, 14 Jul 2012 08:04:52 -0700 (PDT)
In-Reply-To: <CAC-hyiE7aQ50jJHR4CMcfxv2rsBvONj6z5MFJsg=gfyWVr=w-w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

2012/7/14 Yehuda Sadeh <yehuda@inktank.com>:
> On Sat, Jul 14, 2012 at 6:45 AM, =E8=94=A1=E6=AC=8A=E6=98=B1 <chuanyu=
@cs.nctu.edu.tw> wrote:
>> Hello everyone,
>>
>> I try to use radosgw to supply s3/swift storage,
>>
>> everything is fine, but I found that something strange
>>
>> after deleting a container/bucket from radosgw,
>>
>> the following are commands I ran:
>>
>> 1. check the pool empty or not
>> $ rados --pool=3D.rgw ls | grep -v "^\." ; echo =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D; rados
>> --pool=3D.rgw.buckets ls
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> 2. create a container "buck1"
>> $ swift -A http://volume/auth -U account -K key post buck1
>>
>> 3. show created objs in ceph
>> $ rados --pool=3D.rgw ls | grep -v "^\." ; echo =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D; rados
>> --pool=3D.rgw.buckets ls
>> 9352.10
>> buck1
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> .dir.9352.10
>>
>> 4. delete "buck1"
>> swift -A http://volume/auth -U account -K key delete buck1
>>
>> 5. show objs in ceph
>> $ rados --pool=3D.rgw ls | grep -v "^\." ; echo =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D; rados
>> --pool=3D.rgw.buckets ls
>> 9352.10
>>
>> Then, the object '9352.10' seems like be leaved in pool forever ?
>> I have tried create & delete bucket by s3lib, too,
>> and the result is the same.
>>
>> However, the function works fine,
>> I just want to know is this a normal case?
>>
>
> This is normal, though we modified this behavior recently, so you
> shouldn't see that in the next versions. We used to keep the bucket
> index by bucket instance id for archival and also for usage
> processing.
OK, I see.

On the other hand, why radosgw-admin doesn't supply "bucket rm" call?
When I want to "user rm" a user, it seems like I need to "bucket unlink=
"
all buckets belongs to the user, but the buckets are still in there!
Then, the other users can not create the same name of bucket
anymore(by s3/swift).

So, Is this the only way I can do by using s3/swift client to delete bu=
ckets
which belongs to that user before "radosgw-admin user rm" ?

Can I "rm" all buckets, and "rm" the user only by radosgw-admin?

Thanks for your help!

Chuanyu
>
> Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
