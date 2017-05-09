From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: boost::future and continuations
Date: Tue, 9 May 2017 09:39:08 -0700
Message-ID: <CAJ4mKGbzvYp6+RupbyA=L=kAMUuykFrAy+DBEafAiV+fcWz6AQ@mail.gmail.com>
References: <457eab81-262e-c7f1-44e2-916dbfa3b4cb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:34609 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754119AbdEIQjK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 9 May 2017 12:39:10 -0400
Received: by mail-io0-f171.google.com with SMTP id k91so5528959ioi.1
        for <ceph-devel@vger.kernel.org>; Tue, 09 May 2017 09:39:10 -0700 (PDT)
In-Reply-To: <457eab81-262e-c7f1-44e2-916dbfa3b4cb@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Tue, May 9, 2017 at 7:16 AM, Casey Bodley <cbodley@redhat.com> wrote:
> I recently discovered that the Boost.Thread library implements some
> extensions to boost::future from the 'Technical Specification for C++
> Extensions for Concurrency' [1]. The std::experimental interfaces are
> documented on cppreference.com [2], but neither gcc nor clang provide them.
>
> The coolest new feature is future::then(), which takes a continuation to be
> called once the future is ready, and returns a future for the continuation's
> result. This allows futures to be composed into higher-level asynchronous
> operations - an ability that is sorely lacking in the c++11 std::future.
>
> While these extensions are not enabled in boost by default, they can be
> turned on with a series of BOOST_THREAD_PROVIDES_FUTURE* defines (since
> boost 1.57). The boost documentation for 'Conformance and Extension'
> [3]describes the status of this implementation, listing some features as
> 'partial'. I wrote a set of unit tests to explore this, and was happy with
> the results. The only unfortunate piece missing is 'implicit unwrapping' for
> future::then() - if you pass it a continuation that returns a future<T>,
> then() will return a future<future<T>>. This -should- be implicitly
> converted to future<T>, but boost::future requires you to do it explicitly
> by calling future::unwrap().
>
> I'm curious to see how people feel about this. Would you consider using
> boost::futures? Are there concerns about using boost extensions? About
> slight changes to interfaces? I opened a pull request [4] for discussion -
> take a look at the unit tests for examples, and let me know what you think.

This'll probably get more attention once Luminous is out, but we need
a futures library for the OSD and if there's one in Boost (that might
make it into the standard?) then it'll be an obvious candidate,
assuming it's capable enough to fulfill our needs!
-Greg
