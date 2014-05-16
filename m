From: Hannes Landeholm <hannes@jumpstarter.io>
Subject: Re: crash report: paging request errors in various krbd contexts
Date: Fri, 16 May 2014 17:13:03 +0200
Message-ID: <CABt9es8kR8GAHuUe4VOnNyU2F3Wrs9nYDF_AQN_7cKmLr8tvrA@mail.gmail.com>
References: <CABt9es_p40V7zcaqNLBstrY4g=8iMsUVtAoEdDGxXTsW9NKGdg@mail.gmail.com>
	<537617B9.4040706@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:46155 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756588AbaEPPNF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 May 2014 11:13:05 -0400
Received: by mail-la0-f50.google.com with SMTP id b8so2043035lan.23
        for <ceph-devel@vger.kernel.org>; Fri, 16 May 2014 08:13:03 -0700 (PDT)
In-Reply-To: <537617B9.4040706@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

> The bottom line is that it appears that some
> memory used by rbd and/or libceph has become
> corrupted, or there is something (or more than
> one thing) that is being used after it's been
> freed.  Either way this sort of thing will be
> difficult to try to understand; it would be
> great if it could be reproduced independently.
>
> We're calling strnlen() (ultimately) from snprintf().  The
> format provided will be "%s.%012llx" (or similar).  The
> string provided for the %s is rbd_dev->header.object_prefix,
> which is a dynamically allocated string initialized once
> for the rbd device, which will be NUL-terminated and
> unchanging until the device gets mapped.
>
> Either the rbd device got unmapped while still
> in use, or the memory holding this rbd_dev structure
> got corrupted somehow.

Yes, with my limited knowledge of the kernel I would have guessed that
it was some form of memory allocation problem as well as it crashed in
wildly different contexts and it crashed right after a memory
allocation in the snprintf() case.

Is it possible to configure the kernel when building it so it sanity
checks memory allocations that are free'd and/or reserved? I have
implemented my own free list based VM in userspace and I find it very
useful to insert a header with a magic canary value that I set before
giving out memory and check when I get memory back. This allows me to
crash with the offending code in the backtrace instead of crashing in
a wildly different context.

> I don't know if you've supplied this before, but can
> you describe the way the rbd device(s) in question
> is configured?  How many devices, how big are they,
> and *especially*, are they using layering and if so
> what the relationships are between them.

It's something like ~100-200 mappings that are 10 gb each. They use
layering and generally share the same parent with varying distance to
the common ancestor snapshot, but it's unlikely to be more than ~20
layers at the moment. More than 75% probably share the same common
ancestor. We don't have rbd caching enabled.

Thank you for you time,
Hannes
