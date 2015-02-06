From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: About in_seq, out_seq in Messenger
Date: Fri, 6 Feb 2015 09:47:10 -0500 (EST)
Message-ID: <425811556.75315.1423234030246.JavaMail.zimbra@redhat.com>
References: <CACJqLyY_UoHO-JxNHcQcZFLpJT8awXb+aAtCG-dj26SdTZ-RgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:55839 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbbBFOrN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Feb 2015 09:47:13 -0500
In-Reply-To: <CACJqLyY_UoHO-JxNHcQcZFLpJT8awXb+aAtCG-dj26SdTZ-RgQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

----- Original Message -----
> From: "Haomai Wang" <haomaiwang@gmail.com>
> To: "Sage Weil" <sweil@redhat.com>, "Gregory Farnum" <greg@inktank.com>
> Cc: ceph-devel@vger.kernel.org
> Sent: Friday, February 6, 2015 12:26:18 AM
> Subject: About in_seq, out_seq in Messenger
> 
> Hi all,
> 
> Recently we enable a async messenger test job in test
> lab(http://pulpito.ceph.com/sage-2015-02-03_01:15:10-rados-master-distro-basic-multi/#).
> We hit many failed assert mostly are:
>               assert(0 == "old msgs despite reconnect_seq feature");
> 
> And assert connection all are cluster messenger which mean it's OSD
> internal connection. The policy associated this connection is
> Messenger::Policy::lossless_peer.
> 
> So when I dive into this problem, I find something confusing about
> this. Suppose these steps:
> 1. "lossless_peer" policy is used by both two side connections.
> 2. markdown one side(anyway), peer connection will try to reconnect
> 3. then we restart failed side, a new connection is built but
> initiator will think it's a old connection so sending in_seq(10)
> 4. new started connection has no message in queue and it will receive
> peer connection's in_seq(10) and call discard_requeued_up_to(10). But
> because no message in queue, it won't modify anything
> 5. now any side issue a message, it will trigger "assert(0 == "old
> msgs despite reconnect_seq feature");"
> 
> I can replay these steps in unittest and actually it's hit in test lab
> for async messenger which follows simple messenger's design.
> 
> Besides, if we enable reset_check here, "was_session_reset" will be
> called and it will random out_seq, so it will certainly hit "assert(0
> == "skipped incoming seq")".
> 
> Anything wrong above?

Sage covered most of this. I'll just add that the last time I checked it, I came to the conclusion that the code to use a random out_seq on initial connect was non-functional. So there definitely may be issues there.

In fact, we've fixed a couple (several?) bugs in this area since Firefly was initially released, so if you go over the point release SimpleMessenger patches you might gain some insight. :)
-Greg
