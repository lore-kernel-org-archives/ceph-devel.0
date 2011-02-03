From: Christian Brunner <chb@muc.de>
Subject: Re: rbd layering
Date: Thu, 3 Feb 2011 21:36:29 +0100
Message-ID: <AANLkTinVzfmuiAG0YZ9ULCABj0rPNdmB6xP1xLq-29WS@mail.gmail.com>
References: <Pine.LNX.4.64.1101312141360.8040@cobra.newdream.net>
	<AANLkTikk_pm2JHQy5+sqSPK_vi-NYaxhUSr=YNYsUSw=@mail.gmail.com>
	<AANLkTimeL7W-1uz3m2HOJn-b-kGkLDBnOFYdhx56uFM3@mail.gmail.com>
	<AANLkTi=sAOdCZ7KeS2RJ89a4Fzjoy+NPvGrWEfG6b+y0@mail.gmail.com>
	<Pine.LNX.4.64.1102020942240.18507@cobra.newdream.net>
	<AANLkTi=GPTzUCYNR72oDKQmc3maEmaVqRcP988Txx56N@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43332 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab1BCUga convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Feb 2011 15:36:30 -0500
Received: by iyj18 with SMTP id 18so1450913iyj.19
        for <ceph-devel@vger.kernel.org>; Thu, 03 Feb 2011 12:36:30 -0800 (PST)
In-Reply-To: <AANLkTi=GPTzUCYNR72oDKQmc3maEmaVqRcP988Txx56N@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

2011/2/2 Gregory Farnum <gregf@hq.newdream.net>:
> On Wed, Feb 2, 2011 at 9:47 AM, Sage Weil <sage@newdream.net> wrote:
>> When I mentioned allocation bitmap before, I meant simply a bitmap
>> specifying whether the block exists, that would let us avoid looking=
 for
>> an object in the parent image. =A0In its simplest form, you would ma=
rk the
>> image read-only, then generate the bitmap once.
>> ...
>> Mainly I'm interested in feedback on the simple layering use-case...
> So my thought with the bitmap was that it might make more sense for
> rbd to maintain a bitmap specifying whether the child has overwritten
> the parent block device. Then when doing a read in the parent region,
> rbd defaults to reading the parent block device unless the bitmap say=
s
> the child has overwritten it.
> This is reasonably fast in terms of failed reads and such: assuming
> the bitmap is kept in-memory, you don't need to do multiple attempts
> to do a read, and if the client wants to zero a block, or overwrites =
a
> block and then deletes it, there's no concern about preventing
> inappropriate fall-through to the parent since the bitmap still has
> that block set as overwritten.
>
> The other advantage to something like this is that it could allow
> overwriting at a finer level than the size of the child's blocks. For
> instance, you might store in 4MB chunks, but that's a bit large for
> some things that are going to commonly change between images like
> config files. So with a bitmap with, say, 1KB resolution you could
> change a config file and have rbd read the block from the parent and
> then plug in the 1KB containing the config file that the child
> overwrote. This doesn't require too much space: storing a
> 1KB-granularity bitmap for a 1GB image only requires 1MB.
> -Greg

I would go for this kind of allocation bitmap, too. However I'm asking
myself if we could add TRIM support this way as well.

In my scenario the bitmap would be available in every image and should
have a 512 Byte resolution to match the block size of common hard
disks and the bitmap needs to support three states:

0: Block is not allocated
1: Block is allocated in this image (child)
2: Block is allocated in the parent image

- When we create a new image the bitmap is filled with zero.
- When we clone an image we have to copy the bitmap and switch every
allocated block from state 1 to state 2.
- When we are writing to a block in state 0 or state 2 we have to set
it to state 1 and we will have to sync the bitmap to disk.
- When a block is discarded we set the state to 0 and we will have to
sync the bitmap to disk.
- When all blocks of an object are set to 0 we can delete the object.

This way the only performance impact would be at the first write to a b=
lock.

Regards
Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
