From: kefu chai <tchaikov@gmail.com>
Subject: Re: librados on OSX
Date: Wed, 11 Oct 2017 18:29:53 +0800
Message-ID: <CAJE9aOOO88WOQoJg-zzqNwiOGZP=ASiNA+F90Eu2+xHuSZW8iA@mail.gmail.com>
References: <CAFCcFszkS0O7Q0we7NZV3nD904Lh_95jjT+HmOUCYJ7eoyus0A@mail.gmail.com>
 <1534752289.14577933.1507613155200.JavaMail.zimbra@redhat.com>
 <a000d7c5-f75a-4f3e-02d8-5d45bee6f61d@digiware.nl> <CAFCcFsx0vAin5MT6_b57C4MJ2TVBBqzGn3GCfCFgVH_0OTQG+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:48325 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdJKK3z (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Oct 2017 06:29:55 -0400
Received: by mail-oi0-f54.google.com with SMTP id m198so2109254oig.5
        for <ceph-devel@vger.kernel.org>; Wed, 11 Oct 2017 03:29:54 -0700 (PDT)
In-Reply-To: <CAFCcFsx0vAin5MT6_b57C4MJ2TVBBqzGn3GCfCFgVH_0OTQG+A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Blum <chris.blu@gmx.net>
Cc: Kefu Chai <kchai@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Oct 11, 2017 at 6:11 PM, Chris Blum <chris.blu@gmx.net> wrote:
> Hi Kefu,
>
> I have read your comment [1], sadly this doesn't even comes close to
> giving me enough information.
> Assuming that all I need is dependencies, I have installed a bunch of
> brew and pip packages... [2]
> Then I also installed OSX-fuse[3] which provided the fuse development libraries.

you can disable the fuse support by passing -DWITH_FUSE=OFF to cmake.

> Then I figured out that your comment is already outdated since the NSS
> version now moved from v3.31 to v3.33.
> After that - cmake was still not happy - triggering me to provide
> include and library paths for NSS. So I ended up with this command:
>
> PKG_CONFIG_PATH=/usr/local/Cellar/nss/3.33/lib/pkgconfig; \
> cmake .. -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang \
> -DWITH_EMBEDDED=OFF -DWITH_MANPAGE=OFF -DWITH_LIBCEPHFS=OFF \
> -DWITH_XFS=OFF -DWITH_KRBD=OFF -DWITH_NSS=ON -DWITH_LTTNG=OFF \
> -DWITH_BABELTRACE=OFF -DCMAKE_BUILD_TYPE=Debug -DWITH_CCACHE=ON \
> -DWITH_RADOSGW=OFF \
> -DNSS_LIBRARIES=/usr/local/opt/nss/lib \
> -DNSS_INCLUDE_DIRS=/usr/local/opt/nss/include

pkg-config should be able to figure out nss's header path and library path..

>
> Since cmake is executed with '..' you probably run this in some kind
> of subdirectory of the repository - most probably /build?

./build, yes.

>
> Still after all these steps, I'm not able to build librados... Since

i am not sure what problem you ran into. but it happens. as we don't
have CI for OSX build, the build on this platform might break every
now and then with new commits. i just fixed it yesterday. see
https://github.com/ceph/ceph/pull/18213.

> I'm not that dependent on a Mac, I will move my development to a Linux
> VM - which is definitely less convenient, but at least I can continue
> the actual work I was trying to do.
> I'm leaving this so that maybe someone else will find the steps I
> tried and continues the effort ;)

thanks for trying this out. i just don't have enough bandwidth to
document all the dependencies and steps. probably a brew recipe would
be better, but.. yeah, that needs more work :-/

>
>
>
> [1] https://github.com/ceph/ceph/pull/17615#issuecomment-329122356
> [2] Hopefully more or less complete list of all my additional dependencies:
> pip install:
> cython
>
> brew install:
> cmake
> ccache
> leveldb
> NSS
> [3] https://osxfuse.github.io/
>
> On Tue, Oct 10, 2017 at 10:07 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> On 10-10-2017 07:25, Kefu Chai wrote:
>>> + ceph-devel
>>>
>>> ----- Original Message -----
>>>> From: "Chris Blum" <chris.blu@gmx.net>
>>>> To: kchai@redhat.com
>>>> Sent: Tuesday, October 10, 2017 12:10:47 AM
>>>> Subject: librados on OSX
>>>>
>>>> Hi Kefu,
>>>>
>>>> I stumbled across your pull request [1] to make ceph modules compile on OSX.
>>>> Since I'm working on a little side-project which requires librados and
>>>> since I'm developing on OSX I would be very happy to figure out how
>>>> you made librados build on your mac.
>>>
>>> install all the dependencies, clang, nss, cmake, etc.
>>>
>>> https://github.com/ceph/ceph/pull/17615#issuecomment-329122356
>>
>> ceph.spec.in contains the dependancies that are for Linux systems.
>> ./install-deps.sh contains a fair list of dependancies I needed for FreeBSD.
>>
>> In the mix of the 2 you should be able to get it working.
>>
>> Now the thing you need to be aware of, when you run into "bugs", is that
>> there is a translation shim that translates the Ceph-errors codes ( ==
>> Linux errorcodes) to their FreeBSD equivalents. And since not all
>> rewrites have matching counterparts, there is some optimism there.
>>
>> Not sure how much of that would be applicable for OSX, and if all
>> rewrites are precise enough.
>>
>> For the remark of Kefu in the PR, interoperability seems to work, but it
>> is certainly rough terrain.
>>
>> --WjW
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards
Kefu Chai
