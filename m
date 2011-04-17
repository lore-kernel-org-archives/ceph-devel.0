From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: Suicide
Date: Sun, 17 Apr 2011 02:14:50 +0200
Message-ID: <4DAA30FA.5010206@provocation.net>
References: <4DA85AA6.8050707@provocation.net> <3704E18884CB47E081E09984151ACC7B@gmail.com> <4DA8C8FB.5050106@provocation.net> <161F0A2E50F1465996C6A9075A508C85@gmail.com> <4DA8D4EF.8090006@provocation.net> <25103BE141804650A169B6444F0D6D21@gmail.com> <4DAA2B38.1090706@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:38588 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964Ab1DQAO6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Apr 2011 20:14:58 -0400
In-Reply-To: <4DAA2B38.1090706@provocation.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


On 04/17/2011 01:50 AM, I wrote:

> However, the logs also say that another ~4000
> files were transferred between rsync's apparent hang and my ^C. 

A new rsync file push shows that some - but very far from all - of
those files had to be pushed again, either because they didn't exist
on the ceph target or because of size/time/other attribute missmatches.

Z

