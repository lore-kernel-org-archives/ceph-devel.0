From: Alfredo Deza <adeza@redhat.com>
Subject: Re: no more autotools
Date: Thu, 8 Sep 2016 19:12:58 -0400
Message-ID: <CAC-Np1y3i+mKo9fyCQxB6RZg_BJSw-kcTw_ZO-9zaOQnS-nDUQ@mail.gmail.com>
References: <alpine.DEB.2.11.1609081352170.9549@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38092 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752430AbcIHXNA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2016 19:13:00 -0400
Received: by mail-wm0-f44.google.com with SMTP id 1so3503567wmz.1
        for <ceph-devel@vger.kernel.org>; Thu, 08 Sep 2016 16:12:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1609081352170.9549@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, abhishek@suse.com

On Thu, Sep 8, 2016 at 10:00 AM, Sage Weil <sweil@redhat.com> wrote:
> Yesterday we merged a PR that removed all of the autotools build
> infrastructure from the master branch of ceph.git.  We'll be 100% cmake
> for Kraken.  Hooray!
>
> Huge thank you to Ali, Casey, Kefu, and everyone else who helped with this
> effort!
>
> The gitbuilder and teuthology bits should all now be fully functional with
> cmake-only as we've been doing builds and tests with it for a while.
> We've no doubt broken some things with the release builds.
>
> I think the next step should be to do a dev release (11.0.1) to work
> through the kinks and ensure that in a few weeks/months time when we are
> ready for kraken -rc's everything is working.  Alfredo and Abhishek, this
> will be mostly fall on you :).  I think any master commit is fine for our
> purposes (it's just a dev checkpoint and the main goal is to make sure the
> build works, not produce a well-tested set of packages for end users).

For the new CI replacement we already are building master (and kraken)
correctly so for
actual releases this shouldn't be too much of a hassle.

We are in a good place for a dev release (11.0.1) any time now.
>
> sage
