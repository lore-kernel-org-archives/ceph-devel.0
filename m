From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: [RFC PATCH] client: don't use special inode for /..
Date: Wed, 10 Aug 2016 16:08:21 -0400
Message-ID: <CA+2bHPYjYPRn99e3nCTjED6c89MnD_Eih_27z_J1=b4_CtLqOg@mail.gmail.com>
References: <1470846630-830-1-git-send-email-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33033 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938481AbcHJUJF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Aug 2016 16:09:05 -0400
Received: by mail-qk0-f173.google.com with SMTP id t7so55034059qkh.0
        for <ceph-devel@vger.kernel.org>; Wed, 10 Aug 2016 13:08:52 -0700 (PDT)
In-Reply-To: <1470846630-830-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Aug 10, 2016 at 12:30 PM, Jeff Layton <jlayton@redhat.com> wrote:
> The CEPH_INO_DOTDOT thing is quite strange. Under most OS (Linux
> included), the parent of the root is itself. IOW, at the root, '.' and
> '..' refer to the same inode.
>
> Change the ceph client to do the same, as this allows users to get
> valid stat info for '..', as well as elimnating some special-casing.
>
> Signed-off-by: Jeff Layton <jlayton@redhat.com>

Don't forget Client::_lookup:

  if (dname == "..") {
    if (dir->dn_set.empty())
      r = -ENOENT;
    else
      *target = dir->get_first_parent()->dir->parent_inode; //dirs
can't be hard-linked
    goto done;
  }

Otherwise LGTM.

-- 
Patrick Donnelly
