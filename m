From: Sage Weil <sage@inktank.com>
Subject: Re: Transforming a bufferlist iterator into new bufferlist
Date: Mon, 27 Aug 2012 13:01:23 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208271300200.29719@cobra.newdream.net>
References: <CAPrxi590uJZWYpcWb-uhNucH57_AcSEepbGi-0M9o5zQPf=ZvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49408 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100Ab2H0UBY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 16:01:24 -0400
In-Reply-To: <CAPrxi590uJZWYpcWb-uhNucH57_AcSEepbGi-0M9o5zQPf=ZvQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 27 Aug 2012, Noah Watkins wrote:
> I have a bufferlist use case that I can't quite resolve. I'm packing
> up a struct and a blob, but not sure how to seek to the beginning of
> the blob correctly during decode:
> 
> 1. Setup bufferlist
> 
>   /* add header */
>   struct header hdr;
>   ::encode(hdr, bl);
> 
>   /* add payload blob */
>   bl.append(buf, len);

Instead, do 

bufferlist b;
b.append(buf, len);
::encode(b, bl);

that'll include a length in front of it...

 
> 2. Later in decode ...
> 
>   /* get header */
>   bufferlist::iterator it = in.begin();
>   ::decode(hdr, it);
> 
>   **problem: Want to get a bufferlist for the payload, which is
> presumably exactly where the iterator now points. How should that
> transformation happen with zero-copy?

and then

bufferlist b;
::decode(b, it);

will get it back.

sage
