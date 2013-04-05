From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 0/9]
Date: Fri, 05 Apr 2013 07:09:00 -0500
Message-ID: <515EBEDC.9040507@inktank.com>
References: <515DA755.2090504@inktank.com> <515E3EEC.5040604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:46048 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161144Ab3DEMJC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 08:09:02 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so4279022ieb.29
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 05:09:02 -0700 (PDT)
In-Reply-To: <515E3EEC.5040604@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/04/2013 10:03 PM, Josh Durgin wrote:
> On 04/04/2013 09:16 AM, Alex Elder wrote:
>> (The following patches are available in branch "review/wip-3761"
>> on the ceph-client git respository.)
>>
>> These are actually a few sets of patches but I'm just going to
>> post them as a single series this time.
>>
>>                     -Alex
>>
>> [PATCH 1/9] ceph: use page_offset() in ceph_writepages_start()
>>      Fixes a potential bug in ceph_writepages_start().

. . .

>> [PATCH 9/9] ceph: build osd request message later for writepages
>>      Defers "building" a request message until right before
>>      it's submitted to the osd client to start its execution.
>>      Also stops having the length field in a message header
>>      get updated by the file system code.
> 
> These all look good. The one thing I'm uncertain about is changing
> the mempool allocation failure from a WARN to a BUG, but it seems
> there's no good way to recover at that point.

It's reality.  About 20 lines later, pages is dereferenced.
I think it's better to stop at the point of the failure
and report exactly where it occurred than to (most likely)
crash more mysteriously a little later on.

If we exhaust the mempool, it wasn't big enough, and
that's a bug in the size of the mempool or the design.

Thanks a lot for the review.  More on their way shortly.

					-Alex

> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
> 

