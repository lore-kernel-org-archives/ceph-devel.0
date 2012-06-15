From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: RBD speed vs threads
Date: Fri, 15 Jun 2012 22:29:25 +0200
Message-ID: <4FDB9B25.1080707@profihost.ag>
References: <4FDACEAA.8080306@profihost.ag> <4FDB24A0.8000401@inktank.com> <Pine.LNX.4.64.1206150931440.4551@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:50216 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757601Ab2FOU3Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 16:29:24 -0400
In-Reply-To: <Pine.LNX.4.64.1206150931440.4551@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 15.06.2012 18:33, schrieb Sage Weil:
> The one other thing worth mentioning here is that "thread" is really a
> misnomer.  Rados bench is actually dispatching it's IO asynchronously from
> a single thread, and the -t option is really controlling the number of
> IO's in flight.  That is more or less what you get if you have N threads
> doing a single synchronous IO each, which is why the option is called
> that.

THX

Stefan
