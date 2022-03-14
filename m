Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2946DC433EF
	for <ceph-devel@archiver.kernel.org>; Mon, 14 Mar 2022 18:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241843AbiCNSjo (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Mon, 14 Mar 2022 14:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiCNSjl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Mar 2022 14:39:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9C52AD1
        for <ceph-devel@vger.kernel.org>; Mon, 14 Mar 2022 11:38:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93744B80F63
        for <ceph-devel@vger.kernel.org>; Mon, 14 Mar 2022 18:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB98C340E9;
        Mon, 14 Mar 2022 18:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647283108;
        bh=Y/WZMnaOBYhYLvFEyc+qjHfiSLp2YlIZS8B7t3w2ZGI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=m+47GBEi3zQdAZ8oMxyJ2fiGUmbERcz2T0r7LA8nIHEvUvciMcfxFa4SRAzzODw4t
         0uMQhJBWD8yPNs1vOfvyCB72aarU2cBOh6h0UG+wBRIebdYXb4i3iIJgarGFrAw6VR
         8HrXIIBraklwMYVOdqSJqtaVqjuHQ/OZAwHw7Rae8UkpMb5sqy4LNQfjMPmnvoni0e
         yZI6mzy7XCe6MWSr4lhgQZt+c7VSwCtNpzL7L4ugDqQS6uk/10GlOQX4REowd28bUt
         CHbkWuRxXrwNupu0C05xi+tS7rj0gkIDRY59Sv5b+tGMPW2X6CICjqv2LsBEgZexZq
         SToafnhve22cA==
Message-ID: <6310d5de6cc441b07eb8144aab1c3c0fe3739e5a.camel@kernel.org>
Subject: Re: [PATCH v2 0/4] ceph: dencrypt the dentry names early and once
 for readdir
From:   Jeff Layton <jlayton@kernel.org>
To:     xiubli@redhat.com
Cc:     idryomov@gmail.com, vshankar@redhat.com, lhenriques@suse.de,
        ceph-devel@vger.kernel.org
Date:   Mon, 14 Mar 2022 14:38:26 -0400
In-Reply-To: <20220314022837.32303-1-xiubli@redhat.com>
References: <20220314022837.32303-1-xiubli@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Mon, 2022-03-14 at 10:28 +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> This is a new approach to improve the readdir and based the previous
> discussion in another thread:
> 
> https://patchwork.kernel.org/project/ceph-devel/list/?series=621901
> 
> Just start a new thread for this.
> 
> As Jeff suggested, this patch series will dentrypt the dentry name
> during parsing the readdir data in handle_reply(). And then in both
> ceph_readdir_prepopulate() and ceph_readdir() we will use the
> dencrypted name directly.
> 
> NOTE: we will base64_dencode and dencrypt the names in-place instead
> of allocating tmp buffers. For base64_dencode it's safe because the
> dencoded string buffer will always be shorter.
> 
> 
> V2:
> - Fix the WARN issue reported by Luis, thanks.
> 
> 
> Xiubo Li (4):
>   ceph: pass the request to parse_reply_info_readdir()
>   ceph: add ceph_encode_encrypted_dname() helper
>   ceph: dencrypt the dentry names early and once for readdir
>   ceph: clean up the ceph_readdir() code
> 
>  fs/ceph/crypto.c     |  25 ++++++++---
>  fs/ceph/crypto.h     |   2 +
>  fs/ceph/dir.c        |  64 +++++++++------------------
>  fs/ceph/inode.c      |  37 ++--------------
>  fs/ceph/mds_client.c | 101 ++++++++++++++++++++++++++++++++++++-------
>  fs/ceph/mds_client.h |   4 +-
>  6 files changed, 133 insertions(+), 100 deletions(-)
> 

This looks good, Xiubo. I did some testing with these earlier and they
seemed to work great.

I've gone ahead and merged these into the wip-fscrypt branch. It may be
best to eventually squash these down, but it's probably fine to leave
them on top as well.

Thanks!  
-- 
Jeff Layton <jlayton@kernel.org>
