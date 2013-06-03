From: Filippos Giannakos <philipgian@grnet.gr>
Subject: Re: [PATCH 0/2] librados: Add RADOS locks to the C/C++ API
Date: Mon, 03 Jun 2013 15:57:01 +0300
Message-ID: <51AC929D.6080401@grnet.gr>
References: <1369918922-867-1-git-send-email-philipgian@grnet.gr> <51A8FDB6.3020908@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:13593 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756049Ab3FCM6H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Jun 2013 08:58:07 -0400
In-Reply-To: <51A8FDB6.3020908@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org, synnefo-devel@googlegroups.com

Hi Josh,

On 05/31/2013 10:44 PM, Josh Durgin wrote:
> On 05/30/2013 06:02 AM, Filippos Giannakos wrote:
>> The following patches export the RADOS advisory locks functionality to
>> the C/C++
>> librados API. The extra API calls added are inspired by the relevant
>> functions
>> of librbd.
>
> This looks good to me overall. I wonder if we should create a new
> library in the future for these kinds of things that are built on top
> of librados. Other generally useful class client operations could go
> there, as well as generally useful things built on top of librados,
> like methods for striping over many objects.

Thanks for the review. I will incorporate all your suggestions in a new
patch, which I will submit shortly.
As for the new library you mention, it is a good idea, but for now I
think that the basic RADOS locking functionality should be at the core
librados API.

King Regards,
-- 
Filippos.
<philipgian@grnet.gr>
