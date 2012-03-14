From: Mark Kampe <Mark.Kampe@dreamhost.com>
Subject: Re: ceph article for ;login:
Date: Wed, 14 Mar 2012 09:41:51 -0700
Message-ID: <4F60CA4F.5010804@dreamhost.com>
References: <20120313215123.8D6A3224804D@bear.rikfarrow.com> <Pine.LNX.4.64.1203131633460.15909@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:58092 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868Ab2CNQlw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Mar 2012 12:41:52 -0400
In-Reply-To: <Pine.LNX.4.64.1203131633460.15909@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Title
	Ceph: a next generation, open source storage platform - Part I

Target size, scope, depth:
	2K-3K words
	CRUSH, RADOS, RGW, RBD (leave CephFS for part II)
	os/storage concepts literate non-programmers

Audience:
	Engineers, admins, and technically inclined Linux community
	members who may or may not have heard of Ceph before, but might
	find it interesting to learn more about the domain, technology,
	and product.

Goals:
	Generate positive buzz,
	
		leading more potential adopters (or even community
		 members) to investigate further

		contributing to our image as smart people, great
		technology, and a high-road endeavor

Strategy:
	primary focus is technical
	educate readers about the challenges of peta-byte scale storage
	educate readers about effective approaches to addressing them
	showcase RADOS as an example of such solutions
	inspire people with the value and idealism of open source

Anti-Strategies:
	do not pitch the company/business (let technology do that)
	do not dis existing products (we're above that)

Suggested Table of Contents and word-budget

1. introduction and challenges of petabyte scale storate (200)
2. solutions to these challenges (300-400)
3. CRUSH and RADOS architecture (500 + pictures)
4. how we address those challenges (400+pictures)
5. examples of products built on top of RADOS
    RBD concept, layering, functionality, value (200+picture)
    RGW concept, layering, functionality, value (200+picture)
6. why open source is the right thing here (200)
7. state of the project ... 50% technology, 25% community, 25% company (200)
8. how to get involved (100)


