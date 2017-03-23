From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: run-rbd-tests not in 'make check'?
Date: Thu, 23 Mar 2017 14:03:54 -0400
Message-ID: <CA+aFP1AXDZw-Aoq3YWXaOJEymW+C619GrH41=NbMjpZBFh=vMA@mail.gmail.com>
References: <CALZt5jwF4dk_ivpm1XKCYGGxGi0ZN_auiiDNz30xS+EC=gVftw@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34792 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753029AbdCWSD5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Mar 2017 14:03:57 -0400
Received: by mail-lf0-f52.google.com with SMTP id z15so85126702lfd.1
        for <ceph-devel@vger.kernel.org>; Thu, 23 Mar 2017 11:03:55 -0700 (PDT)
In-Reply-To: <CALZt5jwF4dk_ivpm1XKCYGGxGi0ZN_auiiDNz30xS+EC=gVftw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

The "make check" process executes "run-rbd-unit-tests" instead to
quickly cover basic functionality tests w/o the need to have a
long-running integration test incorporated into the build system.
Integration-level testing is accomplished via teuthology test suites.
If you are specifically referring to the cram rbd CLI tests, that is
executed during "make check" since it doesn't require a full system
stack to be up-and-running (i.e. it's not testing system integration).

On Thu, Mar 23, 2017 at 1:10 PM, Ning Yao <zay11022@gmail.com> wrote:
> Hi, all
>
> Why run-rbd-tests now is not involved into "make check" to verify the
> rbd cli now? So how could we test rbd cli now?
>
>
> Regards
> Ning Yao
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
