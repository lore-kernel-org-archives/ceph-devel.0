From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] Rbd: copy-on-read support for kernel rbd client
Date: Thu, 21 May 2015 12:07:43 +0300
Message-ID: <CAOi1vP_1C6mG9YM0fV=qHGJsYkMLq_eBJVbHCpKnvjDGiwkfFA@mail.gmail.com>
References: <cover.1432177493.git.liwang@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38381 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbbEUJHs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 May 2015 05:07:48 -0400
Received: by wichy4 with SMTP id hy4so6347862wic.1
        for <ceph-devel@vger.kernel.org>; Thu, 21 May 2015 02:07:43 -0700 (PDT)
In-Reply-To: <cover.1432177493.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: Sage Weil <sweil@redhat.com>, Alex Elder <elder@kernel.org>, Josh Durgin <josh.durgin@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>, Min Chen <minchen@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

On Thu, May 21, 2015 at 6:11 AM, Li Wang <liwang@ubuntukylin.com> wrote:
> This is a new feature of rbd layering, when reading an object
> from child, if not exist, the kernel rbd client will not only
> request parent for the object, but also write it to child,
> and the jobs are done in an asynchronous way. Therefore, the
> subsequent accesses on this object will hit child without
> bothering parent. This feature could avoid longer latency incurred
> during accessing parent, especially when child and parent are
> geographically isolated, and it also could potentially avoid
> overloading parent.
>
> The patches:
> https://github.com/ceph/ceph-client/pull/11
>
> Min Chen (4):
>   Rbd: add an option for copy-on-read
>   Rbd: add a new request: rbd_copyup_request
>   Rbd: helper functions to manipulate rbd_copyup_request
>   Rbd: implement the copy-on-read logic
>
>  drivers/block/rbd.c | 385 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 382 insertions(+), 3 deletions(-)

Kernel client patches should be posted to ceph-devel.  While I can
certainly do my review on github, others won't.  Please post those
patches as a reply to your cover letter.

Thanks,

                Ilya
