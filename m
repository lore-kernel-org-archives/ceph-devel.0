From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: librados on OSX
Date: Tue, 10 Oct 2017 10:07:41 +0200
Message-ID: <a000d7c5-f75a-4f3e-02d8-5d45bee6f61d@digiware.nl>
References: <CAFCcFszkS0O7Q0we7NZV3nD904Lh_95jjT+HmOUCYJ7eoyus0A@mail.gmail.com>
 <1534752289.14577933.1507613155200.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:43405 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932095AbdJJIIC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 10 Oct 2017 04:08:02 -0400
In-Reply-To: <1534752289.14577933.1507613155200.JavaMail.zimbra@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kefu Chai <kchai@redhat.com>, Chris Blum <chris.blu@gmx.net>, Ceph Development <ceph-devel@vger.kernel.org>

On 10-10-2017 07:25, Kefu Chai wrote:
> + ceph-devel
> 
> ----- Original Message -----
>> From: "Chris Blum" <chris.blu@gmx.net>
>> To: kchai@redhat.com
>> Sent: Tuesday, October 10, 2017 12:10:47 AM
>> Subject: librados on OSX
>>
>> Hi Kefu,
>>
>> I stumbled across your pull request [1] to make ceph modules compile on OSX.
>> Since I'm working on a little side-project which requires librados and
>> since I'm developing on OSX I would be very happy to figure out how
>> you made librados build on your mac.
> 
> install all the dependencies, clang, nss, cmake, etc.
> 
> https://github.com/ceph/ceph/pull/17615#issuecomment-329122356

ceph.spec.in contains the dependancies that are for Linux systems.
./install-deps.sh contains a fair list of dependancies I needed for FreeBSD.

In the mix of the 2 you should be able to get it working.

Now the thing you need to be aware of, when you run into "bugs", is that
there is a translation shim that translates the Ceph-errors codes ( ==
Linux errorcodes) to their FreeBSD equivalents. And since not all
rewrites have matching counterparts, there is some optimism there.

Not sure how much of that would be applicable for OSX, and if all
rewrites are precise enough.

For the remark of Kefu in the PR, interoperability seems to work, but it
is certainly rough terrain.

--WjW


