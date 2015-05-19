From: Alex Elder <elder@ieee.org>
Subject: Re: kernel BUG at .../fs/ceph/xattr.c:287!
Date: Tue, 19 May 2015 07:50:13 -0500
Message-ID: <555B3185.8010304@ieee.org>
References: <mjfatn$c1e$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34924 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807AbbESMuQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 May 2015 08:50:16 -0400
Received: by igbyr2 with SMTP id yr2so74412669igb.0
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2015 05:50:15 -0700 (PDT)
In-Reply-To: <mjfatn$c1e$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: CSa <salzmann@mi.fu-berlin.de>, ceph-devel@vger.kernel.org

On 05/19/2015 07:39 AM, CSa wrote:
> Hi,
> 
> we are encountering a bug in the cephfs client kernel module:
> 
> 
> May 18 11:02:04 allegro kernel: [1020094.145209] ------------[ cut here 
> ]------------
> May 18 11:02:04 allegro kernel: [1020094.149127] kernel BUG at /build/linux-
> RGM_Ed/linux-3.16.7-ckt9/fs/ceph/xattr.c:287!
> May 18 11:02:04 allegro kernel: [1020094.149127] invalid opcode: 0000 [#1] 
> SMP 
> [...]
> May 18 11:02:04 allegro kernel: [1020094.149127] CPU: 2 PID: 1359 Comm: mv 
> Not tainted 3.16.0-4-amd64 #1 Debian 3.16.7-ckt9-3~deb8u1
> [...]
> 
> (see full log at http://paste.debian.net/180292)

Based on a quick look at the code, I think this must be
a use-after-free.

The bug occurs if ceph_vxattrs_name_size() is given a non-NULL
vxattrs pointer that is neither ceph_dir_vxattrs nor ceph_file_vxattrs.
There is only one caller of ceph_vxattrs_name_size(), and it is
passed a value that's a result of a call to ceph_inode_vxattrs().
That function returns only three possible values: ceph_dir_vxattrs,
ceph_file_vxattrs, or NULL.

					-Alex

> 
> has anybody been hit by this so far?
> 
> ciao
> Christian
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

