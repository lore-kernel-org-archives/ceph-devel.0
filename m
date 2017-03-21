From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Testing fuse implementation.
Date: Tue, 21 Mar 2017 09:20:52 +0100
Message-ID: <be378c32-0754-3d92-281f-1e1fc7d2ec52@digiware.nl>
References: <2a2aa01a-4511-1bc2-0575-051f626575ad@digiware.nl>
 <CAJ4mKGYPLYYTooHYY8KayXxCub1OtmBVXTdXgp+5MLxo7RkzMA@mail.gmail.com>
 <CAOtMX2iVwM1UcD-RcPDMYpH8UTUahkJ28kfsjdkRp9ZzCENpGg@mail.gmail.com>
 <CAJ4mKGaU_ERDXVY8x484dv5iThSTr8RsOFd4LRzkM6_7K=8fWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:14752 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757169AbdCUIU4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 21 Mar 2017 04:20:56 -0400
In-Reply-To: <CAJ4mKGaU_ERDXVY8x484dv5iThSTr8RsOFd4LRzkM6_7K=8fWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, Alan Somers <asomers@freebsd.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 20-3-2017 18:38, Gregory Farnum wrote:
> On Mon, Mar 20, 2017 at 1:35 PM, Alan Somers <asomers@freebsd.org> wrote:
>> On Mon, Mar 20, 2017 at 10:57 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
>>> On Mon, Mar 20, 2017 at 12:52 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>>> Hi,
>>>>
>>>> Compiling ceph-fuse-fs on FreeBSD seemed like a few (1)  very tiny
>>>> change, and I'll need to update the install-deps for some extra packages.
>>>> But when I run the test-set there is not much that I see that gets
>>>> tested specifically for the fuse implementation.
>>>>
>>>> So that is hidden somewhere else...
>>>> Can somebody give me a pointer?
>>>
>>> There's not really anything in make check for it; we rely on the
>>> libcephfs tests for smoking out problems there.
>>>
>>> In teuthology ceph-fuse gets all kinds of proper filesystem tests run
>>> on it. Just pick whatever's convenient on BSD? (On Linux I'd recommend
>>> the pjd filesystem test suite, but I don't know if that's
>>> BSD-compatible or not.)
>>> -Greg
>>
>> You mean this pjd filesystem test suite?  As a matter of fact, it was
>> originally written for FreeBSD.
>> https://github.com/pjd/pjdfstest
> 
> Yep, that's the one. D'oh.

I'm getting a long way there.
The problem is that the default libvirt isn't default build with qemu.
But even if I fix that I'm still running into:
=======
Running libvirt-python-3.1.0/setup.py -q bdist_egg --dist-dir
/tmp/easy_install-gZWx9C/libvirt-python-3.1.0/egg-dist-tmp-0Qckkn
file build/libvirt.py (for module libvirt) not found
file build/libvirt_qemu.py (for module libvirt_qemu) not found
file build/libvirt_lxc.py (for module libvirt_lxc) not found
file build/libvirt.py (for module libvirt) not found
file build/libvirt_qemu.py (for module libvirt_qemu) not found
file build/libvirt_lxc.py (for module libvirt_lxc) not found
file build/libvirt.py (for module libvirt) not found
file build/libvirt_qemu.py (for module libvirt_qemu) not found
file build/libvirt_lxc.py (for module libvirt_lxc) not found
libvirt-override.c:25:10: fatal error: 'build/libvirt.h' file not found
#include "build/libvirt.h"
         ^
1 error generated.
=======

Which seems to a file which is runtime generated, but expects things in
libvirt that I do not presently have available. And debugging files that
are remove upon error is also magic beyond me.

Perhaps it is better/faster to do some home cooking and build a cluster,
mount ceph-fuse and run a fs-tst.
But then that would be all manual labour, where theutology is intended
to automate all this, and make it repeatable. :(

--WjW


