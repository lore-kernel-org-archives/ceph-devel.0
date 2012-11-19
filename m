From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: librbd discard bug problems -> i got it
Date: Mon, 19 Nov 2012 14:38:14 -0800
Message-ID: <50AAB4D6.3030304@inktank.com>
References: <50AAA25F.9040908@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:33789 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab2KSWiw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 17:38:52 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so942362dak.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 14:38:52 -0800 (PST)
In-Reply-To: <50AAA25F.9040908@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/19/2012 01:19 PM, Stefan Priebe wrote:
> Hello Josh,
>
> after digging three days around i got it.

That's great!

> The problem is in aio_discard in internal.cc. The i/o fails when AioZero
> or AioTruncate is used.

Interesting, I wouldn't have expected the bug to be there. Is
it failing with a different error code, or just taking too long
so the guest kernel tries to cancel it?

> It works fine with AioRemove. It seems to depend on overlapping.
> Hopefully i'm able to provide a patch this nicht.

Looking forward to it!

Josh
