From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: cmon: PGMonitor::encode_pending() assert failure
Date: Mon, 7 Feb 2011 14:34:39 +1100
Message-ID: <20110207033438.GA25062@onthe.net.au>
References: <slrnikk2hd.jh1.chris@chris.onthe.net.au>
 <AANLkTi=SyqVD8MyCt+ybYrhoSHunYrchcdZUvW-nzOgw@mail.gmail.com>
 <Pine.LNX.4.64.1102031301550.19855@cobra.newdream.net>
 <20110203220245.GA6179@onthe.net.au>
 <Pine.LNX.4.64.1102031424000.19855@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:53467 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483Ab1BGDek (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Feb 2011 22:34:40 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1102031424000.19855@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Thu, Feb 03, 2011 at 02:24:43PM -0800, Sage Weil wrote:
> On Fri, 4 Feb 2011, Chris Dunlop wrote:
>> On Thu, Feb 03, 2011 at 01:03:17PM -0800, Sage Weil wrote:
>>> 
>>> http://tracker.newdream.net/issues/762
>> 
>> I can revert back to my previous install and run the same
>> workload to see if it crops up again if that's useful (it
>> took about 12 hours of rsync'ing files into the fs to get
>> there), or I can try the workload using latest ceph with
>> Josef Bacik's btrfs-work** to see if either problem crops up
>> again. Any preference?
> 
> Let's go with latest master and latest bits from Josef.  It's
> the future!

The PGMonitor::encode_pending() assert failure didn't show up in
copying 500 GB into a fresh ceph fs using:

ceph-client 9aae8faf
+ Josef's btrfs-work bacae123

So either it's fixed or it's now craftily hidden, waiting to
pounce again.
