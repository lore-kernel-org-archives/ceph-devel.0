From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Boost embeded does not (yet) work with cmake/FreeBSD.
Date: Fri, 11 Nov 2016 11:55:25 +0100
Message-ID: <fc88ac6d-6ca9-5904-0b01-9126c4868261@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:55978 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750714AbcKKKza (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 11 Nov 2016 05:55:30 -0500
Received: from [192.168.10.67] (opteron [192.168.10.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.digiware.nl (Postfix) with ESMTPSA id A6BE227EC4
        for <ceph-devel@vger.kernel.org>; Fri, 11 Nov 2016 11:55:26 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Before I go digging into this.
Does anybode have a clou where to look.

This is what the cmake run reports.
I guess that the --toolset=clang needs to be added somewhere.

--WjW

-- BUILDING Boost Libraries at j 8
Building Boost.Build engine with toolset ... tools/build/src/engine/###
### No toolset specified. Please use --toolset option.
###
### Known toolsets are: acc, borland, cc, como, clang, darwin, gcc,
gcc-nocygwin, intel-darwin, intel-linux, intel-win32, kcc, k
                       ylix, metrowerks, mipspro, msvc, qcc, pathscale,
pgi, sun, sunpro, tru64cxx, vacpp, xlcpp, vc7, vc8, vc9, vc10, vc11,
vc12, vc14                                    , vc15, vmsdecc
###/b2
cp: ./tools/build/src/engine/###
### No toolset specified. Please use --toolset option.
###
### Known toolsets are: acc, borland, cc, como, clang, darwin, gcc,
gcc-nocygwin, intel-darwin, intel-linux, intel-win32, kcc, k
                       ylix, metrowerks, mipspro, msvc, qcc, pathscale,
pgi, sun, sunpro, tru64cxx, vacpp, xlcpp, vc7, vc8, vc9, vc10, vc11,
vc12, vc14                                    , vc15, vmsdecc
###/b2: File name too long
cp: ./tools/build/src/engine/###
### No toolset specified. Please use --toolset option.
###
### Known toolsets are: acc, borland, cc, como, clang, darwin, gcc,
gcc-nocygwin, intel-darwin, intel-linux, intel-win32, kcc, k
                       ylix, metrowerks, mipspro, msvc, qcc, pathscale,
pgi, sun, sunpro, tru64cxx, vacpp, xlcpp, vc7, vc8, vc9, vc10, vc11,
vc12, vc14                                    , vc15, vmsdecc
###/bjam: File name too long
