Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E33AC4167B
	for <ceph-devel@archiver.kernel.org>; Wed,  6 Apr 2022 04:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449898AbiDFEPy (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 6 Apr 2022 00:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573208AbiDESR5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2022 14:17:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0084EF087;
        Tue,  5 Apr 2022 11:15:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54562B81F75;
        Tue,  5 Apr 2022 18:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084D6C385A4;
        Tue,  5 Apr 2022 18:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649182555;
        bh=grVOlI0gDn9zG4TjD5iKDe9tR2JypV1oh7YQii31Iuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fnkvmzqbb0B/XQwwWGVpd59Ws2GnuaDI1TiSd1CW9rRk0TSfLtInY+/ECFhOFXwL7
         PLNgWV85mznPUOvgJKyQs8KCgigWtMOIF4TmxmDvBAJSqoiPTTcQLrFeEMfyuB6erY
         kpY3ZCMR6DA0pQLwO1SnMADaEC2/i9s/OSysv5Sw0HzqDxNmx5/LXs+y0c7tFJdWUr
         qfSAB8j8mbh8j/PhI7w8p8yBGzVdN4+XdQFJeC2HGyIIleMWWpX9AGvVStrJpLfehG
         8PYSHD/vFFqGZnOpNv4bZD+SqonrKNj5BUcNanM3TdIBx6Hq2oB9Nhpj2FSKNN4MYe
         B/X2Px+NNAjSQ==
Date:   Tue, 5 Apr 2022 18:15:53 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH v3] common/encrypt: allow the use of 'fscrypt:' as key
 prefix
Message-ID: <YkyHWXKySNU00XB6@gmail.com>
References: <20220405094633.17285-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220405094633.17285-1-lhenriques@suse.de>
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Tue, Apr 05, 2022 at 10:46:33AM +0100, Luís Henriques wrote:
> fscrypt keys have used the $FSTYP as prefix.  However this format is being
> deprecated and newer kernels are expected to use the generic 'fscrypt:'
> prefix instead.  This patch adds support for this new prefix, and only
> uses $FSTYP on filesystems that didn't initially supported it, i.e. ext4 and
> f2fs.  This will allow old kernels to be tested.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  common/encrypt | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
