From: Daniel Gryniewicz <dang@redhat.com>
Subject: Re: cmake
Date: Fri, 4 Dec 2015 09:15:58 -0500
Message-ID: <CAL-2WbEdQDHO-FY_Ns0vigWv1S0gMUk8X1NSQKaXH3kB2Lrn5w@mail.gmail.com>
References: <20151203152436.73e15e38@lembas.zaitcev.lan> <20151203223020.GB17144@ultraspiritum.redhat.com>
 <20151203170347.33867061@lembas.zaitcev.lan> <295720458.28620860.1449188812348.JavaMail.zimbra@redhat.com>
 <20151204015942.19951132@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34701 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbbLDOQS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Dec 2015 09:16:18 -0500
Received: by wmvv187 with SMTP id v187so76511211wmv.1
        for <ceph-devel@vger.kernel.org>; Fri, 04 Dec 2015 06:16:17 -0800 (PST)
In-Reply-To: <20151204015942.19951132@lembas.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Matt Benjamin <mbenjamin@redhat.com>, "Adam C. Emerson" <aemerson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Dec 4, 2015 at 3:59 AM, Pete Zaitcev <zaitcev@redhat.com> wrote:
> On Thu, 3 Dec 2015 19:26:52 -0500 (EST)
> Matt Benjamin <mbenjamin@redhat.com> wrote:
>
>> Could you share the branch you are trying to build?  (ceph/wip-5073 would not appear to be it.)
>
> It's the trunk with a few of my insignificant cleanups.
>
> But I found a fix: deleting the CMakeFiles/ and CMakeCache.txt let
> it run. Thanks again for the tip about the separate build directory.
>

FWIW, many cmake issues can be fixed by nuking the cmake generated
files.  This is one of the big advantages to a separate build dir,
since the simplest way to do this is to nuke the build dir.

Daniel
