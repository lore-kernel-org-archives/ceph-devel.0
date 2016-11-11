From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Boost embeded does not (yet) work with cmake/FreeBSD.
Date: Fri, 11 Nov 2016 12:14:45 +0100
Message-ID: <901bb0da-0250-4f71-9aa5-28af95d828d6@digiware.nl>
References: <fc88ac6d-6ca9-5904-0b01-9126c4868261@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:57369 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754579AbcKKLOv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 11 Nov 2016 06:14:51 -0500
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id 0AC2427F39
        for <ceph-devel@vger.kernel.org>; Fri, 11 Nov 2016 12:14:47 +0100 (CET)
In-Reply-To: <fc88ac6d-6ca9-5904-0b01-9126c4868261@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

On 11-11-2016 11:55, Willem Jan Withagen wrote:
> Before I go digging into this.
> Does anybode have a clou where to look.
> 
> This is what the cmake run reports.
> I guess that the --toolset=clang needs to be added somewhere.

And WITH_SYSTEM_BOOST=ON requires me to include boost 1.61.
Currently FreeBSD is at 1.55, and there are quite some patches to the
source. So i'd expect that rolling forward is not going to be very easy.

How is this going to work on systems which don't keep up with boost
releases but still want to us the system stuff?

Now hacked Cmake to ignore the version, but that is going to slap me in
the face once newer stuff is really required, either for features or
bugfixes.

--WjW


> -- BUILDING Boost Libraries at j 8
> Building Boost.Build engine with toolset ... tools/build/src/engine/###
> ### No toolset specified. Please use --toolset option.
> ###
> ### Known toolsets are: acc, borland, cc, como, clang, darwin, gcc,
> gcc-nocygwin, intel-darwin, intel-linux, intel-win32, kcc, k
>                        ylix, metrowerks, mipspro, msvc, qcc, pathscale,
> pgi, sun, sunpro, tru64cxx, vacpp, xlcpp, vc7, vc8, vc9, vc10, vc11,
> vc12, vc14                                    , vc15, vmsdecc
> ###/b2
> cp: ./tools/build/src/engine/###
> ### No toolset specified. Please use --toolset option.
> ###
> ### Known toolsets are: acc, borland, cc, como, clang, darwin, gcc,
> gcc-nocygwin, intel-darwin, intel-linux, intel-win32, kcc, k
>                        ylix, metrowerks, mipspro, msvc, qcc, pathscale,
> pgi, sun, sunpro, tru64cxx, vacpp, xlcpp, vc7, vc8, vc9, vc10, vc11,
> vc12, vc14                                    , vc15, vmsdecc
> ###/b2: File name too long
> cp: ./tools/build/src/engine/###
> ### No toolset specified. Please use --toolset option.
> ###
> ### Known toolsets are: acc, borland, cc, como, clang, darwin, gcc,
> gcc-nocygwin, intel-darwin, intel-linux, intel-win32, kcc, k
>                        ylix, metrowerks, mipspro, msvc, qcc, pathscale,
> pgi, sun, sunpro, tru64cxx, vacpp, xlcpp, vc7, vc8, vc9, vc10, vc11,
> vc12, vc14                                    , vc15, vmsdecc
> ###/bjam: File name too long
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

