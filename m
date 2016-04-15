From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Sessions and Persistence
Date: Fri, 15 Apr 2016 18:29:37 -0400
Message-ID: <20160415222936.GA6461@ultraspiritum.redhat.com>
References: <20160415210536.GA16458@ultraspiritum.redhat.com>
 <CAJ4mKGbhPrFbMKJi_hKAP1rKzjnX8GqQGMP+m7C_io-m1VDquA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44937 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbcDOW3p (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 15 Apr 2016 18:29:45 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 618F37F09C
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2016 22:29:39 +0000 (UTC)
Received: from ultraspiritum.redhat.com (ovpn-112-25.phx2.redhat.com [10.3.112.25])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3FMTcsQ015325
	for <ceph-devel@vger.kernel.org>; Fri, 15 Apr 2016 18:29:38 -0400
Content-Disposition: inline
In-Reply-To: <CAJ4mKGbhPrFbMKJi_hKAP1rKzjnX8GqQGMP+m7C_io-m1VDquA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 15/04/2016, Gregory Farnum wrote:
> So the most common time we really get replay operations is when one of
> the OSDs crash or a PG's acting set changes for some other reason.
> Which means these "cached" operation results need to be persisted to
> disk and then cleaned up, a la the pglog.
> I don't see anything in these data structures that explains how we do
> that efficiently, which is the biggest problem and the reason we don't
> already do reply caching. Am I missing something?

So! I had been considering the usual case of resend to be transient connection
drop between client and OSD. (An example of why feedback is nice :)

I /had/ thought of persisting thee things as a possible feature we would want to
add that administrators could turn on or off depending on the level of
reliability they wanted (and if they had some NVRAM on the machine.)

I had not thought specifically about persisting them QUICKLY in the
spinning disk case. One optimization would be refusing to cache read-only
ops so we don't have to pay for a disk-write unless we're using a disk
write. My intuition would suggest a per-OSD op-log that gets written
and committed when the PGLog entry gets committed, but I admit that's
just spur of the moment. It needs a bit more design work, but bundling
it with some of the writes we have to do already seems promising.

> And do you think maybe you could split this up into a thread for each
> topic? I'm having trouble digesting it as such a wall of text. :)

All right. I'll try to make a new thread subject new concerns as people bring
them up. (Like this one.)

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
