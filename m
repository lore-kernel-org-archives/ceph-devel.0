From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: new boost
Date: Mon, 29 Aug 2016 09:38:45 -0600
Message-ID: <CALqRxCzuD+uD4pw=E4Ds1gQh84hxHResMNkuoz7E7fYB9x1BJg@mail.gmail.com>
References: <alpine.DEB.2.11.1608261829420.24244@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:35049 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933539AbcH2Pir (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Aug 2016 11:38:47 -0400
Received: by mail-ua0-f169.google.com with SMTP id i32so81988623uai.2
        for <ceph-devel@vger.kernel.org>; Mon, 29 Aug 2016 08:38:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1608261829420.24244@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Aug 26, 2016 at 12:42 PM, Sage Weil <sweil@redhat.com> wrote:
> Now that we've transitioned to cmake, I'd like to resurrect the discussion
> about moving to a new version of boost.  I'm dying to use small_vector and
> flat_map.
>
> IIRC, we have a few options:
>
> 1) boost as a submodule.  compile and link statically.
>  - easy to maintain
>  - no packaging impact
>  - dev/build environment is not dependent on system install boost

The end-to-end build time is going to get even longer, and there is a
maintenance cost when we stop paying that tech debt a little bit at a
time when the distros release new boost packages. GitHub says Ceph's
civetweb is "This branch is 26 commits ahead, 1551 commits behind
civetweb:master". How do we keep that same thing from happening over
the years with a bundled boost?

Can we have a middle ground, where we use an up-to-date bundled
version of boost on distros without the features you want, and then
use the system boost if it's new enough (ie Fedora and presumably
Xenial or Yakkety)?

- Ken
