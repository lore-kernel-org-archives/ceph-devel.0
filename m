Return-Path: <ceph-devel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD21C04A6A
	for <ceph-devel@archiver.kernel.org>; Fri,  4 Aug 2023 14:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjHDOz1 (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 4 Aug 2023 10:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjHDOz0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Aug 2023 10:55:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B4049C6;
        Fri,  4 Aug 2023 07:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78C8E62035;
        Fri,  4 Aug 2023 14:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196D2C433C8;
        Fri,  4 Aug 2023 14:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691160924;
        bh=2Ivc8Vn1B8ZWzdg/GZYCn7onHAAio/R4XF3RMeSuWaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G5FKz1OnRNFTS8NC6wY/FOhvZUCbxe7uy38I/ufJzUvcdMCh8w1IfizgzXAvs+Vre
         jBCcYNZ35EoNt+wDIZXx1aLcQi/oaw+HAGzjNajfELrYgqejlm4XTikEWzBXQtkEnX
         iaJORxXm3qOzTUBNds1Nlhoy2t6Byj5U6ZpAddZqiF9OPFqfD5JMYqXZqkJHoBWNYo
         9v6lspeRMBn7WhLEpsWlAiD/0JymRX1OB1E3xSwLiYvGoFGMeK3SKlG39i80prn41n
         a/4tTjFEb057SHgKCWqenjBVYkskicaLYuaFzfOI+sauGu4+XsL2ky3AXfEeqT7iVc
         3HomJiDeJuKsw==
Date:   Fri, 4 Aug 2023 16:55:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     xiubli@redhat.com, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 08/12] ceph: pass idmap to __ceph_setattr
Message-ID: <20230804-loslegen-besser-e214bb74889c@brauner>
References: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
 <20230804084858.126104-9-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230804084858.126104-9-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Fri, Aug 04, 2023 at 10:48:54AM +0200, Alexander Mikhalitsyn wrote:
> Just pass down the mount's idmapping to __ceph_setattr,
> because we will need it later.
> 
> Cc: Xiubo Li <xiubli@redhat.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: brauner@kernel.org

Cc: Christian Brauner <brauner@kernel.org>

> Cc: ceph-devel@vger.kernel.org
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>
