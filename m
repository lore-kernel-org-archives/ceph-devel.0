From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: increasingly large packages and longer build times
Date: Mon, 7 Aug 2017 08:58:52 -0600
Message-ID: <CALqRxCzmEN0UUD5iGcDw+iSp8+=cBmJpVa2Z=27fyVD_RWzRmw@mail.gmail.com>
References: <CAC-Np1yg062K==JMEQhRTVKRe7orS3YoXz9hcgfKH+xfiZBiww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:35631 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbdHGO6y (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Aug 2017 10:58:54 -0400
Received: by mail-vk0-f54.google.com with SMTP id d124so2638951vkf.2
        for <ceph-devel@vger.kernel.org>; Mon, 07 Aug 2017 07:58:53 -0700 (PDT)
In-Reply-To: <CAC-Np1yg062K==JMEQhRTVKRe7orS3YoXz9hcgfKH+xfiZBiww@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Aug 2, 2017 at 7:39 AM, Alfredo Deza <adeza@redhat.com> wrote:
> The ceph-debuginfo package has continued to increase in size on almost
> every release, reaching 1.5GB for the latest luminous RC (12.1.2).
>
> To contrast that, the latest ceph-debuginfo in Hammer was about 0.73GB.
>
> Having packages that large is problematic on a few fronts:

I agree Alfredo. Here's a similar issue I am experiencing with the source sizes:

Jewel sizes:
  14M ceph-10.2.7.tar.gz
  82M ceph-10.2.7 uncompressed

Luminous sizes:
  142M ceph-12.1.2.tar.gz
  709M ceph-12.1.2  uncompressed

This adds minutes onto the build times when we must shuffle these
large artifacts around:

- Upstream we're transferring the artifacts between Jenkins slaves and chacra
  and download.ceph.com.

- Downstream in Fedora/RHEL land we're uploading these source tars to
  dist-git's lookaside cache, and it takes a while just to upload/download.

- Downstream in Debian and Ubuntu (AFAICT) they upload the source tars to Git
  with git-buildpackage, and this increases the time it takes to even "git
  clone" these repos.

The bundled Boost alone is is 474MB unpacked in 12.1.2. If we could
build Boost as a separate package (and not bundle it into ceph) it
would make it easier to manage builds upstream and downstream.

We could build a boost package in the jenkins.ceph.com infrastructure,
or the CentOS Storage SIG (for RHEL-based distros), and then start
depending on that system instead of EPEL. For Debian/Ubuntu, we could
use jenkins.ceph.com/chacra or something else - any suggestions from
Debian/Ubuntu folks?

- Ken
