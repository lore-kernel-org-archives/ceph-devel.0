From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: kraken + gcc7
Date: Wed, 26 Jul 2017 17:22:35 +1000
Message-ID: <CAF-wwdFtynSh=kaiRmrDELt5kB4GdDKMtQ6kA8+o22EePnmJ4Q@mail.gmail.com>
References: <CAF-wwdG6nhqFN85=ONTQ+XUc6mea3=QaqsaSfux_-pQvh2Wrsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:32968 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbdGZHWg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Jul 2017 03:22:36 -0400
Received: by mail-io0-f171.google.com with SMTP id j32so43935315iod.0
        for <ceph-devel@vger.kernel.org>; Wed, 26 Jul 2017 00:22:36 -0700 (PDT)
In-Reply-To: <CAF-wwdG6nhqFN85=ONTQ+XUc6mea3=QaqsaSfux_-pQvh2Wrsg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Just to be anal, the ceph patch is applied to the ceph source tree and
the rocksdb patch should be applied in the src/rocksdb
 directory.

On Wed, Jul 26, 2017 at 5:18 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
> Today I needed to build the current Kraken HEAD using gcc7. Unfortunately, the
> source of both ceph and the rocksdb submodule are incompatible with gcc7.
>
> I came up with the attached patches which allow the sources to compile. I'm
> posting them here as they may help someone make progress until the problems with
> gcc7 are fixed in the kraken branch.
>
> --
> Cheers,
> Brad



-- 
Cheers,
Brad
