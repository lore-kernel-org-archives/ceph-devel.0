From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/6] libceph: luminous semantic changes and fixes
Date: Tue, 1 Aug 2017 14:31:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708011430510.20435@piezo.novalocal>
References: <1501245690-2362-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50249 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbdHAObG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Aug 2017 10:31:06 -0400
In-Reply-To: <1501245690-2362-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 28 Jul 2017, Ilya Dryomov wrote:
> Hello,
> 
> All straightforward and tested, but I want to make sure I haven't
> missed anything.
> 
> Thanks,
> 
>                 Ilya
> 
> 
> Ilya Dryomov (6):
>   libceph: make encode_request_*() work with r_mempool requests
>   libceph: don't call ->reencode_message() more than once per message
>   libceph: fallback for when there isn't a pool-specific choose_arg
>   crush: assume weight_set != null imples weight_set_size > 0
>   libceph: upmap semantic changes
>   libceph: make RECOVERY_DELETES feature create a new interval
> 
>  include/linux/ceph/osd_client.h |  1 +
>  include/linux/ceph/osdmap.h     |  2 ++
>  include/linux/ceph/rados.h      |  4 +++
>  include/linux/crush/crush.h     |  2 +-
>  net/ceph/crush/mapper.c         |  2 +-
>  net/ceph/messenger.c            |  6 ++---
>  net/ceph/osd_client.c           | 14 +++++++---
>  net/ceph/osdmap.c               | 60 ++++++++++++++++++++---------------------
>  8 files changed, 53 insertions(+), 38 deletions(-)

Reviewed-by: Sage Weil <sage@redhat.com>

Thanks!
s

