From: Mike Dawson <mike.dawson@cloudapt.com>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Thu, 15 Jan 2015 10:45:50 -0500
Message-ID: <54B7E0AE.2050102@cloudapt.com>
References: <54B7D2D6.4020503@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:52437 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbbAOPq7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jan 2015 10:46:59 -0500
Received: by mail-ig0-f181.google.com with SMTP id r2so13270797igi.2
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 07:46:58 -0800 (PST)
In-Reply-To: <54B7D2D6.4020503@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

+1

Thanks,
Mike Dawson


On 1/15/2015 9:46 AM, Wido den Hollander wrote:
> Hi,
>
> Although the userland tools like 'ceph' and 'rados' have a safeguard
> against fat fingers when it comes to removing a pool there is no such
> safeguard when using native librados.
>
> The danger still exists that by accident you remove a pool which is then
> completely gone, no way to restore it.
>
> This is still something I find quite dangerous, so I was thinking about
> a additional 'Immutable bit' which could be set on a pool before
> rados_pool_delete() allows this pool to be removed.
>
> Is it a sane thing to look at 'features' which pools could have? Other
> features which might be set on a pool:
>
> - Read Only (all write operations return -EPERM)
> - Delete Protected
>
> It's just that looking at a 20TB RBD pool and thinking that just one API
> call could remove this pool make me a bit scared.
>
> Am I the only one or is this something worth looking in to?
>
