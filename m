From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] ceph: fix ceph_dir_llseek()
Date: Sat, 01 Mar 2014 19:06:55 -0600
Message-ID: <5312842F.9040505@ieee.org>
References: <1393492047-18261-1-git-send-email-zheng.z.yan@intel.com>	<5310978F.2000705@ieee.org> <CAAM7YAk+6jo6x0M3Hm1vxpkGaXVDpCORyWK0Xwa6+23m6j3GsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:44086 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbaCBBHC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 1 Mar 2014 20:07:02 -0500
Received: by mail-pd0-f180.google.com with SMTP id v10so227665pde.39
        for <ceph-devel@vger.kernel.org>; Sat, 01 Mar 2014 17:07:01 -0800 (PST)
In-Reply-To: <CAAM7YAk+6jo6x0M3Hm1vxpkGaXVDpCORyWK0Xwa6+23m6j3GsQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 02/28/2014 06:14 PM, Yan, Zheng wrote:
>>> >>@@ -474,7 +474,7 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
>>> >>  {
>>> >>       struct ceph_file_info *fi = file->private_data;
>>> >>       struct inode *inode = file->f_mapping->host;
>>> >>-     loff_t old_offset = offset;
>>> >>+     loff_t old_offset = ceph_make_fpos(fi->frag, fi->next_offset);
>> >
>> >Should this be named "next_offset" (or maybe "current_offset")?
>> >It doesn't seem "old" to me, though I do realize it doesn't
>> >necessarily represent where the "next" file position will be.
>> >
> No. next_offset is the position where next readdir request will be.

I guess "old_next_offset" is what it is but in any case looking
again I see what you mean now.  Thanks.

					-Alex
