From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: blueprint: osd: ceph on zfs
Date: Sun, 4 Aug 2013 16:39:23 -0700
Message-ID: <CA+Hcz59y0S31YJdP-MHQnUNKLjWo9Lezc4OWzJjx8i283=bAcQ@mail.gmail.com>
References: <alpine.DEB.2.00.1307251649540.32741@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:65050 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753995Ab3HDXjY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 4 Aug 2013 19:39:24 -0400
Received: by mail-ve0-f178.google.com with SMTP id ox1so2428867veb.37
        for <ceph-devel@vger.kernel.org>; Sun, 04 Aug 2013 16:39:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1307251649540.32741@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It seems to make sense that fiemap should be part of the `class
BackingFileSystem` abstraction?

On Thu, Jul 25, 2013 at 4:53 PM, Sage Weil <sage@inktank.com> wrote:
> http://wiki.ceph.com/01Planning/02Blueprints/Emperor/osd:_ceph_on_zfs
>
> We've done some preliminary testing and xattr debugging that allows
> ceph-osd to run on zfsforlinux using the normal writeahead journaling mode
> (the same mode used for xfs and ext4).  However, we aren't doing anything
> special to take advantage of zfs's capabilities.
>
> This session would go over what is needed to make parallel journaling work
> (which would leverage zfs snapshots).  I would also like to have a
> discussion about whether other longer-term possibilities, such as storing
> objects directly using the DMU, make sense given what ceph-osd's
> ObjectStore interface really needs.  It might also be an appropriate time
> to visit whether other snapshotting linux filesystems (like nilfs2) would
> fit well into any generalization of the filestore code that comes out of
> this effort.
>
> If anybody is interested in this, please add yourself to the interested
> parties section (or claim ownership) of this blueprint!
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
