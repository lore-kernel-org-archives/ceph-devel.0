From: Christoph Hellwig <hch@infradead.org>
Subject: Re: xattr limits
Date: Fri, 4 Oct 2013 04:16:40 -0700
Message-ID: <20131004111640.GA22948@infradead.org>
References: <C1F9D079-3D19-4A39-872A-0CAF8EA3866F@gmail.com>
 <524E59FC.9030903@dachary.org>
 <31BF914D-D406-428E-8671-0005901E10E6@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:52439 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741Ab3JDLQm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Oct 2013 07:16:42 -0400
Content-Disposition: inline
In-Reply-To: <31BF914D-D406-428E-8671-0005901E10E6@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>, xfs@oss.sgi.com

Might be good to send the crash report to the XFS list..

On Thu, Oct 03, 2013 at 11:54:29PM -0700, David Zafman wrote:
> 
> Here is the test script:
> 


> 
> David Zafman
> Senior Developer
> http://www.inktank.com
> 
> 
> 
> 
> On Oct 3, 2013, at 11:02 PM, Loic Dachary <loic@dachary.org> wrote:
> 
> > Hi David,
> > 
> > Would you mind attaching the script to the mail for completness ? It's a useful thing to have :-)
> > 
> > Cheers
> > 
> > On 04/10/2013 01:21, David Zafman wrote:
> >> 
> >> I want to record with the ceph-devel archive results from testing limits of xattrs for Linux filesystems used with Ceph.
> >> 
> >> Script that creates xattrs with name user.test1, user.test2, ?. on a single file
> >> 3.10 linux kernel
> >> 
> >> ext4  
> >> value bytes       number of entries
> >>    1               148
> >>   16             103
> >>  256          14
> >>  512            7
> >>  1024         3
> >> 4036          1 
> >> Beyond this immediately get ENOSPC
> >> 
> >> btrfs    
> >> value bytes       number of entries
> >> 8       		 10k
> >> 16       		10k
> >> 32        		 10k
> >> 64        		 10k
> >> 128     		 10k
> >> 256       		 10k
> >> 512        		10k  slow but worked 1,000,000 got completely hung for minutes at a time during removal strace showed no forward progress
> >> 1024        	 10k
> >> 2048        	 10k
> >> 3096          	 10k
> >> Beyond this you start getting ENOSPC after fewer entries
> >> 
> >> xfs (limit entries due to xfs crash with 10k entries)
> >> value bytes       number of entries
> >> 1   			1k
> >> 8   			 1k
> >> 16   			 1k
> >> 32  			 1k
> >> 64   		        1k
> >> 128   		 1k
> >> 256 			1k
> >> 512  		 1k
> >> 1024 		1k
> >> 2048  		 1k
> >> 4096   		 1k
> >> 8192   		 1k
> >> 16384   		 1k
> >> 32768   		 1k
> >> 65536   		 1k
> >> 
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> 
> > 
> > -- 
> > Lo?c Dachary, Artisan Logiciel Libre
> > All that is necessary for the triumph of evil is that good people do nothing.
> > 
> 

---end quoted text---
