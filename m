From: Alfredo Deza <adeza@redhat.com>
Subject: Re: unable to build Debian Stretch for 12.1.2
Date: Tue, 25 Jul 2017 20:23:06 -0400
Message-ID: <CAC-Np1xnvw9KtwdKcTLTsKdarWH25FAeoExWhzB0Ad+TuTHM4A@mail.gmail.com>
References: <CAC-Np1y2RLRHTgbjNF7uM6-+nho1tz2PUxDE6pdef1y-bMtZxg@mail.gmail.com>
 <CAF-wwdE4kBKzDjbRNiKwdZ9W9TV9sdd6TJiTZ-MorhKJyUpL3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34914 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbdGZAXH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jul 2017 20:23:07 -0400
Received: by mail-wm0-f51.google.com with SMTP id c184so64993214wmd.0
        for <ceph-devel@vger.kernel.org>; Tue, 25 Jul 2017 17:23:07 -0700 (PDT)
In-Reply-To: <CAF-wwdE4kBKzDjbRNiKwdZ9W9TV9sdd6TJiTZ-MorhKJyUpL3g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Jul 25, 2017 at 5:53 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
>
>
> On Wed, Jul 26, 2017 at 5:02 AM, Alfredo Deza <adeza@redhat.com> wrote:
>> We are (consistently) hitting this Segmentation Fault:
>>
>> /build/ceph-12.1.2/src/test/librbd/object_map/test_mock_LockRequest.cc:61:3:
>> internal compiler error: Segmentation fault
>>    }
>>    ^
>>
>> https://jenkins.ceph.com/job/ceph-build/ARCH=x86_64,AVAILABLE_ARCH=x86_64,AVAILABLE_DIST=stretch,DIST=stretch,MACHINE_SIZE=huge/237/consoleFull#-1443688772a811ea2-3e7b-466b-84b4-d13df7e35809
>>
>> The builds for Debian distros are all produced from Xenial hosts that
>> use pbuilder to accommodate any Deb distro. On the same host, Xenial
>> and Trusty works fine for example.
>>
>> GCC version on the box that failed:
>>
>> gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
>>
>> The scripts we use for building are here:
>> https://github.com/ceph/ceph-build/tree/master/ceph-build/build
>>
>> Unless someone can help out identify why this happens and how to fix
>> it, it means that we will not be able to have Stretch packages.
>
> This looks like a compiler error.
>
> You can use "VERBOSE=1 make" to get it to spit out the command line that it is
> running at the time of failure. Then hopefully you can run the compiler in gdb
> and get a stack trace or, alternatively capture a coredump and get a stack trace
> from that. I'd there compare the stack trace with known gcc bugs and hope we get
> a hit.

Added it, not sure if that did anything (it might be me though)

https://jenkins.ceph.com/job/ceph-build/240/ARCH=x86_64,AVAILABLE_ARCH=x86_64,AVAILABLE_DIST=stretch,DIST=stretch,MACHINE_SIZE=huge/console

This is the line that consistently brings this crashing:
https://github.com/ceph/ceph/blob/luminous/src/test/librbd/object_map/test_mock_LockRequest.cc#L61

We will go ahead with the release without Debian Stretch. Maybe
someone can help figure this out, since it seems consistent (it failed
in the same way on the same spot every time).

This means that Debian Stretch will also be disabled on other releases
until we at least build it often enough without issues
>
>>
>> -Alfredo
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Cheers,
> Brad
