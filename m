From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] mark rbd requiring stable pages
Date: Wed, 21 Oct 2015 22:51:05 +0200
Message-ID: <CAOi1vP8nAfr1_dNmvhNspz6ANZo2onGExU7=-agKLNr5KPxrzw@mail.gmail.com>
References: <201510151850.48348.ronny.hegewald@online.de>
	<CAOi1vP_ZDHBfCDeH6gxCKRsqoGteWv+nn7EFTexf+qsUBMHvjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36198 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbbJUUvH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Oct 2015 16:51:07 -0400
Received: by wicfx6 with SMTP id fx6so108682073wic.1
        for <ceph-devel@vger.kernel.org>; Wed, 21 Oct 2015 13:51:06 -0700 (PDT)
In-Reply-To: <CAOi1vP_ZDHBfCDeH6gxCKRsqoGteWv+nn7EFTexf+qsUBMHvjA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ronny Hegewald <ronny.hegewald@online.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>

On Fri, Oct 16, 2015 at 1:09 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> Hmm...  On the one hand, yes, we do compute CRCs, but that's optional,
> so enabling this unconditionally is probably too harsh.  OTOH we are
> talking to the network, which means all sorts of delays, retransmission
> issues, etc, so I wonder how exactly "unstable" pages behave when, say,
> added to an skb - you can't write anything to a page until networking
> is fully done with it and expect it to work.  It's particularly
> alarming that you've seen corruptions.
>
> Currently the only users of this flag are block integrity stuff and
> md-raid5, which makes me wonder what iscsi, nfs and others do in this
> area.  There's an old ticket on this topic somewhere on the tracker, so
> I'll need to research this.  Thanks for bringing this up!

Hi Mike,

I was hoping to grab you for a few minutes, but you weren't there...

I spent a better part of today reading code and mailing lists on this
topic.  It is of course a bug that we use sendpage() which inlines
pages into an skb and do nothing to keep those pages stable.  We have
csums enabled by default, so setting BDI_CAP_STABLE_WRITES in the crc
case is an obvious fix.

I looked at drbd and iscsi and I think iscsi could do the same - ditch
the fallback to sock_no_sendpage() in the datadgst_en case (and get rid
of iscsi_sw_tcp_conn::sendpage member while at it).  Using stable pages
rather than having a roll-your-own implementation which doesn't close
the race but only narrows it sounds like a win, unless copying through
sendmsg() is for some reason cheaper than stable-waiting?

drbd still needs the non-zero-copy version for its async protocol for
when they free the pages before the NIC has chance to put them on the
wire.  md-raid5 it turns out has an option to essentially disable most
of its stripe cache and so it sets BDI_CAP_STABLE_WRITES to compensate
if that option is enabled.

What I'm worried about is the !crc (!datadgst_en) case.  I'm failing to
convince myself that mucking with sendpage()ed pages while they sit in
the TCP queue (or anywhere in the networking stack, really), is safe -
there is nothing to prevent pages from being modified after sendpage()
returned and Ronny reports data corruptions that pretty much went away
with BDI_CAP_STABLE_WRITES set.  I may be, after prolonged staring at
this, starting to confuse fs with block, though.  How does that work in
iscsi land?

(There was/is also this [1] bug, which is kind of related and probably
worth looking into at some point later.  ceph shouldn't be that easily
affected - we've got state, but there is a ticket for it.)

[1] http://www.spinics.net/lists/linux-nfs/msg34913.html

Thanks,

                Ilya
