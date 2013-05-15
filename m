From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH v2 3/3] ceph: ceph_pagelist_append might sleep while
 atomic
Date: Wed, 15 May 2013 10:53:42 -0600
Message-ID: <5193BD96.1000005@sandia.gov>
References: <1368635894-114707-1-git-send-email-jaschut@sandia.gov>
 <1368635894-114707-4-git-send-email-jaschut@sandia.gov>
 <5193BC89.6030807@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:48534 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758319Ab3EOQyM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 May 2013 12:54:12 -0400
In-Reply-To: <5193BC89.6030807@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/15/2013 10:49 AM, Alex Elder wrote:
> On 05/15/2013 11:38 AM, Jim Schutt wrote:
>> > Ceph's encode_caps_cb() worked hard to not call __page_cache_alloc() while
>> > holding a lock, but it's spoiled because ceph_pagelist_addpage() always
>> > calls kmap(), which might sleep.  Here's the result:
> This looks good to me, but I admit I didn't take as close
> a look at it this time.
> 
> I appreciate your updating the series to include the things
> I mentioned.
> 
> I'll commit these for you, and I'll get confirmation on the
> byte order thing as well.

Cool.  Thanks, Alex.

-- Jim

> 
> Reviewed-by: Alex Elder <elder@inktank.com>
> 
> 


