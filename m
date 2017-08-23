From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: increasingly large packages and longer build times
Date: Wed, 23 Aug 2017 08:53:58 -0600
Message-ID: <CALqRxCz-56kb0PfihpVDnywj4t_4Si3FVeXupFiKgLhs3Q6CFQ@mail.gmail.com>
References: <CAC-Np1yg062K==JMEQhRTVKRe7orS3YoXz9hcgfKH+xfiZBiww@mail.gmail.com>
 <CALqRxCzmEN0UUD5iGcDw+iSp8+=cBmJpVa2Z=27fyVD_RWzRmw@mail.gmail.com>
 <CAJ4mKGZ5eAvOTTDwAzoAjv2Ed0C3mb1E7PxQvphY85rXZy5Oow@mail.gmail.com> <CAJE9aON9ELevTue_DXdcYnqBVO2LbTe8mthbytegbtyfLm+K7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:37434 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754090AbdHWOyA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Aug 2017 10:54:00 -0400
Received: by mail-vk0-f41.google.com with SMTP id r199so1200804vke.4
        for <ceph-devel@vger.kernel.org>; Wed, 23 Aug 2017 07:53:59 -0700 (PDT)
In-Reply-To: <CAJE9aON9ELevTue_DXdcYnqBVO2LbTe8mthbytegbtyfLm+K7A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Alfredo Deza <adeza@redhat.com>

On Tue, Aug 22, 2017 at 1:01 AM, kefu chai <tchaikov@gmail.com> wrote:
> my main concern would be the downstream. how shall we accommodate the
> packaging of downstream? for example, what if the boost package
> maintainers of SuSE/fedora/debian/ubuntu are not ready to package the
> boost version we want to use in future?

Fedora has Boost 1.63.0 for a while, and f27 and f28 will have 1.64 or
newer. I think we'll be ok there, because Jonathan Wakely tends to
keep that very up-to-date.

This is just brainstorming, I have nothing concrete here: For the
CentOS side, and for the RH Ceph Storage downstream layered product, I
am thinking about building an entirely separate boost RPM and just let
it override the system version that ships in RHEL 7. I've tested
rebuilding boost-1.64.0-0.8.fc28.src.rpm on RHEL in mock and it
worked. (I had to remove the fiber, numpy, and python3 pieces).

For Debian and older Ubuntu LTSs, we could do something similar:
rebuild the boost source package from unstable/artful and let those
override the OS versions.

> actually almost all ceph_test_* are linking against libceph-common.
> but they are linking against libglobal and libos statically.

Is that the root issue with the debuginfo size?

- Ken
