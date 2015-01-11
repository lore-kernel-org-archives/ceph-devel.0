From: Mykola Golub <trociny@FreeBSD.org>
Subject: Re: ceph osd df
Date: Sun, 11 Jan 2015 18:31:49 +0200
Message-ID: <20150111163148.GA2749@gmail.com>
References: <alpine.DEB.2.00.1501051101010.6168@cobra.newdream.net>
 <20150110093158.GA2288@gmail.com>
 <alpine.DEB.2.00.1501101027390.26676@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:35537 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbbAKQbx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 11 Jan 2015 11:31:53 -0500
Received: by mail-la0-f46.google.com with SMTP id q1so21023123lam.5
        for <ceph-devel@vger.kernel.org>; Sun, 11 Jan 2015 08:31:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1501101027390.26676@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Sat, Jan 10, 2015 at 10:39:41AM -0800, Sage Weil wrote:

> I wonder if we should try to standardize the table formats.  'ceph osd 
> tree' current looks like
> 
> # id	weight	type name	up/down	reweight
> -1	3	root default
> -2	3		host maetl
> 0	1			osd.0	up	1	
> 1	1			osd.1	up	1	
> 2	1			osd.2	up	1	
> 
> That is, lowercase headers (with a # header prefix).  It's also not using 
> TableFormatter (which it predates).
> 
> It's also pretty sloppy with the precision and formatting:
> 
> $ ./ceph osd crush reweight osd.1 
> .0001
> reweighted item id 1 name 'osd.1' to 0.0001 in crush map
> $ ./ceph osd tree
> # id	weight	type name	up/down	reweight
> -1	2	root default
> -2	2		host maetl
> 0	1			osd.0	up	1	
> 1	9.155e-05			osd.1	up	1	
> 2	1			osd.2	up	1	
> $ ./ceph osd crush reweight osd.1 .001
> reweighted item id 1 name 'osd.1' to 0.001 in crush map
> $ ./ceph osd tree
> # id	weight	type name	up/down	reweight
> -1	2.001	root default
> -2	2.001		host maetl
> 0	1			osd.0	up	1	
> 1	0.0009918			osd.1	up	1	
> 2	1			osd.2	up	1	
> 
> Given that the *actual* precision of these weights is 16.16 bit 
> fixed-point, that's a lower bound of .00001.  I'm not sure we want to 
> print 1.00000 all the time, though?  Although I suppose it's better than
> 
>       1
>       2
>  .00001
> 
> In a perfect world I suppose TableFormatter (or whatever) would adjust the 
> precision of all printed values to the highest precision needed by any 
> item in the list, but maybe just sticking to 5 digits for 
> everything is best for simplicity.
> 
> Anyway, any interest in making a single stringify_weight() helper and 
> fixing up 'ceph osd tree' to also use it and TableFormatter too?  :)

Sure :) Thanks for the comments and suggestions. I will come with
update.

BTW, wouldn't disk usage in bytes (size used avail) be useful in this
output too? I.e something like below:

# id weight  reweight size  used avail %util var  
0    1.00000  1.00000 886G  171G  670G 19.30 1.00 
...
--
total size/used/avail: 886G/171G/670G
avg %util: 41.78  min/max var: 0.88/1.09  dev: 6.19

-- 
Mykola Golub
