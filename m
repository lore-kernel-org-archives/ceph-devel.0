From: Greg Farnum <greg@inktank.com>
Subject: Re: When ceph synchronizes journal to disk?
Date: Tue, 5 Mar 2013 12:12:05 -0800
Message-ID: <B8143C8DB41A458098CA3B73D784685B@inktank.com>
References: <513343D8.8050402@cs.utah.edu>
 <CAPYLRzhAfvXfnCi4qRtdPEnV+v1qUy+DVED2Z0eep7eTvG__BA@mail.gmail.com>
 <51357589.6080202@cs.utah.edu> <5135F922.9020206@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:52718 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309Ab3CEUMK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 15:12:10 -0500
Received: by mail-pb0-f43.google.com with SMTP id md12so4926118pbc.2
        for <ceph-devel@vger.kernel.org>; Tue, 05 Mar 2013 12:12:09 -0800 (PST)
In-Reply-To: <5135F922.9020206@42on.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Xing Lin <xinglin@cs.utah.edu>, "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Tuesday, March 5, 2013 at 5:54 AM, Wido den Hollander wrote:
> On 03/05/2013 05:33 AM, Xing Lin wrote:
> > Hi Gregory,
> > =20
> > Thanks for your reply.
> > =20
> > On 03/04/2013 09:55 AM, Gregory Farnum wrote:
> > > The "journal [min|max] sync interval" values specify how frequent=
ly
> > > the OSD's "FileStore" sends a sync to the disk. However, data is =
still
> > > written into the normal filesystem as it comes in, and the normal
> > > filesystem continues to schedule normal dirty data writeouts. Thi=
s is
> > > good =E2=80=94 it means that when we do send a sync down you don'=
t need to
> > > wait for all (30 seconds * 100MB/s) 3GB or whatever of data to go=
 to
> > > disk before it's completed.
> > =20
> > =20
> > =20
> > I do not think I understand this well. When the writeahead journal =
mode
> > is in use, would you please explain what happens to a single 4M wri=
te
> > request? I assume that an entry in the journal will be created for =
this
> > write request and after this entry is flushed to the journal disk, =
Ceph
> > returns successful. There should be no IO to the osd's disk. All IO=
s are
> > supposed to go to the journal disk. At a later time, Ceph will star=
t to
> > apply these changes to the normal filesystem by reading from the fi=
rst
> > entry at which its previous synchronization stops. Finally, it will=
 read
> > this entry and apply this write change to the normal file system. C=
ould
> > you please point out where is wrong in my understanding? Thanks,
> =20
> =20
> =20
> All the data goes to the disk in write-back mode so it isn't safe yet=
 =20
> until the flush is called. That's why it goes into the journal first,=
 to =20
> be consistent at all times.
> =20
> If you would buffer everything in the journal and flush that at once =
you =20
> would overload the disk for that time.
> =20
> Let's say you have 300MB in the journal after 10 seconds and you want=
 to =20
> flush that at once. That would mean that specific disk is unable to d=
o =20
> any other operations then writing with 60MB/sec for 5 seconds.
> =20
> It's better to always write in write-back mode to the disk and flush =
at =20
> a certain point.
> =20
> In the meantime the scheduler can do it's job to balance between the =
=20
> reads and the writes.
> =20
> Wido
Yep, what Wido said. Specifically, we do force the data to the journal =
with an fsync or equivalent before responding to the client, but once i=
t's stable on the journal we give it to the filesystem (without doing a=
ny sort of forced sync). This is necessary =E2=80=94 all reads are serv=
ed from the filesystem.
-Greg

Software Engineer #42 @ http://inktank.com | http://ceph.com =20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
