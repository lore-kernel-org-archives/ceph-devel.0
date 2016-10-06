From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: new naming convention for building repos and binaries from branches
Date: Thu, 6 Oct 2016 10:33:26 -0600
Message-ID: <CALqRxCyGpfQj1R3KLQ75-S2zWkvyY-wRBZvx1vBeY-6Wfc3BOA@mail.gmail.com>
References: <CAC-Np1wcBGRcFYtK8WsjfM-WR+H_S58XgH74D+dBiGxd=KwZUQ@mail.gmail.com>
 <CALe9h7da1Oz29q2pot1BZLNBcs1NJ51BRLE+Uj_3mVjnDGw6fQ@mail.gmail.com> <CAEPMp+7OJ+pX=mYbNGgm+HZMGOGDK3xiApw5OL03vsN9YApTGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f177.google.com ([209.85.217.177]:35496 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942075AbcJFQd2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Oct 2016 12:33:28 -0400
Received: by mail-ua0-f177.google.com with SMTP id u68so22607012uau.2
        for <ceph-devel@vger.kernel.org>; Thu, 06 Oct 2016 09:33:27 -0700 (PDT)
In-Reply-To: <CAEPMp+7OJ+pX=mYbNGgm+HZMGOGDK3xiApw5OL03vsN9YApTGA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Schoen <aschoen@redhat.com>
Cc: John Spray <jspray@redhat.com>, Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 6, 2016 at 10:30 AM, Andrew Schoen <aschoen@redhat.com> wrote:
>>> We could keep the implicit convention for `wip-*` or maybe something similar?
>>
>> Building everything that starts with wip-* sounds fine to me.  But
>> isn't that usually everything that we push to the ceph/ceph
>> repository?  What is is that we're trying to avoid building?
>>
>> John
>
> I think the idea is that we only want to build branches that we plan
> to run tests against. As we add more flavors, distros and
> architectures to build for the workload increases exponentially. The
> system is designed to scale, but let's not build things we don't
> really need.

What branches in https://github.com/ceph/ceph are being built that do
not need to be built?

- Ken
