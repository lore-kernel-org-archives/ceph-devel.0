From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Fri, 1 Apr 2016 14:56:11 +1100
Message-ID: <20160401035610.GA5671@onthe.net.au>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com>
 <CY1PR0201MB189760F1BB3EB67EF216B71DE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:39938 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001AbcDAD4O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Mar 2016 23:56:14 -0400
Content-Disposition: inline
In-Reply-To: <CY1PR0201MB189760F1BB3EB67EF216B71DE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Mar 30, 2016 at 10:52:37PM +0000, Allen Samuels wrote:
> One thing to also factor in is that if you increase the span of a
> checksum, you degrade the quality of the checksum. So if you go with 128K
> chunks of data you'll likely want to increase the checksum itself from
> something beyond a CRC-32. Maybe somebody out there has a good way of
> describing this quanitatively.

I would have thought the "quality" of a checksum would be a function of how
many bits it is, and how evenly and randomly it's distributed, and unrelated
to the amount of data being checksummed.

I.e. if you have any amount of data covered by an N-bit evenly randomly
distributed checksum, and "something" goes wrong with the data (or the
checksum), the chance of the checksum still matching the data is 1 in 2^n.

Cheers,

Chris
