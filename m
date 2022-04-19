Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0055BC433F5
	for <ceph-devel@archiver.kernel.org>; Tue, 19 Apr 2022 10:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350653AbiDSK1H (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 19 Apr 2022 06:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiDSK1F (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Apr 2022 06:27:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885282715C;
        Tue, 19 Apr 2022 03:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DE437CE16E1;
        Tue, 19 Apr 2022 10:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD56C385A9;
        Tue, 19 Apr 2022 10:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650363860;
        bh=WogFCl5YvXCp9/83pBhpYQ642Sy3Wgxac13aDcP1R+Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qVrvq19J5yB33n1k0dQhgakp1jbxdY4hHZa5WDrDXd4PB0BLWI4xOLJ44bi6frEzO
         WhaHyjl+SUf3kSytHTsIvt3NSaygtaHp8M+wa7i+yP4NeWjbomf7bDFWi3QujSP+Tk
         0Frt+sIfx3ZKAWNq3peH0IaetjkZYWrpSGXHGse1TE3YB3YkRdTzqqLDdwtgmfns6G
         rFxgUdCMUsDzvf5QZLa5FMZ54cF9Q9cG7/7NH8gcIL8pO6SiSQQbJQc0TU+G/LkZCY
         MaCFf8z/2VK2vhI4QDfKE3peMQv38L01O8Z3s5hktaxXAtKtWSCtCjiBeOcEAJIgBF
         ZuIjWHqtgDQuw==
Message-ID: <0effd60f4f6add28b837aa75e62a5f6e0fe30f88.camel@kernel.org>
Subject: Re: [PATCH] ceph: fix compilation error when building kernel
 without FS_ENCRYPT
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Date:   Tue, 19 Apr 2022 06:24:18 -0400
In-Reply-To: <20220419084937.3199-1-lhenriques@suse.de>
References: <20220419084937.3199-1-lhenriques@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Tue, 2022-04-19 at 09:49 +0100, Luís Henriques wrote:
> When compiling without FS_ENCRYPTION config, the kernel will fail to build
> with:
> 
> fs/ceph/inode.c:196:7: error: no member named 'fscrypt_auth' in 'struct ceph_inode_info'
> 
> Enclose the code within an #ifdef CONFIG_FS_ENCRYPTION to fix it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  fs/ceph/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> Jeff, feel free to squash this patch into one of the previous patches from
> the snapshot names encryption series.
> 
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 636e4e0a9dc6..5de7bb9048b7 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -189,6 +189,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>  	ci->i_rbytes = 0;
>  	ci->i_btime = ceph_inode(parent)->i_btime;
>  
> +#ifdef CONFIG_FS_ENCRYPTION
>  	/* if encrypted, just borrow fscrypt_auth from parent */
>  	if (IS_ENCRYPTED(parent)) {
>  		struct ceph_inode_info *pci = ceph_inode(parent);
> @@ -205,6 +206,7 @@ struct inode *ceph_get_snapdir(struct inode *parent)
>  			goto err;
>  		}
>  	}
> +#endif
>  	if (inode->i_state & I_NEW) {
>  		inode->i_op = &ceph_snapdir_iops;
>  		inode->i_fop = &ceph_snapdir_fops;

Thanks, I folded this one into this patch:

    ceph: add support for encrypted snapshot names

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>
