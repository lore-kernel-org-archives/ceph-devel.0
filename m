From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: RBD volumes for bare-metal hosts
Date: Wed, 6 Jul 2016 01:41:04 +0200
Message-ID: <CAOi1vP_JFBXVEsQxTAkbtGR1WyXdoeev=--xT6gircBff5EAYw@mail.gmail.com>
References: <CA+H5UW2-RKn6aDfpjT1+hFHyNx7-kX1PoXxSV_sbT9zaCbJ2+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35383 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbcGEXlH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jul 2016 19:41:07 -0400
Received: by mail-wm0-f42.google.com with SMTP id z126so93069775wme.0
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jul 2016 16:41:06 -0700 (PDT)
In-Reply-To: <CA+H5UW2-RKn6aDfpjT1+hFHyNx7-kX1PoXxSV_sbT9zaCbJ2+w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Yunchuan Wen <yunchuan.wen@kylin-cloud.com>

On Wed, Jul 6, 2016 at 12:16 AM, Radoslaw Zarzynski
<rzarzynski@mirantis.com> wrote:
> Hello Guys,
>
> I wonder about a method for providing bare-metal hosts with an access
> to RBD volumes.
>
> The most obvious solution is krbd. Unfortunately, it has a substantial
> feature gap in comparison to librbd [1][2]. exclusive-lock seems to be
> the basic dependency that should be satisfied to even start thinking
> about the rest. Is someone working on this feature? What are the plans
> in general?

The code for exclusive-lock, object-map and fast-diff is pretty much
ready.  We had a large prerequisite that had to go in before any of
these and it's been merged into 4.7, so it's now a matter of review and
more comprehensive testing.  deep-flatten isn't ready, but should
follow shortly after.

Note that you can disable all of these features dynamically and that
the image is perfectly usable with none of them enabled.  Unless you
have clones or discard a lot, in which case object-map can help, the
I/O path is the same.

No concrete plans for mirroring support yet.

Thanks,

                Ilya
