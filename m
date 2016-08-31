From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH 0/2]: CEPHFS: allow for races between direct and buffered writes
Date: Wed, 31 Aug 2016 17:19:04 +0800
Message-ID: <CAAM7YA=p9EdH6Kd2t_b5ZzbEHm5PSvEVakcSTtCiH=5o5sNi1g@mail.gmail.com>
References: <874m61eje0.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:36359 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756381AbcHaJTG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Aug 2016 05:19:06 -0400
Received: by mail-ua0-f171.google.com with SMTP id m60so77738075uam.3
        for <ceph-devel@vger.kernel.org>; Wed, 31 Aug 2016 02:19:05 -0700 (PDT)
In-Reply-To: <874m61eje0.fsf@notabene.neil.brown.name>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: NeilBrown <neilb@suse.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Aug 31, 2016 at 10:56 AM, NeilBrown <neilb@suse.com> wrote:
>
> Hi,
>  it is quite possible for O_DIRECT and buffered writes to a file to
>  race.
>  The xfstests test suite has a test - generic/036 - which tests this
>  case.
>
>  Unlike most filesystems, cephfs does not hold inode_lock() across
>  direct writes.  This means that buffer pages can become dirty while
>  direct writes are happening.  This confused ceph a little.

how about make ceph_write_iter() hold inode_lock() for direct/sync write?

Regards
Yan, Zheng
>
>  The following two patches allow ceph to handle this possibility a
>  little more cleanly.  The more important patch removes a WARN_ON() for
>  a circumstance which can easily be triggered.
>
> Thanks,
> NeilBrown
