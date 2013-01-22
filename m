From: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Subject: Re: RGW object purging in upstream caches
Date: Tue, 22 Jan 2013 12:15:50 -0500
Message-ID: <50FEC946.2010802@gmail.com>
References: <50FEC144.2050304@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:56207 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab3AVRP4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 12:15:56 -0500
Received: by mail-vc0-f180.google.com with SMTP id fo13so2088529vcb.11
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 09:15:55 -0800 (PST)
In-Reply-To: <50FEC144.2050304@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Wido den Hollander wrote:
> Now, when running just one Varnish instance which does loadbalancing
> over multiple RGW instances is not a real problem. When it sees a PUT
> operation it can "purge" (called banning in Varnish) the object from
> it's cache.
>
> When looking at the scenario where you have multiple caches you run into
> the cache-consistency problem. If an object is modified the caches are
> not notified and will continue to serve an outdated object.
>
> Looking at the Last-Modified header is not an option since the cache
> will not contact RGW when serving out of it's cache.
>
> To handle this there has to be some kind of "hook" inside RGW that can
> notify Varnish (or some other cache) when an object changes.

For nginx, it appears there is a well-tested production module that does 
this: http://labs.frickle.com/nginx_ngx_cache_purge/ (see the examples 
at the end of the README)

--Jeff

