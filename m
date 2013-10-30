From: asomers@gmail.com
Subject: Re: feedback on supporting libc++
Date: Wed, 30 Oct 2013 10:13:00 -0600
Message-ID: <CAOtMX2g5rdOzHoe73XGy=Yn3erMfuxHBuJCGsD3E2RLh+8c3mg@mail.gmail.com>
References: <CA+Hcz5-8k3rnCaJJj3htb0F63V+fitoBtofCkGzJZ4a_j29K8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:37611 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab3J3QNC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Oct 2013 12:13:02 -0400
Received: by mail-we0-f177.google.com with SMTP id x55so1498476wes.22
        for <ceph-devel@vger.kernel.org>; Wed, 30 Oct 2013 09:13:00 -0700 (PDT)
In-Reply-To: <CA+Hcz5-8k3rnCaJJj3htb0F63V+fitoBtofCkGzJZ4a_j29K8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@inktank.com>, Gregory Farnum <gregory.farnum@inktank.com>

This approach is basically what Kyua did for libc++ compatibility.  It
looks good.  The only things I don't like are the
CEPH_HASH_NAMESPACE_{START,END} macros.  I'm personally not a fan of
macros that change language syntax.  However, I can't come up with an
alternative that doesn't involve either more C++11 features or more
#ifdefs.

-Alan

On Tue, Oct 29, 2013 at 4:51 PM, Noah Watkins <noah.watkins@inktank.com> wrote:
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
>   std::tr1::shared/weak_ptr maps to ceph::shared/weak_ptr
>
>   hash_map/set maps to ceph::unordered_map/set
>
> which will choose tr1::unordered_map/set over ext/hash_map/set.
>
> [1] http://libcxx.llvm.org/
> [2] https://github.com/ceph/ceph/compare/wip-libc%2B%2B
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
