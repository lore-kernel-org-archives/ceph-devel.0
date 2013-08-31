From: Sage Weil <sage@inktank.com>
Subject: Re: Random build errors - uninitialized integers
Date: Sat, 31 Aug 2013 14:05:31 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308311026130.13911@cobra.newdream.net>
References: <CAN04cT5F6AxJR+hNuujR4AghUQ2cFYBGbCgAA=6J0FGtYMpMkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39335 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288Ab3HaVFb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 31 Aug 2013 17:05:31 -0400
In-Reply-To: <CAN04cT5F6AxJR+hNuujR4AghUQ2cFYBGbCgAA=6J0FGtYMpMkw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: ceph-devel@vger.kernel.org

[adding ceph-devel to cc]

Hi Roald!

On Sat, 31 Aug 2013, Roald van Loon wrote:
> Hi Sage,
> 
> As you know I'm working on doing a cleanup of the automake files. I
> found a rather weird issue related to integer types causing completely
> random build errors - on some system configs more often than on
> others. I'm mailing them because you might want to cherry-pick the
> fixes.
> 
> >From what I could trace, I found at least two distinct issues;
> 
> 1) The header src/include/inttypes.h sometimes clutters the system's
> <inttypes.h>, especially when it is included in files in src/include
> as 'include "inttypes.h"' - files which are included in different
> order from other different headers/source files, causing unexpected
> and unreproducible behaviour. Next to that, we sometimes assume an
> include <inttypes.h> always includes <stdint.h>, which is not true on
> some systems (even though C99 says so).
> 
> 2) Sometimes, out of the blue, random tests fail (especially dencoder
> test). I traced this to some uninitialized integers.
> 
> I prevented the first from happening by renaming inttypes.h ->
> int_types.h (which is more consistent with the types-files naming in
> Ceph anyway), and adding extra guards in it to make sure the right
> types exists (especially the PRI*64 macros are not defined on all
> systems). See: https://github.com/ceph/ceph/blob/c872eca5c20386748804f7cbc6e7bddf1fff2c69/src/include/int_types.h

Looks good.  The #include ordering has always been fragile with the endian 
conversion types; anything we can do to make it less prone to error is 
great.
 
> Regarding the second, I found two cases causing random ceph-dencoder
> test failures;
> 
> Here; https://github.com/ceph/ceph/commit/730539a06a0632c08cb4419ad8318984c6d9ef37
> And here; https://github.com/ceph/ceph/commit/dc8aa53a94fab0effdc3830620dbd6295d3824e2#diff-2
> 
> As I said, you might want to cherry-pick them, or you might want to
> leave this in this branch and merge it later. Let me know what you
> think.

Good catch.  I've cherry-picked the first, and just the MonitorDBStore::Op 
part to next.  I think the header changes should stay in your branch until 
it is ready to go.  It appears to be getting closer, though!

Thanks!
sage
