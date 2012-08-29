From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Multiple concurrent async ops per IoCtx?
Date: Wed, 29 Aug 2012 07:41:28 -0700
Message-ID: <503E2A18.5000603@inktank.com>
References: <k1ksi5$q2p$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55156 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab2H2Olb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 10:41:31 -0400
Received: by pbbrr13 with SMTP id rr13so1337244pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 07:41:31 -0700 (PDT)
In-Reply-To: <k1ksi5$q2p$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Rutger ter Borg <rutger@terborg.net>
Cc: ceph-devel@vger.kernel.org

On 08/29/2012 03:57 AM, Rutger ter Borg wrote:
>
> Dear list,
>
> are Rados' IoCtx objects able to process multiple asynchronous
> operations at the same time, or is it necessary to wait for an operation
> to complete, before issuing a following operation?
>
> I.e., can I do the following and expect it to work?
>
> IoCtx ctx;
> ctx.aio_read( ... read 1 ... );
> ctx.aio_read( ... read 2 ... );
> ctx.aio_read( ... read 3 ... );
>
> ... time passes ...
>
> read 3 completes (e.g.)
> read 1 completes
> read 2 completes
>
> TIA,
> Cheers,
>
> Rutger

Yes, all the asynchronous functions can run in parallel. An IoCtx
has little bearing on performance - it mostly just saves you from
specifying the full set of parameters (i.e. pool, snapshot id, snapshot
context, etc.) for each operation.

Are you seeing behavior that looks like the aio operations aren't being 
run in parallel?

Josh
