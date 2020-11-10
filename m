Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A514EC388F7
	for <ceph-devel@archiver.kernel.org>; Tue, 10 Nov 2020 14:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B17420797
	for <ceph-devel@archiver.kernel.org>; Tue, 10 Nov 2020 14:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RD6npOS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgKJOAd (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 10 Nov 2020 09:00:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJOAb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:00:31 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD7A120797;
        Tue, 10 Nov 2020 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605016831;
        bh=asHKAJd5k7NTZTT0k9tCSQr28iQKi6Cdsn0/dBrChQ4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RD6npOS3tXsjnEHbVHeMpgEw4j3F1v8EY3enp/Ym1e6UJ1CZrvUNMpy/vpXbjGof7
         ZsThixMYKqaXC4kfCCZwuwkTzwsX/0vWGQrB/Dpwdgnyx7d7kynQDB6nzX71k0qMqq
         NgJXjCtbAU6CujIY3bJ/WCgDy2m8vbG6k/EsItGA=
Message-ID: <d8de425bc32a5d26c48494ef71fa93c2c60a9a2c.camel@kernel.org>
Subject: Re: [PATCH] libceph: remove unused defined macro for port
From:   Jeff Layton <jlayton@kernel.org>
To:     changcheng.liu@intel.com, idryomov@gmail.com
Cc:     ceph-devel@vger.kernel.org
Date:   Tue, 10 Nov 2020 09:00:29 -0500
In-Reply-To: <20201110135201.GA90549@nstpc>
References: <20201110135201.GA90549@nstpc>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Tue, 2020-11-10 at 21:52 +0800, changcheng.liu@intel.com wrote:
> 1. monitor's default port is defined by CEPH_MON_PORT
> 2. CEPH_PORT_START & CEPH_PORT_LAST are not needed.
> 
> Signed-off-by: Changcheng Liu <changcheng.liu@aliyun.com>
> 
> diff --git a/include/linux/ceph/msgr.h b/include/linux/ceph/msgr.h
> index 1c1887206ffa..feff5a2dc33e 100644
> --- a/include/linux/ceph/msgr.h
> +++ b/include/linux/ceph/msgr.h
> @@ -7,15 +7,6 @@
>  
> 
>  #define CEPH_MON_PORT    6789  /* default monitor port */
>  
> 
> -/*
> - * client-side processes will try to bind to ports in this
> - * range, simply for the benefit of tools like nmap or wireshark
> - * that would like to identify the protocol.
> - */
> -#define CEPH_PORT_FIRST  6789
> -#define CEPH_PORT_START  6800  /* non-monitors start here */
> -#define CEPH_PORT_LAST   6900
> -
>  /*
>   * tcp connection banner.  include a protocol version. and adjust
>   * whenever the wire protocol changes.  try to keep this string length

Thanks! Merged into testing branch.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

