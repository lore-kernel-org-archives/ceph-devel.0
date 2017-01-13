From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 0/4] ceph: endianness fixes and sparse warning fixes
Date: Fri, 13 Jan 2017 07:36:05 -0500
Message-ID: <1484310965.2616.7.camel@redhat.com>
References: <1484237565-27423-1-git-send-email-jlayton@redhat.com>
         <alpine.DEB.2.11.1701121623290.5745@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34381 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdAMMgL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jan 2017 07:36:11 -0500
Received: by mail-qk0-f173.google.com with SMTP id a20so52540806qkc.1
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jan 2017 04:36:10 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1701121623290.5745@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On Thu, 2017-01-12 at 16:23 +0000, Sage Weil wrote:
> On Thu, 12 Jan 2017, Jeff Layton wrote:
> > Just a small set of patches to fix some stuff that sparse was
> > complaining about. Some of these look like real bugs however for
> > anyone trying to use ceph on a big endian arch.
> > 
> > Jeff Layton (4):
> >   ceph: fix endianness of getattr mask in ceph_d_revalidate
> >   ceph: fix endianness bug in frag_tree_split_cmp
> >   ceph: fix bogus endianness change in ceph_ioctl_set_layout
> >   ceph: fix bad endianness handling in parse_reply_info_extra
> > 
> >  fs/ceph/dir.c        | 5 +++--
> >  fs/ceph/inode.c      | 3 ++-
> >  fs/ceph/ioctl.c      | 4 ++--
> >  fs/ceph/mds_client.c | 9 +++++----
> >  4 files changed, 12 insertions(+), 9 deletions(-)
> 
> Reviewed-by: Sage Weil <sage@redhat.com>

Thanks. Should we send this series to stable? I'm not sure how common
kcephfs mounts are on BE arches, but these bugs would likely prevent it
from working.

Thanks,
-- 
Jeff Layton <jlayton@redhat.com>
