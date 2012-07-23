From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Increase number of PG
Date: Mon, 23 Jul 2012 08:57:43 +0200
Message-ID: <-5358762692366662001@unknownmsgid>
References: <-6895602369310022884@unknownmsgid> <CADvuQRFPBDeQE+aAmutJg2tkY_k-63Q0=abTA3xfOmFFNMX4wg@mail.gmail.com>
 <E9D5D1F5A022447F836E2F731FFED769@inktank.com> <CAC-hyiGK9kNCdsCj4baS6ugrBD1scY3FfKMpy5jjtDk6+YOJ5A@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61328 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387Ab2GWG5q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jul 2012 02:57:46 -0400
Received: by lbbgm6 with SMTP id gm6so7580105lbb.19
        for <ceph-devel@vger.kernel.org>; Sun, 22 Jul 2012 23:57:44 -0700 (PDT)
In-Reply-To: <CAC-hyiGK9kNCdsCj4baS6ugrBD1scY3FfKMpy5jjtDk6+YOJ5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, Tommi Virtanen <tv@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Dnia 21 lip 2012 o godz. 20:08 Yehuda Sadeh <yehuda@inktank.com> napisa=
=C5=82(a):

> On Sat, Jul 21, 2012 at 10:13 AM, Gregory Farnum <greg@inktank.com> w=
rote:
>> On Fri, Jul 20, 2012 at 1:15 PM, Tommi Virtanen <tv@inktank.com (mai=
lto:tv@inktank.com)> wrote:
>>> On Fri, Jul 20, 2012 at 8:31 AM, S=C5=82awomir Skowron <szibis@gmai=
l.com (mailto:szibis@gmail.com)> wrote:
>>>> I know that this feature is disabled, are you planning to enable t=
his
>>>> in near future ??
>>>>
>>>
>>>
>>> PG splitting/joining is the next major project for the OSD. It won'=
t
>>> be backported to argonaut, but it will be in the next stable releas=
e,
>>> and will probably appear in our regular development release in 2-3
>>> months.

Ok, so i am waiting for this feature, but in a meantime i can move my
objects to a new pool with more PG's manualy created, and use it as a
bucket pool in radosgw ?? How can i tell radosgw to use this pool, or
i can't ??
At this moment my pool .rgw.buckets have default 8 PG's, and it is
small amount, too small.

>>>
>>>> I have many of drives, and my S3 instalation use only few of them =
in
>>>> one time, and i need to improve that.
>>>>
>>>> When i use it as rbd it use all of them.
>>>
>>> Radosgw normally stores most of the data for a single S3-level obje=
ct
>>> in a single RADOS object, where as RBD stripes disk images across
>>> objects by default in 4MB chunks. If you have only a few S3 objects=
,
>>> you will see an uneven distribution. It will get more balanced as y=
ou
>>> upload more images. Also, if you use multi-part uploads, each part
>>> goes into a separate RADOS object, so that'll spread the load more
>>> evenly.
>>>
>>
>> RGW only does this for small objects =E2=80=94 I believe its default=
 chunk size is also 4MB.
>

Yes i have a lots of small objects (500k) from bajts to 2-3MB in
=2Ergw.buckets pool. They are not even hit multipart.

> Actually no. While the infrastructure is there, currently a regular
> object upload at the moment is not going to create more than 2 rados
> objects. The head object, which ad is capped at 512k and the tail, wh=
ich
> will contain the rest. As Tommi specified, multipart upload chunks
> depend on the actual upload.
> There's actually no real reason anymore for not striping, and it's
> easy enough to implement, so it might be something that we're going t=
o
> do soon.
>

This can be useful. But now in my case,  objects are too small, and if
i think right, my only option is to have more PG's to balance new
objects in more drives.

My workload looks like this:

- Max 20% are PUTs, with 99% of objects smaller then 4MB,
- 80% are GETs, and S3 metadata operations.

When workload hit worse scenario (PUT, and then only one GET), then
every GET miss the cache in NGINX, and it's goes from only few drives,
and it's hurts ;)

> Yehuda
>
> Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
