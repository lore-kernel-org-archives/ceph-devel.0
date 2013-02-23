From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Mon losing touch with OSDs
Date: Sat, 23 Feb 2013 12:10:29 +1100
Message-ID: <20130223011029.GA9243@onthe.net.au>
References: <20130219030202.GA5010@onthe.net.au>
 <20130220020703.GA8567@onthe.net.au>
 <20130222030614.GA13873@onthe.net.au>
 <alpine.DEB.2.00.1302221344550.5703@cobra.newdream.net>
 <20130222233555.GA9173@onthe.net.au>
 <alpine.DEB.2.00.1302221543090.5703@cobra.newdream.net>
 <20130223000843.GA10200@onthe.net.au>
 <alpine.DEB.2.00.1302221612230.5703@cobra.newdream.net>
 <alpine.DEB.2.00.1302221625040.5703@cobra.newdream.net>
 <20130223005026.GA8844@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:56796 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755685Ab3BWBKb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 20:10:31 -0500
Content-Disposition: inline
In-Reply-To: <20130223005026.GA8844@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Sat, Feb 23, 2013 at 11:50:26AM +1100, Chris Dunlop wrote:
> On Fri, Feb 22, 2013 at 04:25:39PM -0800, Sage Weil wrote:
>> Hi Chris-
>> 
>> Can you confirm that both ceph-osd daemons are running v0.56.3 (i.e., 
>> they were restarted after the upgrade)?
> 
> Not absolutely, but the indications are good: the osd.1 process
> was started Feb 16 08:38:43 2013, 20 minutes before I sent my
> email saying it had been upgraded. The osd.0 process was
> restarted more recently to kick things along after the most
> recent problem, however my command line history shows a "apt-get
> upgrade" followed by a "service ceph restart".


I can't see anything in the logs indicating the various daemon version
numbers.

Unless I'm blind and it's already there, perhaps a good idea for every
daemon to log it's version number when it starts?

Chris
