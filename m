Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2677C433EF
	for <ceph-devel@archiver.kernel.org>; Tue, 19 Apr 2022 13:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348491AbiDSN0T (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 19 Apr 2022 09:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiDSN0S (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Apr 2022 09:26:18 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9D613CCF
        for <ceph-devel@vger.kernel.org>; Tue, 19 Apr 2022 06:23:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BB8A2CE1905
        for <ceph-devel@vger.kernel.org>; Tue, 19 Apr 2022 13:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47535C385A5;
        Tue, 19 Apr 2022 13:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650374610;
        bh=2CO/aJsJ+cpL/2jTGTkSrxaCpdH/5fWXlIUqYpIN1eI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=D15e3UShQ/szNJBpRShFu1qIWeGMSnml51kxTaOI9pTqYV+ykg5ufmifvKO4lEQvB
         AF8E7PdoasM6D71jxJpvp26LZL2eFZ+OjDKZ1f7KZz96XtPUoMFRXktE4KSXmG2j1F
         Li5FOMOhL/e6Gz7XIwElzE8DYv8/SRHeXx1dWpNGt2o47vwFKr/PdR3vY59/xdgwZV
         2ELysvEcP5sAfnaBlekBNx4+Xm9/mfiqFClVGITrsaTOl8RlKhiAL/UM7xNiY5Sb/X
         zh3ON0ySSOaeLv/ETLTACq+cAEmcjHWLsweV/5M8K9itiFI3jhYEoDIj/XTJmF7dKY
         XAfs2yhncAEhw==
Message-ID: <d873b14bc110c98f8c62cfabafc30a7d942e3064.camel@kernel.org>
Subject: Re: [RFC resend PATCH] ceph: fix statx AT_STATX_DONT_SYNC vs
 AT_STATX_FORCE_SYNC check
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Xiubo Li <xiubli@redhat.com>, idryomov@gmail.com,
        vshankar@redhat.com, ceph-devel@vger.kernel.org
Date:   Tue, 19 Apr 2022 09:23:28 -0400
In-Reply-To: <458688.1650374525@warthog.procyon.org.uk>
References: <54d0b7f67cc1c8302fc2d4ff6109d0090f6a4220.camel@kernel.org>
         <20220411093405.301667-1-xiubli@redhat.com>
         <c013aafd233d4ec303238425b11f6c96c8a3b7a7.camel@kernel.org>
         <b38b37bc-faa7-cbae-ce3a-f10c0818a293@redhat.com>
         <d57a0fd93e18d065a0deb3c82dc43595e67b2326.camel@kernel.org>
         <d81b7216-2694-4ec2-17b4-0869f485f757@redhat.com>
         <458688.1650374525@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Tue, 2022-04-19 at 14:22 +0100, David Howells wrote:
> Jeff Layton <jlayton@kernel.org> wrote:
> 
> >     if ((flags & AT_STATX_SYNC_TYPE) == (AT_STATX_DONT_SYNC|AT_STATX_FORCE_SYNC))
> 
> You can't do that.  DONT_SYNC and FORCE_SYNC aren't bit flags - they're an
> enumeration in a bit field.  There's a reserved value at 0x6000 that doesn't
> have a symbol assigned.
> 

Right, but nothing prevents you from setting both flags at the same
time. How should we interpret such a request?

-- 
Jeff Layton <jlayton@kernel.org>
