From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: About ceph_clock_now()
Date: Wed, 13 Jan 2016 10:28:16 -0500
Message-ID: <20160113152816.GB24712@ultraspiritum.redhat.com>
References: <177186823.10053087.1452614184109.JavaMail.zimbra@redhat.com>
 <892700092.10054838.1452614393452.JavaMail.zimbra@redhat.com>
 <20160112173248.GA8218@ultraspiritum.redhat.com>
 <964746730.10566211.1452681675142.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58111 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746AbcAMP2S convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jan 2016 10:28:18 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id E2944C0BF2AF
	for <ceph-devel@vger.kernel.org>; Wed, 13 Jan 2016 15:28:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <964746730.10566211.1452681675142.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Erwan Velu <evelu@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 13/01/2016, Erwan Velu wrote:
[snip]
> You consider the MONOTONIC clock drifting a lot ?
> I mean an NTP adjustement can make a serious jump forward or even worse backward.

So, CLOCK_MONOTONIC will never jump backward (thus the name). And there
is a system-defined limit on how much it will ever jump forward at any
given time, though I don't know what that value is offhand. On a
well-synchronized system, at least it should give more accurate durations than
CLOCK_MONOTONIC_RAW. That said, if you're coming up from a cold boot and you're
out of sync, it could be jumpier. As I said, I am not a Timelord, this is just
what I've gathered as received wisdom. 

[snip]
> You mean we could switch some of ceph_clock_now() calls to ceph_time ? 
> We could use coarse_mono_clock to perform that.
> 
> If you agree that switching code like the one I'm speaking is valuable, I can work on it.

I think that would be very valuable, thank you.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
