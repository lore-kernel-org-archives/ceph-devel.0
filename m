From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: localized pgs
Date: Wed, 18 Apr 2012 08:08:29 -0700
Message-ID: <FDD48DF9-F4A1-414A-865A-8C571E63A7AA@cs.ucsc.edu>
References: <Pine.LNX.4.64.1204170935350.15197@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:43949 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab2DRPIb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 11:08:31 -0400
In-Reply-To: <Pine.LNX.4.64.1204170935350.15197@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


On Apr 17, 2012, at 9:36 AM, Sage Weil wrote:

> I guess the question is, is there a compelling use case, and if there is, 
> is there a better approach?

I am failing to find a reference to the paper, but I recall that the 1 localized write to HDFS for MR applications isn't enormously beneficial. Then again it does save a lot of network traffic, especially for triplication.

As more people start looking at the Object Class handler mechanism, I could see it being desirable to stick data into objects (grab later via rendezvous) rather than return data to the rados_exec caller. Making that efficient would be important.

Could you piggyback on the recovery logic to accomplish this? Say, write 2 objects as normal, and 1 local "miss placed" object, letting RADOS asynchronously move that object to its intended location.

- Noah