From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Sessions and Persistence
Date: Fri, 15 Apr 2016 23:03:58 -0400
Message-ID: <20160416030357.GA8173@ultraspiritum.redhat.com>
References: <20160415210536.GA16458@ultraspiritum.redhat.com>
 <CAJ4mKGbhPrFbMKJi_hKAP1rKzjnX8GqQGMP+m7C_io-m1VDquA@mail.gmail.com>
 <20160415222936.GA6461@ultraspiritum.redhat.com>
 <CAJ4mKGaM=3i_hDGcRZRNbme616O_ARQ0Z4HBZ8qBt-nxLTg-5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39307 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750880AbcDPDED (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 15 Apr 2016 23:04:03 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 781FA4DAF6
	for <ceph-devel@vger.kernel.org>; Sat, 16 Apr 2016 03:04:00 +0000 (UTC)
Received: from ultraspiritum.redhat.com (ovpn-112-25.phx2.redhat.com [10.3.112.25])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3G33xkU012875
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2016 23:03:59 -0400
Content-Disposition: inline
In-Reply-To: <CAJ4mKGaM=3i_hDGcRZRNbme616O_ARQ0Z4HBZ8qBt-nxLTg-5Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 15/04/2016, Gregory Farnum wrote:
[snip]
> Well, I guess I don't have in-the-field information about the relative
> prevalence of these scenarios. But we definitely can't include
> features in RADOS that work "as long as you don't have acting set
> changes". ;)
[snip]
> This is something I've suggested in the past, but I think it's at the
> stage where somebody needs to write code demonstrating it is something
> approaching performant. If it is, I don't think anybody opposes the
> idea; if it's not, then throughput/IOP regressions are not a tradeoff
> Sam/Sage are willing to make for this IIRC (and, though I am more
> optimistic than I remember them being about our odds of success, I
> suppose I'm not either).

All right, I realize the issue now. Since the target can change if the primary
changes, the reply cache has to be not only persistent but replicated along a
PG. This makes plumbing and expiring it more complicated. But, since the reply
can be determined before sending the transaction down into the store, it
should still be fundamentally doable in a way that shouldn't hurt performance. (A
larger volume of data would need to be sent, but it should be sendable in the
same write.)

Obviously, testable code with a lack of performance regressions proclaims
and speculation about performance waits for a half hour then rides public
transportation, so I think we'll have to give this some thought and come
up with a working prototype to demonstrate the point.

So, I'll see if we can whip up a new description and a WIP branch on this
topic before too long.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
