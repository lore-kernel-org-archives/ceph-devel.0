From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: RBD volumes for bare-metal hosts
Date: Wed, 6 Jul 2016 02:21:47 +0200
Message-ID: <CA+H5UW1_M+bDMu6xu9JL9Ojb6j3JihyTnQcFvMYb6BPU49dPUQ@mail.gmail.com>
References: <CA+H5UW2-RKn6aDfpjT1+hFHyNx7-kX1PoXxSV_sbT9zaCbJ2+w@mail.gmail.com>
 <CAOi1vP_JFBXVEsQxTAkbtGR1WyXdoeev=--xT6gircBff5EAYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35973 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbcGFAVw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jul 2016 20:21:52 -0400
Received: by mail-qk0-f174.google.com with SMTP id u68so26744493qkc.3
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jul 2016 17:21:52 -0700 (PDT)
In-Reply-To: <CAOi1vP_JFBXVEsQxTAkbtGR1WyXdoeev=--xT6gircBff5EAYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Yunchuan Wen <yunchuan.wen@kylin-cloud.com>

Hi Ilya,

Thanks for the quick and detailed response.

On Wed, Jul 6, 2016 at 1:41 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> The code for exclusive-lock, object-map and fast-diff is pretty much
> ready.  We had a large prerequisite that had to go in before any of
> these and it's been merged into 4.7, so it's now a matter of review and
> more comprehensive testing.  deep-flatten isn't ready, but should
> follow shortly after.

This sounds great.

> No concrete plans for mirroring support yet.

AFAIK the sole dependency for mirroring (from RBD volume
consumer's POV) is journaling that in turn requires exclusive-lock.
Having the last one in the code base opens a door for the whole
feature. The user-space daemon (rbd-mirror) and tooling might be
reused. Is that correct?

Regards,
Radek
