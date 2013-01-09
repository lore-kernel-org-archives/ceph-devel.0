From: Sage Weil <sage@inktank.com>
Subject: Re: Are there significant performance enhancements in 0.56.x to be
 expected soon or planned in the near future?
Date: Wed, 9 Jan 2013 08:58:22 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301090857000.6155@cobra.newdream.net>
References: <BED8C7CC7F6E5A4C9001AF4A075FC3B46D927F31C3@ABGEX70E.FSC.NET> <50ED7290.9010409@conversis.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38494 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932263Ab3AIQ6X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Jan 2013 11:58:23 -0500
In-Reply-To: <50ED7290.9010409@conversis.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dennis Jacobfeuerborn <dennisml@conversis.de>
Cc: "Lachfeld, Jutta" <jutta.lachfeld@ts.fujitsu.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 9 Jan 2013, Dennis Jacobfeuerborn wrote:
> On 01/09/2013 01:51 PM, Lachfeld, Jutta wrote:
> > Hi all,
> > 
> > in expectation of better performance, we are just switching from CEPH version 0.48 to 0.56.1
> > for comparisons between Hadoop with HDFS and Hadoop with CEPH FS.
> > 
> > We are now wondering whether there are currently any development activities 
> > concerning further significant performance enhancements, 
> > or whether further significant performance enhancements are already planned for the near future.
> > 
> > I would now be loath to start benchmarking with 0.56.1 and then, a month or so later, detect that there have been significant performance enhancements in CEPH in the meantime.
> 
> There shouldn't be any major changes since v0.56.x is a stable release and
> as such should only receive bug-/securityfixes and non-risky improvements.
> Any changes that would result in a significant change in performance would
> probably be too disruptive for a stable release series.

That is generally true.  One exception is that there may be some simple 
changes that can decrease the impact of data migration on performance.  
There are some changes we made for a customer that seem to make a big 
difference and will be making it into the main tree (and hopefully 
bobtail, and possibly even argonaut) shortly.

sage
