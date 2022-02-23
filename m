Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E9EC433F5
	for <ceph-devel@archiver.kernel.org>; Wed, 23 Feb 2022 12:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbiBWMpe (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 23 Feb 2022 07:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbiBWMpd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Feb 2022 07:45:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E7CA2513
        for <ceph-devel@vger.kernel.org>; Wed, 23 Feb 2022 04:45:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A893E61362
        for <ceph-devel@vger.kernel.org>; Wed, 23 Feb 2022 12:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A74AC340E7;
        Wed, 23 Feb 2022 12:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645620305;
        bh=/Xee7qUauRaTrajkB+fVodPLzLEk3vYSQiwq4b4s6mE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=N4QgR95lQgczrstca91tsAK9GU7JNl25Iu9vGtVh3MwwZknYjbji4N3XhisjX/+ow
         vIdELcqXtDu6JKRZ7H2Zm1rZ7xUUk/j9b7jAAbz8b21esKZsJ7leO5kEAHUy+T5PUF
         JTQGScfnwt/fsuJ+AdNo/xAwrDewquKoxO1t30hmUNpkg3m9bwMKlbNgKGEJ1rKPDU
         WFviBEbKC9/jIzs2SdspAf3w/jFyJSybs/sDqUXjbU94bQrxEJ8RC4OcpnUVfO0Ft7
         u5Dnlp8VZZZm/VaogyM+eapaAzV65OxP1a6TfPe+W9VFAE60S4TKs9A84Q4KcZVhf9
         WwEaX0oGdxhJw==
Message-ID: <f807d43f25bd1c06ac12a4413f92651e88f523f3.camel@kernel.org>
Subject: Re: [PATCH v2 0/2] ceph: create the global dummy snaprealm once
From:   Jeff Layton <jlayton@kernel.org>
To:     xiubli@redhat.com
Cc:     idryomov@gmail.com, vshankar@redhat.com, ceph-devel@vger.kernel.org
Date:   Wed, 23 Feb 2022 07:45:03 -0500
In-Reply-To: <20220223010456.267425-1-xiubli@redhat.com>
References: <20220223010456.267425-1-xiubli@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Wed, 2022-02-23 at 09:04 +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> V2:
> - Fixed code style issue.
> 
> Xiubo Li (2):
>   ceph: remove incorrect and unused CEPH_INO_DOTDOT macro
>   ceph: do not release the global snaprealm until unmounting
> 
>  fs/ceph/mds_client.c         |  2 +-
>  fs/ceph/snap.c               | 13 +++++++++++--
>  fs/ceph/super.h              |  2 +-
>  include/linux/ceph/ceph_fs.h |  4 ++--
>  4 files changed, 15 insertions(+), 6 deletions(-)
> 

Reviewed-by: Jeff Layton <jlayton@kernel.org>
