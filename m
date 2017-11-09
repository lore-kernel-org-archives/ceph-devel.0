From: Sage Weil <sage@newdream.net>
Subject: Re: question about ec partial read in a single stripe
Date: Thu, 9 Nov 2017 14:30:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1711091426570.21250@piezo.novalocal>
References: <CALi+v180b0934jMAHb100O6jQ2oqMZM9a=SMWBvzhrQ0H0qm4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:39180 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdKIOaX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Nov 2017 09:30:23 -0500
In-Reply-To: <CALi+v180b0934jMAHb100O6jQ2oqMZM9a=SMWBvzhrQ0H0qm4A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zengran zhang <z13121369189@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 9 Nov 2017, zengran zhang wrote:
> Hi all:
>     we found that partial read will cause full stripe read  in now ec
> impl, for example:
>     we have 4 chunks per stripe, 4K size per chunks and 16K per
> stripe, when we read rand 2K in a stripe,the reads
> will amplify to full stripe(16K +8K(Parity))..

Right.

>     i did not see any checksum or buffer  related factor except the ec
> extentcache.does the extentcache is the purpuse of the mechanism?
> now we want increase the stripe width to improve the small random raed
> performance, but the mechanism limit the result...

This is definitely an improvement we're interested in.  I don't remember 
what the issue with the previous PR was, but it appears to predate the EC 
overwrites work (which merged about a year ago), so it will certainly need 
to be reimplemented.  The extentcache is there to support the 
read/modify/write behavior for sub-stripe overwrites. Whatever we do for 
small substripe reads will need to cooperate with that cache.

If you're interested in tackling this, that would be fantastic!

sage
