From: Sage Weil <sweil@redhat.com>
Subject: Re: boost::future and continuations
Date: Tue, 9 May 2017 16:41:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705091640470.18953@piezo.novalocal>
References: <457eab81-262e-c7f1-44e2-916dbfa3b4cb@redhat.com> <CAJ4mKGbzvYp6+RupbyA=L=kAMUuykFrAy+DBEafAiV+fcWz6AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754625AbdEIQll (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 9 May 2017 12:41:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 42003C049DFD
        for <ceph-devel@vger.kernel.org>; Tue,  9 May 2017 16:41:41 +0000 (UTC)
In-Reply-To: <CAJ4mKGbzvYp6+RupbyA=L=kAMUuykFrAy+DBEafAiV+fcWz6AQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Casey Bodley <cbodley@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On Tue, 9 May 2017, Gregory Farnum wrote:
> On Tue, May 9, 2017 at 7:16 AM, Casey Bodley <cbodley@redhat.com> wrote:
> > I recently discovered that the Boost.Thread library implements some
> > extensions to boost::future from the 'Technical Specification for C++
> > Extensions for Concurrency' [1]. The std::experimental interfaces are
> > documented on cppreference.com [2], but neither gcc nor clang provide them.
> >
> > The coolest new feature is future::then(), which takes a continuation to be
> > called once the future is ready, and returns a future for the continuation's
> > result. This allows futures to be composed into higher-level asynchronous
> > operations - an ability that is sorely lacking in the c++11 std::future.
> >
> > While these extensions are not enabled in boost by default, they can be
> > turned on with a series of BOOST_THREAD_PROVIDES_FUTURE* defines (since
> > boost 1.57). The boost documentation for 'Conformance and Extension'
> > [3]describes the status of this implementation, listing some features as
> > 'partial'. I wrote a set of unit tests to explore this, and was happy with
> > the results. The only unfortunate piece missing is 'implicit unwrapping' for
> > future::then() - if you pass it a continuation that returns a future<T>,
> > then() will return a future<future<T>>. This -should- be implicitly
> > converted to future<T>, but boost::future requires you to do it explicitly
> > by calling future::unwrap().
> >
> > I'm curious to see how people feel about this. Would you consider using
> > boost::futures? Are there concerns about using boost extensions? About
> > slight changes to interfaces? I opened a pull request [4] for discussion -
> > take a look at the unit tests for examples, and let me know what you think.
> 
> This'll probably get more attention once Luminous is out, but we need
> a futures library for the OSD and if there's one in Boost (that might
> make it into the standard?) then it'll be an obvious candidate,
> assuming it's capable enough to fulfill our needs!

Yeah, +100 if it's on a standards track.  Is the implic unwrapping 
something that is planned and/or coming soon?

sage
