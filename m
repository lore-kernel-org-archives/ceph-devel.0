From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: use striping feature
Date: Mon, 05 Nov 2012 11:38:49 -0800
Message-ID: <509815C9.5090106@inktank.com>
References: <5097AAF7.8080709@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39142 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab2KETjJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 14:39:09 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so4150640pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Nov 2012 11:39:09 -0800 (PST)
In-Reply-To: <5097AAF7.8080709@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/05/2012 04:03 AM, Stefan Priebe - Profihost AG wrote:
> Hello list,
>
> is the following syntax to use the new rbd v2 striping feature correct?
>
> rbd create -p kvmstor --format 2 --size 32000 --stripe-count 8
> --stripe-unit 131072 -s 1048576 $imagename
>
> Idea is to have 8 stripes per 1MB object size. Or are there any other
> recommondations regarding striping?

The stripe count is actually how many objects to stripe over before
repeating back to the first one. It's the number of objects in an
'object set' in the diagram at the bottom of:

http://ceph.com/docs/master/dev/file-striping/

I don't think we've done enough benchmarks to know what the best
settings are, but generally having large (like 4MB) objects
and smaller stripe units will at least help small sequential I/O.

> I'm a bit confused cause rbd info shows stripe-count as bytes?

It's not actually bytes. Sage just fixed that output in the master
branch.

Josh
