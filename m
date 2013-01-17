From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH REPOST 0/6] rbd: consolidate osd request setup
Date: Wed, 16 Jan 2013 20:25:33 -0800
Message-ID: <50F77D3D.4080705@inktank.com>
References: <50E6EF5F.9080200@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:64154 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758373Ab3AQEZk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 23:25:40 -0500
Received: by mail-pb0-f51.google.com with SMTP id ro12so1136422pbb.38
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 20:25:37 -0800 (PST)
In-Reply-To: <50E6EF5F.9080200@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/04/2013 07:03 AM, Alex Elder wrote:
> This series consolidates and encapsulates the setup of all
> osd requests into a single function which takes variable
> arguments appropriate for the type of request.  The result
> groups together common code idioms and I think makes the
> spots that build these messages a little easier to read.
>
> 					-Alex
>
> [PATCH REPOST 1/6] rbd: don't assign extent info in rbd_do_request()
> [PATCH REPOST 2/6] rbd: don't assign extent info in rbd_req_sync_op()
> [PATCH REPOST 3/6] rbd: initialize off and len in rbd_create_rw_op()
> [PATCH REPOST 4/6] rbd: define generalized osd request op routines
> [PATCH REPOST 5/6] rbd: move call osd op setup into rbd_osd_req_op_create()
> [PATCH REPOST 6/6] rbd: move remaining osd op setup into
> rbd_osd_req_op_create()

I'm not sure about the varargs approach. It makes it easy to
accidentally use the wrong parameters. What do you think about
replacing calls to rbd_osd_req_create_op() with helpers for the various
kinds of requests that just call rbd_osd_req_create_op() themselves, so
that the arguments can be checked at compile time? This will probably
be more of an issue with multi-op osd requests in the future.

Eventually I think all this osd-request-related stuff should go into
libceph, but that's a cleanup for another day.

In any case, the new structure looks good to me.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
