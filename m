From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Increase number of PG
Date: Sat, 21 Jul 2012 11:08:11 -0700
Message-ID: <CAC-hyiGK9kNCdsCj4baS6ugrBD1scY3FfKMpy5jjtDk6+YOJ5A@mail.gmail.com>
References: <-6895602369310022884@unknownmsgid>
	<CADvuQRFPBDeQE+aAmutJg2tkY_k-63Q0=abTA3xfOmFFNMX4wg@mail.gmail.com>
	<E9D5D1F5A022447F836E2F731FFED769@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34942 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab2GUSIM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 21 Jul 2012 14:08:12 -0400
Received: by bkwj10 with SMTP id j10so4204923bkw.19
        for <ceph-devel@vger.kernel.org>; Sat, 21 Jul 2012 11:08:11 -0700 (PDT)
In-Reply-To: <E9D5D1F5A022447F836E2F731FFED769@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Tommi Virtanen <tv@inktank.com>, =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>, ceph-devel@vger.kernel.org

On Sat, Jul 21, 2012 at 10:13 AM, Gregory Farnum <greg@inktank.com> wro=
te:
> On Fri, Jul 20, 2012 at 1:15 PM, Tommi Virtanen <tv@inktank.com (mail=
to:tv@inktank.com)> wrote:
>> On Fri, Jul 20, 2012 at 8:31 AM, S=C5=82awomir Skowron <szibis@gmail=
=2Ecom (mailto:szibis@gmail.com)> wrote:
>> > I know that this feature is disabled, are you planning to enable t=
his
>> > in near future ??
>> >
>>
>>
>> PG splitting/joining is the next major project for the OSD. It won't
>> be backported to argonaut, but it will be in the next stable release=
,
>> and will probably appear in our regular development release in 2-3
>> months.
>>
>> > I have many of drives, and my S3 instalation use only few of them =
in
>> > one time, and i need to improve that.
>> >
>> > When i use it as rbd it use all of them.
>>
>> Radosgw normally stores most of the data for a single S3-level objec=
t
>> in a single RADOS object, where as RBD stripes disk images across
>> objects by default in 4MB chunks. If you have only a few S3 objects,
>> you will see an uneven distribution. It will get more balanced as yo=
u
>> upload more images. Also, if you use multi-part uploads, each part
>> goes into a separate RADOS object, so that'll spread the load more
>> evenly.
>>
>
> RGW only does this for small objects =E2=80=94 I believe its default =
chunk size is also 4MB.

Actually no. While the infrastructure is there, currently a regular
object upload at the moment is not going to create more than 2 rados
objects. The head object, which is capped at 512k and the tail, which
will contain the rest. As Tommi specified, multipart upload chunks
depend on the actual upload.
There's actually no real reason anymore for not striping, and it's
easy enough to implement, so it might be something that we're going to
do soon.

Yehuda

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
