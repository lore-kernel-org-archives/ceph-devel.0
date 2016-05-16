From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: wip-bluestore-write
Date: Mon, 16 May 2016 17:12:29 +0300
Message-ID: <46602b09-9587-8ef2-3428-ed96187f74e4@mirantis.com>
References: <alpine.DEB.2.11.1605160913150.30956@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:36000 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbcEPOMb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 May 2016 10:12:31 -0400
Received: by mail-lb0-f180.google.com with SMTP id h1so50470142lbj.3
        for <ceph-devel@vger.kernel.org>; Mon, 16 May 2016 07:12:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605160913150.30956@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org



On 16.05.2016 16:20, Sage Weil wrote:
> I merged your last two PRs and pushed an updated branch.  The test fails
> now due to an operation like transaction(write 0~5, write 10~5) where the
> second write wants to read the block in order to write a full block/chunk,
> but the first write's data obviously isn't off to disk yet.  The missing
> piece is a buffer cache, which we want anyway so that we can
>
> - handle cases like this
> - drop the hacky tail_cache code
> - cache data in ram (when we have an fadvise hint, or for some other
> reason decide it's a good idea)
>
> I have a really basic initial version pushed that just handles the write
> path (buffers initalling in writing state, then clean once io hits
> device).  We just need to make _do_read use it (Igor?) and add some basic
OK, will extend _do_read method to perform a read from the buffer cache 
if possible...


> trimming.  (And eventually decide how we want to do trimming in general..
> presumably we want a global LRU instead of the simple per-object thing
> that's there now.)
>
> Once that is working, I think the write path will be pretty complete, and
> we can turn our attention to the compression/checksum decisions (when to
> compress, how big should the chunks be, etc.) and performance.  See this
> PR:
>
> 	https://github.com/ceph/ceph/pull/6208
>
> I also coded up a new _clone that'll do COW, but I haven't tested it yet.
>
> sage
>

