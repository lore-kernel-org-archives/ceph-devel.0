From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 0/6] libceph: send osd requests in tid order
Date: Tue, 26 Mar 2013 09:49:39 -0500
Message-ID: <5151B583.1090109@inktank.com>
References: <5151071C.3000309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61485 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933512Ab3CZOtm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Mar 2013 10:49:42 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so5863191iec.19
        for <ceph-devel@vger.kernel.org>; Tue, 26 Mar 2013 07:49:41 -0700 (PDT)
In-Reply-To: <5151071C.3000309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 03/25/2013 09:25 PM, Alex Elder wrote:
> This series rearranges the way osd requests are placed onto an
> osd client's unsent request list so that they are kept in
> order based on their transaction ids.  The osd expects its
> requests from a client to have monotonically increasing tids.
> Since requests are sent to the osd in the order they are on
> the unsent list if we keep them sorted there this property
> is preserved.
> 
> 					-Alex
> 
> [PATCH 1/6] libceph: slightly defer registering osd request
> [PATCH 2/6] libceph: no more kick_requests() race

I got some early feedback which clarified something for me
and which led me to make a few changes, mostly to the third
patch in this series.

What the osd requires is that the tids for requests to a
given *object* from an osd client be increasing.  I had
previously understood it was all requests from an osd
client (regardless of target object) that needed increasing
tids.  It turns out both properties hold (at least once
this series of patches is applied) so this difference
affects the explanations more than the code.

I also realized that re-queueing unsent requests along
with sent ones in __kick_osd_requests() means that some
unsent requests could be moved ahead of others in the
unsent list--others which have a higher tid.  So now
we only move already-sent requests to the front and
leave any that have not yet been sent where they were.

I'm about to re-post updated versions of these patches
reflecting these changes.  Only patches 3 and 6 were
changed, and they're the only ones I"m going to post.
Patches 4 and 5 were simply rebased for the changes
in patch 3.

These updates patches (along with the others) are available
in branch "review/wip-4392-2" of the ceph-client git repository.

					-Alex

[PATCH 3/6, v2] libceph: requeue only sent requests when kicking
[PATCH 6/6, v2] libceph: verify requests queued in order

> [PATCH 3/6] libceph: prepend requests in order when kicking
> [PATCH 4/6] libceph: keep request lists in tid order
> [PATCH 5/6] libceph: send queued requests when starting new one
> [PATCH 6/6] libceph: verify requests queued in order
> 

