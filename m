From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Make libcephfs return error when unmounted?
Date: Wed, 11 Apr 2012 11:25:03 -0700
Message-ID: <D283FDD9-61D3-4F93-9650-5A27F61C9E60@cs.ucsc.edu>
References: <71CC6D8F-361D-4C00-AED1-C0C928CDAB9F@cs.ucsc.edu> <4D23FD899165483BAF0CEEDC9FF75D61@dreamhost.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:40355 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647Ab2DKSZE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Apr 2012 14:25:04 -0400
In-Reply-To: <4D23FD899165483BAF0CEEDC9FF75D61@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>


On Apr 11, 2012, at 11:22 AM, Greg Farnum wrote:

> On Wednesday, April 11, 2012 at 11:12 AM, Noah Watkins wrote:
>> Hi all,
>> 
>> -Noah 
> I'm not sure where the "-1004" came from,

ceph_mount(..) seems to return some random error codes (-1000, 1001) already  :)

> Patches welcome, of course, but if it's still a problem this summer we can probably put an intern on it for a day to help them understand why standard programming practices are good things. ;)

I'll happily create a patch for this :) Any method to come up with Ceph-specific error codes?

-Noah