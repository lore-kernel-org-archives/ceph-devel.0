From: Sage Weil <sage@inktank.com>
Subject: Re: Tuning placement group
Date: Fri, 20 Jul 2012 12:43:13 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207201238260.10203@cobra.newdream.net>
References: <20120720163311.GB17454@potjevlesh.enovance.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44174 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab2GTTnN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 15:43:13 -0400
In-Reply-To: <20120720163311.GB17454@potjevlesh.enovance.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Fran=E7ois_Charlier?= <francois.charlier@enovance.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 20 Jul 2012, Fran?ois Charlier wrote:
> Hello,
> 
> Reading    http://ceph.com/docs/master/ops/manage/grow/placement-groups/
> and thinking to build a ceph cluster with potentially 1000 OSDs.
> 
> Using the recommandations on the previously cited link, it would require
> pg_num being set between 10,000 &  30,000. Okay with that. Let's use the
> recommended value of 16,384 ; this  is alreay about 160 placement groups
> per OSD.

I think you mean (16384 * 3x) / 1000 osds ~= 50 pgs per osd?

> What  if, for  a start,  we choose  to reach  this number  of 1000  OSDs
> slowly, starting with 100 OSDs ? It's now 1600 placement groups per OSD.

~500
 
> What if  we chose 30,000 (or  32,768) placement groups to  keep room for
> expansion ?

~1000
 
> My question  is : How will  behave a Ceph  pool with 1000, 5000  or even
> 10000 placement groups per OSD ?  Will this impact performance ? How bad
> ? Can it be worked around ? Is this a problem of RAM size ? CPU usage ?
> 
> Any hint about this would be much appreciated.

It will work, but peering will be slower, and there will be more memory 
used.

The other question is when you expect to move beyond 1000 osds.  The next 
project we'll be doing on the OSD is PG splitting, which will make this 
problem adjustable.  It won't be backported to argonaut, but it will be in 
the next stable release, and will probably appear in our regular 
development release in 2-3 months.

sage

