Return-Path: <ceph-devel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1D8EB64D9
	for <ceph-devel@archiver.kernel.org>; Tue, 27 Jun 2023 16:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjF0QSh (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 27 Jun 2023 12:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjF0QS3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jun 2023 12:18:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0282D6D;
        Tue, 27 Jun 2023 09:18:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FFB660FFB;
        Tue, 27 Jun 2023 16:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6EEC433C0;
        Tue, 27 Jun 2023 16:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687882707;
        bh=XppdZpUuGPfDiV8/12odDlU2ubSnA32BV8wWtFnFFqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t57IfEl6+hTqjabvXA+7xzNJ5Ob89MhZc6R+CWuDOGQEcHoTc9pEc9+gNZaYkmgYP
         P5EKcXLxr8vCzPkGLpSNmqscVfIXyi03ZUK8U+bi01/lewGKSxT5OZzKJKbozInkGs
         UrlzdzA3dNHXTTTURoFGfxZyQ3xKel4PK8I29Eu4Dd8rySARubVrofsII3dgnIxHjj
         r+6oHR+RIrOiMbsr0UmMyPibo4iKZrXU9v9j8y6lwyzOK4WYrUu3cBuQpwTWxbWpiT
         876y9awkKG6cx4PYLqDt9ftXs/BUq0ikeij/JRBthkcy0JgAp9E7bAr41rK30oVuzG
         htleCZFQ89Vtg==
Date:   Tue, 27 Jun 2023 09:18:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] libceph: Partially revert changes to
 support MSG_SPLICE_PAGES
Message-ID: <20230627091826.29d397f4@kernel.org>
In-Reply-To: <CAOi1vP-ogmcKE3brjEsm+zLvcXJa_5tGjv_XMsrnZuZUhXonhQ@mail.gmail.com>
References: <3199652.1687873788@warthog.procyon.org.uk>
        <20230627085928.6569353e@kernel.org>
        <CAOi1vP-ogmcKE3brjEsm+zLvcXJa_5tGjv_XMsrnZuZUhXonhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Tue, 27 Jun 2023 18:08:19 +0200 Ilya Dryomov wrote:
> This patch looks good to me.  I have been meaning to actually test
> it, but, if time is of the essence, I'm OK with it being merged via
> the networking tree now.
> 
> Reviewed-by: Ilya Dryomov <idryomov@gmail.com>

Thank you!!
