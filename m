From: Zenon Panoussis <oracle@provocation.net>
Subject: Re: crush rule definitions
Date: Wed, 04 May 2011 22:34:54 +0200
Message-ID: <4DC1B86E.5070704@provocation.net>
References: <4DC197F3.3050200@provocation.net> <Pine.LNX.4.64.1105041119310.648@cobra.newdream.net> <4DC1A706.1000205@provocation.net> <Pine.LNX.4.64.1105041225010.648@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:49116 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab1EDUe5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2011 16:34:57 -0400
In-Reply-To: <Pine.LNX.4.64.1105041225010.648@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


On 05/04/2011 09:28 PM, Sage Weil wrote:

>> As an aside, I think that, to a certain extent, improving the 
>> documentation could contribute more to the code base...

> The replication is covered by
> http://ceph.newdream.net/wiki/Adjusting_replication_level

> Any specific suggestions on how that should be improved?

The wiki is a reasonably good instruction in getting ceph up and running,
but it could do a lot better in explaining the hows and whys of the system.

http://ceph.newdream.net/wiki/Adjusting_replication_level is a good example
of this. It tells you exactly how to adjust the overall replication level,
but it doesn't tell you how to control where the replicas are put. So you
go searching and you find http://ceph.newdream.net/wiki/Custom_data_placement_with_CRUSH
and it explains pretty well how to implement crush rules, but it doesn't
tell what each rule parametre actually does, nor does it (appear to) give
an exhaustive list of all parametres that are available.

So, all in all, I think that what is mostly needed in the wiki is a general
introduction to ceph, an explanation and diagram of how it works and how
its internals relate to each-other. All of this is in your thesis, I know,
but it is very difficult to connect an abstract academic paper to a concrete
configuration problem and configuration parametre.

I happily contribute to the wiki when I'm 100% sure that what I'm writing is
correct, but most of the time when I see a potential improvent of the wiki,
I lack the solid understanding that's needed for me to make that improvement
myself.

Z

