From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Ideal hardware spec?
Date: Thu, 23 Aug 2012 11:59:52 +0200
Message-ID: <5035FF18.3030209@widodh.nl>
References: <20120822135530.GB10015@csail.mit.edu> <5034E9F3.10001@widodh.nl> <20120822154615.GF10015@csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:50181 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758191Ab2HWJ7z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Aug 2012 05:59:55 -0400
In-Reply-To: <20120822154615.GF10015@csail.mit.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jonathan Proulx <jon@csail.mit.edu>
Cc: ceph-devel@vger.kernel.org

On 08/22/2012 05:46 PM, Jonathan Proulx wrote:
> On Wed, Aug 22, 2012 at 04:17:23PM +0200, Wido den Hollander wrote:
>
> :On 08/22/2012 03:55 PM, Jonathan Proulx wrote:
>
> :You can also use the USB sticks[0] from Stec, they have servergrade
> :onboard USB sticks for these kind of applications.
>
> Those look quite interesting.
>

They should be much more reliable than regular USB sticks due to their 
SLC memory.

You could also take a look at these: 
http://www.transcend-info.com/industry/products_details.asp?CatNo=2&SerNo=14&ModNo=28&Func1No=1

> :A couple of questions still need to be answered though:
> :* Which OS are you planning on using? Ubuntu 12.04 is recommended
>
> Ubuntu 12.04 is our current preferred OS
>

That should work fine.

> :* Which filesystem do you want to use underneath the OSDs?
>
> Whatever I can get to work best in testing :)
>
> Since this is for a research platform not a product I'd likely start with
> BTRFS and see if it is "stable enough" and "performant enough" with
> fall back to XFS if needed
>

BTRFS is indeed the best in terms of features. I'd recommend using a 
recent kernel like 3.5.

Wido

> -Jon
>
> :Wido
> :
> :[0]: http://www.stec-inc.com/product/ufm.php
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

