From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH REPOST 0/4] rbd: explicitly support only one osd op
Date: Wed, 16 Jan 2013 18:27:49 -0800
Message-ID: <50F761A5.6010702@inktank.com>
References: <50E6EA94.1040001@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35302 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757843Ab3AQC1w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 21:27:52 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so1149546pad.8
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 18:27:51 -0800 (PST)
In-Reply-To: <50E6EA94.1040001@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/04/2013 06:43 AM, Alex Elder wrote:
> An osd request can be made up of multiple "ops", all of which are
> completed (or not) transactionally.  There is partial support for
> multiple ops in an rbd request in the rbd code, but it's incomplete
> and not even supported by the osd client or the messenger right now.
>
> I see three problems with this partial implementation:  it gives a
> false impression of how things work; it complicates some code in
> some cases where it's not necessary; and it may constrain how one
> might pursue fully implementing multiple ops in a request to ways
> that don't fit well with how we want to do things.
>
> So this series just simplifies things, making it explicit that there
> is only one op in an kernel osd client request right now.
>
> 					-Alex
>
> [PATCH REPOST 1/4] rbd: pass num_op with ops array
> [PATCH REPOST 2/4] libceph: pass num_op with ops
> [PATCH REPOST 3/4] rbd: there is really only one op
> [PATCH REPOST 4/4] rbd: assume single op in a request

These look good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

