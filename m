From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: My favorite question
Date: Tue, 26 Jul 2011 00:16:13 +0300
Message-ID: <4E2DDD1D.2040003@ufm.su>
References: <4E25646C.4000909@ufm.su>	<Pine.LNX.4.64.1107190728370.5656@cobra.newdream.net>	<4E2996DD.8040809@ufm.su> <CAF3hT9CpsEE5bnyaPiS6hv-Y+4VbwP-1uQ2CWVePXFcSKphkYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ufm.su ([77.120.103.19]:51241 "EHLO mail.ufm.su"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573Ab1GYVQR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 25 Jul 2011 17:16:17 -0400
In-Reply-To: <CAF3hT9CpsEE5bnyaPiS6hv-Y+4VbwP-1uQ2CWVePXFcSKphkYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On 07/25/2011 11:54 PM, Gregory Farnum wrote:
>
> Hmmm, what are you doing with this PG? Have you been doing any snapshots?
I'm not use snapshot in ceph. Only as simple file system. And I'm not 
doing anything "special" or "unnatural" :)

> I discussed this issue with Sam and it turns out that there's actually
> a bug in the scrubbing code because it doesn't handle cloned data
> well. That's probably what's happening here; I've created bug
> http://tracker.newdream.net/issues/1338 to deal with it.
Ok, thnx!

WBR,
     Fyodor.

