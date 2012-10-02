From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] ceph: avoid 32-bit page index overflow
Date: Tue, 02 Oct 2012 14:21:03 -0500
Message-ID: <506B3E9F.3060006@inktank.com>
References: <506B0818.1040407@inktank.com> <20121002163225.GA26594@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49516 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab2JBTVH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Oct 2012 15:21:07 -0400
Received: by ieak13 with SMTP id k13so15508845iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 02 Oct 2012 12:21:06 -0700 (PDT)
In-Reply-To: <20121002163225.GA26594@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: ceph-devel@vger.kernel.org

On 10/02/2012 11:32 AM, Christoph Hellwig wrote:
> On Tue, Oct 02, 2012 at 10:28:24AM -0500, Alex Elder wrote:
>> A pgoff_t is defined (by default) to have type (unsigned long).  On
>> architectures such as i686 that's a 32-bit type.  The ceph address
>> space code was attempting to produce 64 bit offsets by shifting a
>> page's index by PAGE_CACHE_SHIFT, but the result was not what was
>> desired because the shift occurred before the result got promoted
>> to 64 bits.
>>
>> Fix this by casting all uses of page->index used in this way to
>> the desired 64-bit type.
> 
> It would be cleaner if you'd use the page_offset helper, which was
> added to fix this problem without having to remember the right casts
> everywhere.

Will do.  Thanks Christoph.

					-Alex
