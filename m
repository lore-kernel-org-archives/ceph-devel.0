From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: 'Immutable bit' on pools to prevent deletion
Date: Thu, 15 Jan 2015 07:58:31 -0800
Message-ID: <CABBk=J9BVNzKHfSxdxmRjrZoasAWUz8_e9Juzc4vYnNXo0wHFA@mail.gmail.com>
References: <54B7D2D6.4020503@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:46736 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbbAOP6b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jan 2015 10:58:31 -0500
Received: by mail-ig0-f181.google.com with SMTP id r2so13337126igi.2
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 07:58:31 -0800 (PST)
In-Reply-To: <54B7D2D6.4020503@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jan 15, 2015 at 6:46 AM, Wido den Hollander <wido@42on.com> wrote:
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

I completely agree. A while back I opened an issue for that, #9792,
with some suggestions:

- require a special key for this command
- pool removal doesn't apply immediately, but rather first switches
pool to 'pending removal'
- pending removal state reflected in the cluster status
- operation can be cancelled when pending

Yehuda
