From: Sage Weil <sage@newdream.net>
Subject: Re: fs selection.
Date: Fri, 27 May 2011 12:38:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105271237160.24784@cobra.newdream.net>
References: <4DDF9207.4090008@ufm.su> <Pine.LNX.4.64.1105270929100.10685@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47436 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756452Ab1E0ThY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 May 2011 15:37:24 -0400
In-Reply-To: <Pine.LNX.4.64.1105270929100.10685@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

Can you post the full crash dump?  This is missing the EIP line that shows 
the function and offset it was actually in at the time of the crash, and 
the error itself (null pointer, BUG, etc.).

Thanks!
sage


On Fri, 27 May 2011, Sage Weil wrote:

> On Fri, 27 May 2011, Fyodor Ustinov wrote:
> > it kills ext3:
> > 
> > [49531.320004]  [<ffffffff811d3c4c>] ext3_new_blocks+0x40c/0x6b0
> > [49531.320004]  [<ffffffff811d3f11>] ext3_new_block+0x21/0x30
> > [49531.320004]  [<ffffffff811e798e>] ext3_xattr_block_set+0x2ae/0x790
> > [49531.320004]  [<ffffffff811e86ba>] ext3_xattr_set_handle+0x30a/0x4c0
> > [49531.320004]  [<ffffffff811e88f5>] ext3_xattr_set+0x85/0xe0
> > [49531.320004]  [<ffffffff81277053>] ?
> > security_inode_exec_permission+0x23/0x30
> > [49531.320004]  [<ffffffff811e8ae9>] ext3_xattr_user_set+0x49/0x50
> > [49531.320004]  [<ffffffff811818e4>] generic_setxattr+0x74/0x90
> > [49531.320004]  [<ffffffff811820c0>] __vfs_setxattr_noperm+0x50/0x1a0
> > [49531.320004]  [<ffffffff8116adb8>] ? inode_permission+0xa8/0xd0
> > [49531.320004]  [<ffffffff811822cc>] vfs_setxattr+0xbc/0xc0
> > [49531.320004]  [<ffffffff81182392>] setxattr+0xc2/0x150
> > [49531.320004]  [<ffffffff8114fec0>] ? kmem_cache_free+0x20/0x110
> > [49531.320004]  [<ffffffff8116ae33>] ? putname+0x33/0x50
> > [49531.320004]  [<ffffffff8116ef84>] ? user_path_at+0x64/0xa0
> > [49531.320004]  [<ffffffff815d3493>] ? schedule+0x3d3/0xa00
> > [49531.320004]  [<ffffffff81099c7b>] ? sys_futex+0x7b/0x180
> > [49531.320004]  [<ffffffff811824b5>] sys_setxattr+0x95/0xb0
> > [49531.320004]  [<ffffffff815ddec2>] system_call_fastpath+0x16/0x1b
> 
> Which kernel version is this?  I've only seen this on older (<.26?) 
> kernels.  If this is on the latest, we need to tell the extN guys about 
> it.
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
