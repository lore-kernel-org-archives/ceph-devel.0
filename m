From: Kefu Chai <kchai@redhat.com>
Subject: Re: librados on OSX
Date: Tue, 10 Oct 2017 01:25:55 -0400 (EDT)
Message-ID: <1534752289.14577933.1507613155200.JavaMail.zimbra@redhat.com>
References: <CAFCcFszkS0O7Q0we7NZV3nD904Lh_95jjT+HmOUCYJ7eoyus0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbdJJFZz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 10 Oct 2017 01:25:55 -0400
In-Reply-To: <CAFCcFszkS0O7Q0we7NZV3nD904Lh_95jjT+HmOUCYJ7eoyus0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Blum <chris.blu@gmx.net>, Ceph Development <ceph-devel@vger.kernel.org>

+ ceph-devel

----- Original Message -----
> From: "Chris Blum" <chris.blu@gmx.net>
> To: kchai@redhat.com
> Sent: Tuesday, October 10, 2017 12:10:47 AM
> Subject: librados on OSX
> 
> Hi Kefu,
> 
> I stumbled across your pull request [1] to make ceph modules compile on OSX.
> Since I'm working on a little side-project which requires librados and
> since I'm developing on OSX I would be very happy to figure out how
> you made librados build on your mac.

install all the dependencies, clang, nss, cmake, etc.

https://github.com/ceph/ceph/pull/17615#issuecomment-329122356

> 
> 
> Best Regards,
> Christopher Blum
> 
> 
> [1] https://github.com/ceph/ceph/pull/17615
> 
