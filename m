From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH 0/5] libceph: crush tunables5
Date: Wed, 3 Feb 2016 22:46:22 +0800
Message-ID: <CAAM7YAmj8LbkVabNGwp4QDPK1CYr+AdVnUi6gWUdxEY_RQneGg@mail.gmail.com>
References: <1454509401-19734-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34875 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbcBCOqY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 09:46:24 -0500
Received: by mail-lf0-f68.google.com with SMTP id j99so755966lfi.2
        for <ceph-devel@vger.kernel.org>; Wed, 03 Feb 2016 06:46:23 -0800 (PST)
In-Reply-To: <1454509401-19734-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

On Wed, Feb 3, 2016 at 10:23 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> Hello,
>
> This series adds support for the new chooseleaf_stable CRUSH tunable
> and enables TUNABLES5 feature bit.  It's likely that TUNABLES5 bit will
> be shared and cover request_redirect_t encoding in MOSDOpReply and
> possibly new file layouts but those aren't in master yet.
>

file layout RP hasn't been merged. I will push the kernel patch once
it get merged

Regards
Yan, Zheng

> Thanks,
>
>                 Ilya
>
>
> Ilya Dryomov (5):
>   crush: ensure bucket id is valid before indexing buckets array
>   crush: ensure take bucket value is valid
>   crush: add chooseleaf_stable tunable
>   crush: decode and initialize chooseleaf_stable
>   libceph: advertise support for TUNABLES5
>
>  include/linux/ceph/ceph_features.h | 13 ++++++++++++-
>  include/linux/crush/crush.h        |  8 +++++++-
>  net/ceph/crush/mapper.c            | 33 ++++++++++++++++++++++++++-------
>  net/ceph/osdmap.c                  | 19 ++++++++++++++-----
>  4 files changed, 59 insertions(+), 14 deletions(-)
>
> --
> 2.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
