From: Ken Dreyer <kdreyer@redhat.com>
Subject: intent to tag v10.2.7 mid-April
Date: Fri, 24 Mar 2017 10:54:06 -0600
Message-ID: <CALqRxCztzY6dwtipprXSpwbnJ45ZgvTOrOY7mBP2CeWhcr9v-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33853 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936445AbdCXQyJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Mar 2017 12:54:09 -0400
Received: by mail-vk0-f45.google.com with SMTP id z204so9901306vkd.1
        for <ceph-devel@vger.kernel.org>; Fri, 24 Mar 2017 09:54:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi folks,

There were a couple of PRs that missed v10.2.6 that I want to get into
v10.2.7. I intend to tag v10.2.7 roughly April 14th.

If we need at least two weeks for Yuri to complete final integration
testing, that means the cutoff for new changes to the jewel branch is
going to be one week from today (Mar 31st).

As of now, the things that I expect to go into v10.2.7:

- everything currently in "jewel" (8c02e54a747644d24feb98dbc15a15cdd55d1afd)
- https://github.com/ceph/ceph/pull/12917
- https://github.com/ceph/ceph/pull/13108
- https://github.com/ceph/ceph/pull/13219
- https://github.com/ceph/ceph/pull/13232
- https://github.com/ceph/ceph/pull/13503
- https://github.com/ceph/ceph/pull/13583
- https://github.com/ceph/ceph/pull/13596
- https://github.com/ceph/ceph/pull/13823
- https://github.com/ceph/ceph/pull/13844
- https://github.com/ceph/ceph/pull/13848
- https://github.com/ceph/ceph/pull/13858
- https://github.com/ceph/ceph/pull/13860
- https://github.com/ceph/ceph/pull/13867
- https://github.com/ceph/ceph/pull/13886
- http://tracker.ceph.com/issues/19143 - Matt is working on the PR for
this today

Further progress tracked in the release ticket,
http://tracker.ceph.com/issues/19055

- Ken
