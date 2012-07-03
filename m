From: Gregory Farnum <greg@inktank.com>
Subject: Re: Unable to restart Mon after reboot
Date: Tue, 3 Jul 2012 10:04:13 -0700
Message-ID: <CAPYLRzjOLiaMzJUv2YJBUmyOvCJORNTZGdnAxU_nvsriU0f=qg@mail.gmail.com>
References: <BDAE812E-2659-4025-9B30-2DEC6675B59A@100percentit.com>
	<4FE55567.6080201@inktank.com>
	<4FE558CB.4010509@inktank.com>
	<F38AD123-3C97-44BD-ABE5-33635AD6D768@100percentit.com>
	<CADvuQRFcgPOy765-cYSVT1DPjOZ5nPXSb1Lr1Xjt5e3rU7joNw@mail.gmail.com>
	<45F11B42CB5830479EF0E56A27F4E68D7F12ED@exchange1.ad.100it.net>
	<CADvuQRFkf8gHOknnj5zyRDBivYttC2Z1CCueZeXH5mnk+11fvQ@mail.gmail.com>
	<20120703165358.GA12567@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50175 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269Ab2GCREO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 13:04:14 -0400
Received: by lbbgm6 with SMTP id gm6so9778348lbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jul 2012 10:04:13 -0700 (PDT)
In-Reply-To: <20120703165358.GA12567@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Tommi Virtanen <tv@inktank.com>, David Blundell <David.Blundell@100percentit.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 3, 2012 at 9:53 AM, Christoph Hellwig <hch@infradead.org> w=
rote:
> On Tue, Jul 03, 2012 at 09:44:38AM -0700, Tommi Virtanen wrote:
>> We've seen similar issues with btrfs, and others have reported that
>> the large metadata btrfs option helps. We're still compiling
>> information, but as of right now I hear best performance tends to
>> happen with xfs; however, the lead position tends to shift around a
>> lot.
>
> Btw, does anyone know which part of the btrfs metadata is hit hard?
> It's been a while that I looked at the OSD code, but IIRC it didn't
> create too big directories, does it? =A0For heavy directory operation=
s
> XFS filesystems created using large directorit blocks (mkfs.xfs -n
> size=3D64k) will also provide additional benefits.

I could be misremembering, but I believe the fragmentation had more to
do with our async snapshots and frequent updates driving the allocator
crazy than with directory sizes (which are limited to 255 entries or
something by default). My guess is our xattrs have more of an impact
on size, and the large metadata means everything gets copied together
instead of in pieces. But Sage or Sam might want to correct me.

> Also IIRC the OSDs have a directory per VDI image
I think you misunderstood when you looked into that. There's a
directory per placement group, but those are in no way tied to the RBD
images.

> - for that kind of
> usage pattern the -o filestreams mount option of XFS should provide
> even more performance advatages. =A0Either way make sure to mount wit=
h
> -o inode64, and for not so recent kernels -o delaylog.
I'm not familiar enough with xfs' allocation mechanisms to know if
filestreams is useful given the above correction.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
