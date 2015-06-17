From: John Spray <john.spray@redhat.com>
Subject: Re: rbd top
Date: Wed, 17 Jun 2015 18:59:57 +0100
Message-ID: <5581B59D.4020807@redhat.com>
References: <CAANLjFp4+tkSj5=we88nGDFh0NtmX4jYc+sE__1N8L_4X30dfw@mail.gmail.com>	<CAC6JEv8qB6xStrp1EL+gyDWAzVo91DvtDQKyMs9VDB2KtoVR6A@mail.gmail.com>	<alpine.DEB.2.00.1506150647030.18741@cobra.newdream.net>	<557EE94C.10108@redhat.com>	<CAANLjFpCt9tMhkkZ+eECXpvpXOgTCoS8wu6OEuA6S89Vbdfv_Q@mail.gmail.com>	<557F02D9.1040303@redhat.com>	<558002F0.5060607@42on.com> <CAANLjFrzxyMv7VwvL-bYre-hQ1f76JHkWwG4WGZWmd4t1EbRwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42520 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901AbbFQSAA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 17 Jun 2015 14:00:00 -0400
In-Reply-To: <CAANLjFrzxyMv7VwvL-bYre-hQ1f76JHkWwG4WGZWmd4t1EbRwA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>, Wido den Hollander <wido@42on.com>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <greg@gregs42.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 17/06/2015 18:06, Robert LeBlanc wrote:
> Well, I think this has gone well past my ability to implement. Should
> this be turned into a BP and see if someone is able to work on it?

Sorry, didn't meant to hijack your thread :-)

It might still be useful to discuss the simpler case of tracking top 
clients/top objects (i.e. just native RADOS concepts) with an LRU table 
of stats (like Sage described) as a simpler alternative to my 
custom-querying proposal.  I'm going to write a blueprint for the the 
custom query thing anyway though, as I'm kind of hot on the idea, though 
don't who/when will have time to take it on as it's a bit heavyweight.

John
