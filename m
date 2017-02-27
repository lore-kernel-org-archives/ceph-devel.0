From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH v5 0/6] ceph: implement new-style ENOSPC handling in
 kcephfs
Date: Mon, 27 Feb 2017 10:43:47 +0800
Message-ID: <14A10884-617D-4C0D-B7A9-7388943D241C@redhat.com>
References: <20170225174323.20289-1-jlayton@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751297AbdB0Cou (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 26 Feb 2017 21:44:50 -0500
In-Reply-To: <20170225174323.20289-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, John Spray <jspray@redhat.com>, ceph-devel@vger.kernel.org


> On 26 Feb 2017, at 01:43, Jeff Layton <jlayton@redhat.com> wrote:
> 
> v5: rebase onto ACK vs. commit changes
> 
> v4: eliminate map_cb and just call ceph_osdc_abort_on_full directly
> Revert earlier patch flagging individual pages with error on writeback
> failure. Add mechanism to force synchronous writes when writes start
> failing, and reallowing async writes when they succeed.
> 
> v3: track "abort_on_full" behavior with a new bool in osd request
> instead of a protocol flag. Remove some extraneous arguments from
> various functions. Don't export have_pool_full, call it from the
> abort_on_full callback instead.
> 
> v2: teach libcephfs how to hold on to requests until the right map
> epoch appears, instead of delaying cap handling in the cephfs layer.
> 
> Ok, with this set, I think we have proper -ENOSPC handling for all
> different write types (direct, sync, async buffered, etc...). -ENOSPC
> conditions.
> 
> This patchset is an updated version of the patch series originally
> done by John Spray and posted here:
> 
>    http://www.spinics.net/lists/ceph-devel/msg21257.html
> 
> The only real change from the last posting was to rebase it on top
> of Ilya's changes to remove the ack vs. commit behavior. That rebase
> was fairly simple and turns out to simplify the changes somewhat.
> 
> In the last series Zheng also mentioned removing the other SetPageError
> sites in fs/ceph. That may make sense, but I've left that out for now,
> as I'd like to look over PG_error handling in the kernel at large.
> 
> Jeff Layton (6):
>  libceph: allow requests to return immediately on full conditions if
>    caller wishes
>  libceph: abort already submitted but abortable requests when map or
>    pool goes full
>  libceph: add an epoch_barrier field to struct ceph_osd_client
>  ceph: handle epoch barriers in cap messages
>  Revert "ceph: SetPageError() for writeback pages if writepages fails"
>  ceph: when seeing write errors on an inode, switch to sync writes
> 
> fs/ceph/addr.c                  | 10 +++--
> fs/ceph/caps.c                  | 17 ++++++--
> fs/ceph/file.c                  | 32 ++++++++------
> fs/ceph/mds_client.c            | 20 +++++++++
> fs/ceph/mds_client.h            |  7 ++-
> fs/ceph/super.h                 | 26 +++++++++++
> include/linux/ceph/osd_client.h |  3 ++
> net/ceph/osd_client.c           | 96 +++++++++++++++++++++++++++++++++++++----
> 8 files changed, 180 insertions(+), 31 deletions(-)

Reviewed-by: "Yan, Zheng” <zyan@redhat.com>

> 
> -- 
> 2.9.3
> 

