From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 0/6] net: ceph: messenger: code cleanup
Date: Wed, 27 Jan 2016 12:17:18 +0100
Message-ID: <CAOi1vP-Lqj4iA+cjFY1D3ERMdCyFxwkXTGEPpY2_oNJ9D-4PXA@mail.gmail.com>
References: <cover.1453853617.git.ciorneiioana@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35762 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075AbcA0LRT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jan 2016 06:17:19 -0500
Received: by mail-wm0-f68.google.com with SMTP id 123so2700933wmz.2
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jan 2016 03:17:19 -0800 (PST)
In-Reply-To: <cover.1453853617.git.ciorneiioana@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ioana Ciornei <ciorneiioana@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@ieee.org>

On Wed, Jan 27, 2016 at 1:43 AM, Ioana Ciornei <ciorneiioana@gmail.com> wrote:
>
> This patchset makes some small code cleanup on the messenger code from net/ceph.
> Most of the patches are a result of running checkpatch.pl on
> net/ceph/messenger.c
>
>
> Ioana Ciornei (6):
>   net: ceph: messenger: remove unnecessary blank spaces
>   net: ceph: messenger: fix coding style comparison to NULL
>   net: ceph: messenger: add blank line after declarations
>   net: ceph: messenger: properly align function parameters
>   net: ceph: messenger: change printk to pr_warn
>   net: ceph: messenger: add braces to all arms of conditional statement
>
>  net/ceph/messenger.c | 207 ++++++++++++++++++++++++++-------------------------
>  1 file changed, 107 insertions(+), 100 deletions(-)

Hi Ioana,

Most of above (especially patch 4/6) just clutters the history (think
"git blame" output) and, more importantly, complicates backporting of
future fixes to older kernels for no benefit at all.

There is a reason checkpatch.pl is called "check" "patch" - it is to be
run on patches, not files, with pretty much the only exception to that
being code in drivers/staging.  In certain cases, it might be OK to use
it on existing files to fix what it classifies as errors, but fixing
warnings or so called checks does more harm than good in most cases.

Thanks,

                Ilya
