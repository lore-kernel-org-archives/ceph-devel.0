From: Chris Blum <chris.blu@gmx.net>
Subject: Re: librados on OSX
Date: Wed, 11 Oct 2017 12:11:30 +0200
Message-ID: <CAFCcFsx0vAin5MT6_b57C4MJ2TVBBqzGn3GCfCFgVH_0OTQG+A@mail.gmail.com>
References: <CAFCcFszkS0O7Q0we7NZV3nD904Lh_95jjT+HmOUCYJ7eoyus0A@mail.gmail.com>
 <1534752289.14577933.1507613155200.JavaMail.zimbra@redhat.com> <a000d7c5-f75a-4f3e-02d8-5d45bee6f61d@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:50914 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbdJKKLc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Oct 2017 06:11:32 -0400
Received: by mail-qt0-f175.google.com with SMTP id f15so3535943qtf.7
        for <ceph-devel@vger.kernel.org>; Wed, 11 Oct 2017 03:11:31 -0700 (PDT)
In-Reply-To: <a000d7c5-f75a-4f3e-02d8-5d45bee6f61d@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kefu Chai <kchai@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Kefu,

I have read your comment [1], sadly this doesn't even comes close to
giving me enough information.
Assuming that all I need is dependencies, I have installed a bunch of
brew and pip packages... [2]
Then I also installed OSX-fuse[3] which provided the fuse development libraries.
Then I figured out that your comment is already outdated since the NSS
version now moved from v3.31 to v3.33.
After that - cmake was still not happy - triggering me to provide
include and library paths for NSS. So I ended up with this command:

PKG_CONFIG_PATH=/usr/local/Cellar/nss/3.33/lib/pkgconfig; \
cmake .. -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang \
-DWITH_EMBEDDED=OFF -DWITH_MANPAGE=OFF -DWITH_LIBCEPHFS=OFF \
-DWITH_XFS=OFF -DWITH_KRBD=OFF -DWITH_NSS=ON -DWITH_LTTNG=OFF \
-DWITH_BABELTRACE=OFF -DCMAKE_BUILD_TYPE=Debug -DWITH_CCACHE=ON \
-DWITH_RADOSGW=OFF \
-DNSS_LIBRARIES=/usr/local/opt/nss/lib \
-DNSS_INCLUDE_DIRS=/usr/local/opt/nss/include

Since cmake is executed with '..' you probably run this in some kind
of subdirectory of the repository - most probably /build?

Still after all these steps, I'm not able to build librados... Since
I'm not that dependent on a Mac, I will move my development to a Linux
VM - which is definitely less convenient, but at least I can continue
the actual work I was trying to do.
I'm leaving this so that maybe someone else will find the steps I
tried and continues the effort ;)



[1] https://github.com/ceph/ceph/pull/17615#issuecomment-329122356
[2] Hopefully more or less complete list of all my additional dependencies:
pip install:
cython

brew install:
cmake
ccache
leveldb
NSS
[3] https://osxfuse.github.io/

On Tue, Oct 10, 2017 at 10:07 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 10-10-2017 07:25, Kefu Chai wrote:
>> + ceph-devel
>>
>> ----- Original Message -----
>>> From: "Chris Blum" <chris.blu@gmx.net>
>>> To: kchai@redhat.com
>>> Sent: Tuesday, October 10, 2017 12:10:47 AM
>>> Subject: librados on OSX
>>>
>>> Hi Kefu,
>>>
>>> I stumbled across your pull request [1] to make ceph modules compile on OSX.
>>> Since I'm working on a little side-project which requires librados and
>>> since I'm developing on OSX I would be very happy to figure out how
>>> you made librados build on your mac.
>>
>> install all the dependencies, clang, nss, cmake, etc.
>>
>> https://github.com/ceph/ceph/pull/17615#issuecomment-329122356
>
> ceph.spec.in contains the dependancies that are for Linux systems.
> ./install-deps.sh contains a fair list of dependancies I needed for FreeBSD.
>
> In the mix of the 2 you should be able to get it working.
>
> Now the thing you need to be aware of, when you run into "bugs", is that
> there is a translation shim that translates the Ceph-errors codes ( ==
> Linux errorcodes) to their FreeBSD equivalents. And since not all
> rewrites have matching counterparts, there is some optimism there.
>
> Not sure how much of that would be applicable for OSX, and if all
> rewrites are precise enough.
>
> For the remark of Kefu in the PR, interoperability seems to work, but it
> is certainly rough terrain.
>
> --WjW
>
>
