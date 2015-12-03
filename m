From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Undefined Ref for simple prog
Date: Thu, 3 Dec 2015 16:22:41 -0700
Message-ID: <CAANLjFq4s3EyKqWZvR-h2i84O4qXiTHjYy_em48dBM4VhBPJmQ@mail.gmail.com>
References: <CAANLjFrbaa=wC=9tk9_w_ROxDF-yityFNRf=zBkrb6b0gA0gmg@mail.gmail.com>
	<20151203230814.GC17144@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:33446 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbbLCXWm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 18:22:42 -0500
Received: by vkca188 with SMTP id a188so56019558vkc.0
        for <ceph-devel@vger.kernel.org>; Thu, 03 Dec 2015 15:22:41 -0800 (PST)
In-Reply-To: <20151203230814.GC17144@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Yeah, I wound up tracing it that the cc file is elsewhere. I was
hoping that the dependency would be pretty small, but as I resolve
some, more show up. I thought about adding a target, but thought it
would be too much of a pain. It is looking like the easier option
after adding 8 dependencies on the compile line and it looks like
there are many more to go. The exercise has been good for me to better
understand how Ceph is glued together. I might just keep going this
manual route for the education value. Thanks for the reply.
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Thu, Dec 3, 2015 at 4:08 PM, Adam C. Emerson  wrote:
> On 03/12/2015, Robert LeBlanc wrote:
>> I'm trying to do some testing of Ceph components specifically around
>> the OP queues. I'm trying to use the class in a simple program where I
>> will do my testing, but I can't resolve one problem. I've had to
>> include  types.h as forward defining the Formatter class (already
>> included/forward defined in the base class). This is based on my PR
>> https://github.com/ceph/ceph/pull/6781 .
>
> Ceph's assert is infelicitous. The libcommon static library
> has the definitions in src/common/assert.cc. It depends on other
> things, though, so the easiest thing to do, if you're using autotools, is just
> to add a target to one of the Makefile.am scripts (probably in src/test)
> that uses CEPH_GLOBAL as its library. If you just copy and modify one
> of the targets for the binary tests, your program will get built as part of the
> unittests target.
>
> (You'll have to build src/gmock and src/gmock/gtest manually to call make
> unittests on its own.)
>
> If you're using cmake, it's simpler. Just copy one of the
> add_executable/target_link_libraries pairs in src/test/CMakeLists.txt and modify
> as appropriate. Your executable will be built as part of the default CMake
> target.
>
> --
> Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
> IRC: Aemerson@{RedHat, OFTC, Freenode}
> 0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.0
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWYM6+CRDmVDuy+mK58QAAqmYP/19mVkKR3P+mIHydYZlc
Hbzxrm7p2qAazfXNanufU/aickuGgob8oc6AOPS0j6Q85KOK86k0zdxy6DhF
6g8bNdT54y+mwpu/CYbaETwI7H+OQspBVdW7u07q17HC+uDTnOL/+SVxKPGu
dnalpuMkwp4Lk84ifT07hBGqd3WBGqYtBt5pMy8wvit4fPUgwklrkmRy+VPn
3PA2qhc16rtFb9PcOzBxrjpcf0FdP+HVFLpulKpw+trjjRsaexcsRK2dDmPa
GA2M9XrXzJ2qG/MWwPFZJAP+XaJ6iy6sxdJOJv5+TqvN0fabvy8rHcCV5GEy
KS2ORsCEt0Ysf68b+KG9F1QdiT90yKgft6m/4KkAztJzO7Yy3QtvXe3dZZ64
uJzumHd+vyvyVndvzWqzqU3s0pQJy4Zk8S4qHEdqtxFdQhKytF4txgr/XFgW
8mFKExyxDl+X7XfxJGSpuiwuR+AwuF7LoA75vr1mdunC5PQ1nKHGIgU/YZ9+
tCxsRmOl7jfp+wdtgcy9feKI4asZ00vXWNHV54iHIzoPScmqSeS2ZnrbPa1Q
eN4nSxLUjBXPbxi9GIEKjnWXUFdf+bIk/o5wyDW02B9Vz1+Myz9A08CC/X4A
UIk29M/m11QsX8bOqC1W8PUc1cqOBXB1HOi+YuP8guXwS+Z+X/3MKJVNtTPu
tZbb
=Dqe4
-----END PGP SIGNATURE-----
