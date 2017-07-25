From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: unable to build Debian Stretch for 12.1.2
Date: Wed, 26 Jul 2017 07:53:01 +1000
Message-ID: <CAF-wwdE4kBKzDjbRNiKwdZ9W9TV9sdd6TJiTZ-MorhKJyUpL3g@mail.gmail.com>
References: <CAC-Np1y2RLRHTgbjNF7uM6-+nho1tz2PUxDE6pdef1y-bMtZxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35594 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbdGYVxI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jul 2017 17:53:08 -0400
Received: by mail-pg0-f51.google.com with SMTP id v190so75429074pgv.2
        for <ceph-devel@vger.kernel.org>; Tue, 25 Jul 2017 14:53:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAC-Np1y2RLRHTgbjNF7uM6-+nho1tz2PUxDE6pdef1y-bMtZxg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On Wed, Jul 26, 2017 at 5:02 AM, Alfredo Deza <adeza@redhat.com> wrote:
> We are (consistently) hitting this Segmentation Fault:
>
> /build/ceph-12.1.2/src/test/librbd/object_map/test_mock_LockRequest.cc:61:3:
> internal compiler error: Segmentation fault
>    }
>    ^
>
> https://jenkins.ceph.com/job/ceph-build/ARCH=x86_64,AVAILABLE_ARCH=x86_64,AVAILABLE_DIST=stretch,DIST=stretch,MACHINE_SIZE=huge/237/consoleFull#-1443688772a811ea2-3e7b-466b-84b4-d13df7e35809
>
> The builds for Debian distros are all produced from Xenial hosts that
> use pbuilder to accommodate any Deb distro. On the same host, Xenial
> and Trusty works fine for example.
>
> GCC version on the box that failed:
>
> gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
>
> The scripts we use for building are here:
> https://github.com/ceph/ceph-build/tree/master/ceph-build/build
>
> Unless someone can help out identify why this happens and how to fix
> it, it means that we will not be able to have Stretch packages.

This looks like a compiler error.

You can use "VERBOSE=1 make" to get it to spit out the command line that it is
running at the time of failure. Then hopefully you can run the compiler in gdb
and get a stack trace or, alternatively capture a coredump and get a stack trace
from that. I'd there compare the stack trace with known gcc bugs and hope we get
a hit.

>
> -Alfredo
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
