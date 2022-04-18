Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818F7C47080
	for <ceph-devel@archiver.kernel.org>; Mon, 18 Apr 2022 14:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242151AbiDROZu (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 18 Apr 2022 10:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344381AbiDROU6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Apr 2022 10:20:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80492DD49;
        Mon, 18 Apr 2022 06:17:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65647B80D9C;
        Mon, 18 Apr 2022 13:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F3BC385A7;
        Mon, 18 Apr 2022 13:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650287836;
        bh=UQN6nyUsWvECSwrI29dTKr5hYwn2QwUdm3cJIU+mU8Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Jw7/vKOBPXaEiUGFi00wQQEVzScIeMnHjORhJmwNTjPabVOR715Aeo+ny75k4cEw3
         AczUIt22Gn9OehYi7o/q2laBzt0AH9gvYEgXKX9rMmXsL/FvTq3I4RlnRTjnOHPQBR
         UERjo/3rtU9Pxp09wIRQ+ZuxUCX4EuJ4unx2o2ZfQVFXMcH0qBJhjCiJsjl3HsnpkU
         mJ0z6qzCnC9qJlaZJa9lDXIUt84HXSbLW5cQwRlL1WkpOZgbp27d58zwiGCZu8+ly7
         DrY760wsICYfcllGoDOvN25E/mBsTuM3O3g+UtXOg/EVj9MB+vpMF++8IszwtmcnXH
         slYQI48DnBR/g==
Message-ID: <0c5c361c6d65f5b2fdb1dc89fd4317f22cbc3e74.camel@kernel.org>
Subject: Re: [PATCH] ceph: prevent snapshots to be created in encrypted
 locked directories
From:   Jeff Layton <jlayton@kernel.org>
To:     =?ISO-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Apr 2022 09:17:14 -0400
In-Reply-To: <20220418130839.9862-1-lhenriques@suse.de>
References: <20220414135122.26821-1-lhenriques@suse.de>
         <20220418130839.9862-1-lhenriques@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Mon, 2022-04-18 at 14:08 +0100, Luís Henriques wrote:
> With snapshot names encryption we can not allow snapshots to be created in
> locked directories because the names wouldn't be encrypted.  This patch
> forces the directory to be unlocked to allow a snapshot to be created.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  fs/ceph/dir.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index f48f1ff20927..93e2f08102a1 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -1071,6 +1071,10 @@ static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
>  		err = -EDQUOT;
>  		goto out;
>  	}
> +	if ((op == CEPH_MDS_OP_MKSNAP) && !fscrypt_has_encryption_key(dir)) {
> +		err = -ENOKEY;
> +		goto out;
> +	}
>  
>  
>  	req = ceph_mdsc_create_request(mdsc, op, USE_AUTH_MDS);

Looks good. I'll pull this and the v4 series into the wip-fscrypt later
todat.  
-- 
Jeff Layton <jlayton@kernel.org>
