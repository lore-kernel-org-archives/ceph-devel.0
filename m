From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: speedup ceph / scaling / find the bottleneck
Date: Mon, 02 Jul 2012 08:12:59 +0200
Message-ID: <4FF13BEB.8080906@profihost.ag>
References: <59beaaec-5f12-4fb2-9c03-69f41849e89e@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35637 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932279Ab2GBGND (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jul 2012 02:13:03 -0400
In-Reply-To: <59beaaec-5f12-4fb2-9c03-69f41849e89e@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, Mark Nelson <mark.nelson@inktank.com>

Am 02.07.2012 07:02, schrieb Alexandre DERUMIER:
> Hi,
> my 2cent,
> maybe with lower range (like 100MB) of random io,
> you have more chance to aggregate them in 4MB block ?

Yes maybe. If you have just a range of 100MB the chance you'll hit the 
same 4MB block again is very high.

@sage / mark
How does the aggregation work? Does it work 4MB blockwise or target node 
based?

Greets
Stefan
