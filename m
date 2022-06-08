Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46310C433EF
	for <ceph-devel@archiver.kernel.org>; Wed,  8 Jun 2022 10:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiFHKLv (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 8 Jun 2022 06:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbiFHKLL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jun 2022 06:11:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBB610FD2;
        Wed,  8 Jun 2022 02:56:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2DCB721BB0;
        Wed,  8 Jun 2022 09:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1654682201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=otIikhj1I7OO0jp5LB/nnTLTaJqx/zAzkWvWPuTXuKs=;
        b=MDIAeKL7WbceJkDQfeZjLpKeU/uMXvCBOIIywJN5E7gkF8T9/ftolW+ZQ8cFBCQf5amxOU
        CTCEnHBPoBMez1+rUEwj81YGRIQandz3mgH5QBF326N/IIYSIYaRseHaU+7Y9QMwq2DppC
        6FGXF9yUdSP3P7EjAjdbYitqj74CJ0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1654682201;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=otIikhj1I7OO0jp5LB/nnTLTaJqx/zAzkWvWPuTXuKs=;
        b=+7glBNfmHGqFM4FJahY9c/+tc6tfYAGT4crsW4nc2/9O6yiTNGGI8smK/+lvxRprkHjY5c
        Nom+NXhkARJtQkBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD33313A15;
        Wed,  8 Jun 2022 09:56:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B6Q9K1hyoGLlbwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 08 Jun 2022 09:56:40 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 5c10a013;
        Wed, 8 Jun 2022 09:57:22 +0000 (UTC)
Date:   Wed, 8 Jun 2022 10:57:22 +0100
From:   =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org
Subject: Re: [PATCH 2/2] src/attr_replace_test: dynamically adjust the max
 xattr size
Message-ID: <YqByggmCzXGAosM+@suse.de>
References: <20220607151513.26347-1-lhenriques@suse.de>
 <20220607151513.26347-3-lhenriques@suse.de>
 <20220608002315.GT1098723@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220608002315.GT1098723@dread.disaster.area>
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Wed, Jun 08, 2022 at 10:23:15AM +1000, Dave Chinner wrote:
> On Tue, Jun 07, 2022 at 04:15:13PM +0100, Luís Henriques wrote:
> > CephFS doesn't had a maximum xattr size.  Instead, it imposes a maximum
> > size for the full set of an inode's xattrs names+values, which by default
> > is 64K but it can be changed by a cluster admin.
> > 
> > Test generic/486 started to fail after fixing a ceph bug where this limit
> > wasn't being imposed.  Adjust dynamically the size of the xattr being set
> > if the error returned is -ENOSPC.
> 
> Ah, this shouldn't be getting anywhere near the 64kB limit unless
> ceph is telling userspace it's block size is > 64kB:
> 
> size = sbuf.st_blksize * 3 / 4;
> .....
> size = MIN(size, XATTR_SIZE_MAX);

Yep, that's exactly what is happening.  The cephfs kernel client reports
here the value that is being used for ceph "object size", which defaults
to 4M.  Hence, we'll set size to XATTR_SIZE_MAX.

> Regardless, the correct thing to do here is pass the max supported
> xattr size from the command line (because fstests knows what that it
> for each filesystem type) rather than hard coding
> XATTR_SIZE_MAX in the test.

OK, makes sense.  But then, for the ceph case, it becomes messy because we
also need to know the attribute name to compute the maximum size.  I guess
we'll need an extra argument for that too.

Cheers,
--
Luís
