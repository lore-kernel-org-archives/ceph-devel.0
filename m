From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: rbd layering
Date: Wed, 2 Feb 2011 10:15:11 -0800
Message-ID: <AANLkTi=GPTzUCYNR72oDKQmc3maEmaVqRcP988Txx56N@mail.gmail.com>
References: <Pine.LNX.4.64.1101312141360.8040@cobra.newdream.net>
	<AANLkTikk_pm2JHQy5+sqSPK_vi-NYaxhUSr=YNYsUSw=@mail.gmail.com>
	<AANLkTimeL7W-1uz3m2HOJn-b-kGkLDBnOFYdhx56uFM3@mail.gmail.com>
	<AANLkTi=sAOdCZ7KeS2RJ89a4Fzjoy+NPvGrWEfG6b+y0@mail.gmail.com>
	<Pine.LNX.4.64.1102020942240.18507@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43319 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754417Ab1BBSPO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Feb 2011 13:15:14 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id E0809C065
	for <ceph-devel@vger.kernel.org>; Wed,  2 Feb 2011 10:15:13 -0800 (PST)
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	by mail.hq.newdream.net (Postfix) with ESMTP id 8E1D6C063
	for <ceph-devel@vger.kernel.org>; Wed,  2 Feb 2011 10:15:13 -0800 (PST)
Received: by ewy5 with SMTP id 5so212741ewy.19
        for <ceph-devel@vger.kernel.org>; Wed, 02 Feb 2011 10:15:12 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1102020942240.18507@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

On Wed, Feb 2, 2011 at 9:47 AM, Sage Weil <sage@newdream.net> wrote:
> When I mentioned allocation bitmap before, I meant simply a bitmap
> specifying whether the block exists, that would let us avoid looking =
for
> an object in the parent image. =A0In its simplest form, you would mar=
k the
> image read-only, then generate the bitmap once.
> ...
> Mainly I'm interested in feedback on the simple layering use-case...
So my thought with the bitmap was that it might make more sense for
rbd to maintain a bitmap specifying whether the child has overwritten
the parent block device. Then when doing a read in the parent region,
rbd defaults to reading the parent block device unless the bitmap says
the child has overwritten it.
This is reasonably fast in terms of failed reads and such: assuming
the bitmap is kept in-memory, you don't need to do multiple attempts
to do a read, and if the client wants to zero a block, or overwrites a
block and then deletes it, there's no concern about preventing
inappropriate fall-through to the parent since the bitmap still has
that block set as overwritten.

The other advantage to something like this is that it could allow
overwriting at a finer level than the size of the child's blocks. For
instance, you might store in 4MB chunks, but that's a bit large for
some things that are going to commonly change between images like
config files. So with a bitmap with, say, 1KB resolution you could
change a config file and have rbd read the block from the parent and
then plug in the 1KB containing the config file that the child
overwrote. This doesn't require too much space: storing a
1KB-granularity bitmap for a 1GB image only requires 1MB.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
