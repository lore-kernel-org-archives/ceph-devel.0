From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH, v2] ceph: use a shared zero page rather than one per
 messenger
Date: Fri, 02 Mar 2012 19:43:32 -0800
Message-ID: <4F519364.5080604@dreamhost.com>
References: <4F4D962E.7020304@dreamhost.com> <4F4E630A.6040407@dreamhost.com> <Pine.LNX.4.64.1203021120010.6413@cobra.newdream.net> <4F515472.60101@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:33787 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab2CCDnd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 22:43:33 -0500
In-Reply-To: <4F515472.60101@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On 03/02/2012 03:14 PM, Alex Elder wrote:
> On 03/02/2012 11:21 AM, Sage Weil wrote:
>> On Wed, 29 Feb 2012, Alex Elder wrote:
>>
>>> Each messenger allocates a page to be used when writing zeroes
>>> out in the event of error or other abnormal condition. Instead,
>>> use the kernel ZERO_PAGE() for that purpose.
>>>
>>> Signed-off-by: Alex Elder<elder@dreamhost.com>
>>> ---
>>> v2: Updated to use kernel ZERO_PAGE()
>>>
>>> include/linux/ceph/messenger.h | 1

. . .

>>> + BUG_ON(zero_page_address != NULL);
>>> + zero_page_address = kmap(zero_page);
>>
>> I've always assumed that kmap() used up an expensive slot, and that pages
>> should be kmapped only when needed. Myabe this should still be done
>> inside write_partial_msg_pages()?
>
> I think that's only for high memory pages, and especially for
> the kernel zero page I doubt that's where it sits. But you
> make a good point.
>
> I'll look into it a bit and if we're not guaranteed it's
> "free" to do this I'll re-post with the kmap done inside where
> it's needed. I'll follow up either way.

OK, here's how I'm going to resolve this.  First, the result of this
patch makes things no worse than they were before with respect to
hanging onto a zero page mapping.  Previously, every messenger
allocated its own zero page, and mapped it and held onto that
mapping for the duration of that messenger's lifetime.

With this patch in place, we don't allocate any new page (we
use ZERO_PAGE()) and grab one mapping to it used for all
messengers until the subsystem is shut down.

So basically, since things are left no worse than before, I'm
going to keep this as-is.

I will do a follow-on patch soon (after I get through committing
all those I've put out this week) that will affect the way the
zero page is handled.

						-Alex
