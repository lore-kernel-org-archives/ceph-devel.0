From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: feedback on supporting libc++
Date: Wed, 30 Oct 2013 12:02:24 -0700
Message-ID: <527157C0.40802@inktank.com>
References: <CA+Hcz5-8k3rnCaJJj3htb0F63V+fitoBtofCkGzJZ4a_j29K8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:42678 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab3J3TCO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Oct 2013 15:02:14 -0400
Received: by mail-ob0-f177.google.com with SMTP id vb8so1882759obc.8
        for <ceph-devel@vger.kernel.org>; Wed, 30 Oct 2013 12:02:13 -0700 (PDT)
In-Reply-To: <CA+Hcz5-8k3rnCaJJj3htb0F63V+fitoBtofCkGzJZ4a_j29K8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>, Gregory Farnum <gregory.farnum@inktank.com>

On 10/29/2013 03:51 PM, Noah Watkins wrote:
> Out of the box on OSX Mavericks libc++ [1] is being used as opposed to
> libstdc++. One of the issues is that stuff from tr1 isn't available
> (e.g. std::tr1::shared_ptr), as they have moved to std in c++11.
>
> I'm looking for any feedback on this patch set, or if there is a
> better way forward.
>
> A set of patches on ceph.git:wip-libc++ [2] adds initial support (with
> a couple temporary hacks). These patches are very similar to the
> method used to support libc++ in mongodb.
>
> Summary of changes:
>
>    std::tr1::shared/weak_ptr maps to ceph::shared/weak_ptr

I'm fine with this approach in general, but we need to be careful about
changing librados.h[pp], since that may break the ABI.

We really should've hidden the entire implementation of ObjectIterator
to begin with, but now we're stuck with it in librados.hpp. This branch
changes a std::tr1::shared_ptr there to a ceph::shard_ptr, which looks
unsafe to me. Could you check whether you can run 'rados ls' compiled
against an old librados, but dynamically loading librados from this
branch compiled in c++98 mode?

Josh

>    hash_map/set maps to ceph::unordered_map/set
>
> which will choose tr1::unordered_map/set over ext/hash_map/set.
>
> [1] http://libcxx.llvm.org/
> [2] https://github.com/ceph/ceph/compare/wip-libc%2B%2B

