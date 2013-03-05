From: Wido den Hollander <wido@42on.com>
Subject: Re: When ceph synchronizes journal to disk?
Date: Tue, 05 Mar 2013 14:54:42 +0100
Message-ID: <5135F922.9020206@42on.com>
References: <513343D8.8050402@cs.utah.edu> <CAPYLRzhAfvXfnCi4qRtdPEnV+v1qUy+DVED2Z0eep7eTvG__BA@mail.gmail.com> <51357589.6080202@cs.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:44506 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753608Ab3CENyp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 Mar 2013 08:54:45 -0500
In-Reply-To: <51357589.6080202@cs.utah.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xing Lin <xinglin@cs.utah.edu>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 03/05/2013 05:33 AM, Xing Lin wrote:
> Hi Gregory,
>
> Thanks for your reply.
>
> On 03/04/2013 09:55 AM, Gregory Farnum wrote:
>> The "journal [min|max] sync interval" values specify how frequently
>> the OSD's "FileStore" sends a sync to the disk. However, data is sti=
ll
>> written into the normal filesystem as it comes in, and the normal
>> filesystem continues to schedule normal dirty data writeouts. This i=
s
>> good =97 it means that when we do send a sync down you don't need to
>> wait for all (30 seconds * 100MB/s) 3GB or whatever of data to go to
>> disk before it's completed.
>
> I do not think I understand this well. When the writeahead journal mo=
de
> is in use, would you please explain what happens to a single 4M write
> request? I assume that an entry in the journal will be created for th=
is
> write request and after this entry is flushed to the journal disk, Ce=
ph
> returns successful. There should be no IO to the osd's disk. All IOs =
are
> supposed to go to the journal disk. At a later time, Ceph will start =
to
> apply these changes to the normal filesystem by reading from the firs=
t
> entry at which its previous synchronization stops. Finally, it will r=
ead
> this entry and apply this write change to the normal file system. Cou=
ld
> you please point out where is wrong in my understanding? Thanks,
>

All the data goes to the disk in write-back mode so it isn't safe yet=20
until the flush is called. That's why it goes into the journal first, t=
o=20
be consistent at all times.

If you would buffer everything in the journal and flush that at once yo=
u=20
would overload the disk for that time.

Let's say you have 300MB in the journal after 10 seconds and you want t=
o=20
flush that at once. That would mean that specific disk is unable to do=20
any other operations then writing with 60MB/sec for 5 seconds.

It's better to always write in write-back mode to the disk and flush at=
=20
a certain point.

In the meantime the scheduler can do it's job to balance between the=20
reads and the writes.

Wido

>>> >I am running 0.48.2. The related configuration is as follows.
>> If you're starting up a new cluster I recommend upgrading to the
>> bobtail series (.56.3) instead of using Argonaut =97 it's got a numb=
er
>> of enhancements you'll appreciate!
>
> Yeah, I would like to use bobtail series. However, I started to make
> small changes with Argonaut (0.48) and had ported my changes once to
> 0.48.2 when it was released. I think I am good to continue with it fo=
r
> the moment. I may consider to port my changes to bobtail series at a
> later time. Thanks,
>
> Xing
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
