From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/4] libceph: kill the "trail" portion of message data
Date: Mon, 11 Mar 2013 15:44:07 -0700
Message-ID: <513E5E37.9010503@inktank.com>
References: <513CEE83.4040900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:59504 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506Ab3CKWot (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Mar 2013 18:44:49 -0400
Received: by mail-pb0-f52.google.com with SMTP id ma3so4262409pbc.11
        for <ceph-devel@vger.kernel.org>; Mon, 11 Mar 2013 15:44:48 -0700 (PDT)
In-Reply-To: <513CEE83.4040900@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 03/10/2013 01:35 PM, Alex Elder wrote:
> The trail portion of message data was added to support
> two distinct sets of data for an osd request--one a
> pagelist for providing parameters to object method
> calls; and a second a page array for receiving data
> back from the result of such a call.
>
> It's always been a bit of a weird thing bolted onto
> a message though, and with the rework of the messenger
> code it can now be removed.
>
> This series eliminates the trail by allowing the osd
> client to record a (non-trail) pagelist for data, and
> using the fact that we now distinguish incoming from
> outgoing data to allow that to be specified distinct
> from the page array used for the incoming response.
>
> Having done this, we can eliminate the trail from the
> ceph message structure, and then that allows some
> code to be simplified.
>
> These patches are available in the "review/wip-kill-trail"
> branch of the ceph-client git repository.  That branch
> is based on branch "review/wip-cursor".
>
> 					-Alex
>
> [PATCH 1/4] libceph: have osd requests support pagelist data
> [PATCH 2/4] libceph: kill osd request r_trail
> [PATCH 3/4] libceph: kill message trail
> [PATCH 4/4] libceph: more cleanup of write_partial_msg_pages()

These look good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
