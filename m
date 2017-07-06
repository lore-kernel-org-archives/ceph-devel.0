From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: Note about rbd_aio_write usage
Date: Thu, 6 Jul 2017 21:25:08 +0200
Message-ID: <20170706192508.GG9832@mailware>
References: <f5062e24-d138-a096-0171-79bc1259db7b@corp.ovh.com>
 <CA+aFP1A5UVZzSDfFvphsVq9Jra9PXbJHUXhaJ9tH8LGx5OKJfA@mail.gmail.com>
 <c81d848d-04f9-bca5-0e8f-6fe1f1814903@corp.ovh.com>
 <CA+aFP1A_EAMxP+cMKN2SDcZ2C-KE3wadkydK_AGpfBg+p75pcQ@mail.gmail.com>
 <a974656a-2fc4-1fed-6adc-fbb42c54bd7e@corp.ovh.com>
 <CA+aFP1Bs4K=eoYn4d1zo7HY8nWufLYOcQHX-r68frZ+ftNBHxQ@mail.gmail.com>
 <e39eba47-ae4d-05bb-41cd-928565324d6c@corp.ovh.com>
 <CA+aFP1CXkF914u1qboCC1OnK3Qqqs7w0NctDxG82u=gpmUcxmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:40584 "EHLO predictor.org.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751813AbdGFTe5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Jul 2017 15:34:57 -0400
Content-Disposition: inline
In-Reply-To: <CA+aFP1CXkF914u1qboCC1OnK3Qqqs7w0NctDxG82u=gpmUcxmA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Piotr =?utf-8?B?RGHFgmVr?= <piotr.dalek@corp.ovh.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

On Thu, Jul 06, 2017 at 02:02:39PM -0400, Jason Dillaman wrote:
> On Thu, Jul 6, 2017 at 11:46 AM, Piotr Dałek <piotr.dalek@corp.ovh.com> wrote:
> > How about a hybrid solution? Keep the old rbd_aio_write contract (don't copy
> > the buffer with the assumption that it won't change) and instead of
> > constructing bufferlist containing bufferptr to copied data, construct a
> > bufferlist containing bufferptr made with create_static(user_buffer)?
> 
> We must be talking past each other -- there was never such a
> pre-Lumunous contract since (1) it did copy the buffer on every IO and
> (2) it could have potentially copied before the 'rbd_aio_write' call
> returned or after (but at least before the completion was fired). Just
> because it works some times doesn't mean it would always work since it
> would be a race between two threads.
>
> Unfortunately, until the librados issue is solved, you will still have
> to copy the data once when using the C++ API. The only advantage is
> that you would be responsible for the copying and it would only need
> to be performed once instead of twice.

Even if it did copied the buffer, it did at unspecified point in time (as
you noted above!) requiring rbd_aio_write caller to follow usual AIO
practice of keeping buffers passed for as long as AIO is in progress. With
Luminous, not only it's no longer necessary, but it also hinders the user
program performance as buffers are always deep-copied, regardless of whether
caller follows AIO rules or not. Is that deep copy an equivalent of what
Jewel librbd did at unspecified point of time, or extra one?

-- 
Piotr Dałek
