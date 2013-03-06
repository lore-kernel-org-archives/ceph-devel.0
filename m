From: Xing Lin <xinglin@cs.utah.edu>
Subject: Re: When ceph synchronizes journal to disk?
Date: Tue, 05 Mar 2013 18:50:02 -0700
Message-ID: <5136A0CA.7050001@cs.utah.edu>
References: <513343D8.8050402@cs.utah.edu> <CAPYLRzhAfvXfnCi4qRtdPEnV+v1qUy+DVED2Z0eep7eTvG__BA@mail.gmail.com> <51357589.6080202@cs.utah.edu> <5135F922.9020206@42on.com> <B8143C8DB41A458098CA3B73D784685B@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rio.cs.utah.edu ([155.98.64.241]:45436 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab3CFBvf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 20:51:35 -0500
In-Reply-To: <B8143C8DB41A458098CA3B73D784685B@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: Wido den Hollander <wido@42on.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks very much for all your explanations. I am now much clearer about=
=20
it. Have a great day!

Xing

On 03/05/2013 01:12 PM, Greg Farnum wrote:
>> All the data goes to the disk in write-back mode so it isn't safe ye=
t
>> >until the flush is called. That's why it goes into the journal firs=
t, to
>> >be consistent at all times.
>> > =20
>> >If you would buffer everything in the journal and flush that at onc=
e you
>> >would overload the disk for that time.
>> > =20
>> >Let's say you have 300MB in the journal after 10 seconds and you wa=
nt to
>> >flush that at once. That would mean that specific disk is unable to=
 do
>> >any other operations then writing with 60MB/sec for 5 seconds.
>> > =20
>> >It's better to always write in write-back mode to the disk and flus=
h at
>> >a certain point.
>> > =20
>> >In the meantime the scheduler can do it's job to balance between th=
e
>> >reads and the writes.
>> > =20
>> >Wido
> Yep, what Wido said. Specifically, we do force the data to the journa=
l with an fsync or equivalent before responding to the client, but once=
 it's stable on the journal we give it to the filesystem (without doing=
 any sort of forced sync). This is necessary =E2=80=94 all reads are se=
rved from the filesystem.
> -Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
