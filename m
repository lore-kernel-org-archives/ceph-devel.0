From: Dan Mick <dmick@redhat.com>
Subject: Re: ceph-disk and 'make'
Date: Tue, 20 Sep 2016 15:14:37 -0700
Message-ID: <ed02167d-6199-7b74-415e-75457d059f02@redhat.com>
References: <alpine.DEB.2.11.1609190036390.3215@piezo.us.to>
 <57DF7DA0.2050007@dachary.org> <57DF9525.5050904@dachary.org>
 <CAJ4mKGb4ELCPgQOeiC_RWGtBZ44L1anrKX4eRJZx=p25cVCyMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751729AbcITWOi (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 20 Sep 2016 18:14:38 -0400
In-Reply-To: <CAJ4mKGb4ELCPgQOeiC_RWGtBZ44L1anrKX4eRJZx=p25cVCyMg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 09/19/2016 11:30 AM, Gregory Farnum wrote:
> On Sun, Sep 18, 2016 at 5:40 PM, Sage Weil <sweil@redhat.com> wrote:
>> I noticed that with the new cmake when I do a 'make' the ceph-disk target
>> isn't built.  And ctest will fail most of its unit tests.  It looks like
>> it is part of the 'tests' target, though.  Is it deliberate that a simple
>> 'make' doesn't build everything?
> 
> Dunno about this specific case, but in general we don't want
> *everything* to be built with a simple "make", since it slows down
> compile (and, especially, linking). I don't think ceph-disk is used
> during development for anything except the tests so this would make
> some sense, right?

I think I disagree; make -> make all-> make everything is certainly my
assumption.  There's no reason not to have other targets that build
less, but I expect "make" to default to "build everything that's
configured".  (That doesn't include tests, and doesn't install anything,
but if it *would be* installed by make install, I expect it to be
constructed.)


