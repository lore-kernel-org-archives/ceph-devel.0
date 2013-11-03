From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] test/libcephfs: free cmount after tests finishes
Date: Sat, 2 Nov 2013 23:17:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1311022315440.5861@cobra.newdream.net>
References: <1383458758-4218-1-git-send-email-xinglin@cs.utah.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56693 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab3KCGRI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Nov 2013 01:17:08 -0500
In-Reply-To: <1383458758-4218-1-git-send-email-xinglin@cs.utah.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xing Lin <xinglin@cs.utah.edu>
Cc: ceph-devel@vger.kernel.org

Applied this one too!

BTW, an easier workflow than sending patches to the list is to accumulate 
a batch of fixes in a branch and submit a pull request via github (at 
least if you're already a github user).  Whichever works well for you.

Thanks!
s

On Sun, 3 Nov 2013, Xing Lin wrote:

> unmount and release cmount at the end of tests
> 
> Signed-off-by: Xing Lin <xinglin@cs.utah.edu>
> ---
>  src/test/libcephfs/readdir_r_cb.cc | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/src/test/libcephfs/readdir_r_cb.cc b/src/test/libcephfs/readdir_r_cb.cc
> index 788260b..4a99f10 100644
> --- a/src/test/libcephfs/readdir_r_cb.cc
> +++ b/src/test/libcephfs/readdir_r_cb.cc
> @@ -54,4 +54,8 @@ TEST(LibCephFS, ReaddirRCB) {
>    ASSERT_LE(0, ceph_opendir(cmount, c_dir, &dirp));
>    ASSERT_EQ(5, ceph_getdnames(cmount, dirp, buf, 6));
>    ASSERT_EQ(4, ceph_getdnames(cmount, dirp, buf, 6));
> +
> +  // free cmount after finishing testing
> +  ASSERT_EQ(0, ceph_unmount(cmount));
> +  ASSERT_EQ(0, ceph_release(cmount));
>  }
> -- 
> 1.8.3.4 (Apple Git-47)
> 
> 
