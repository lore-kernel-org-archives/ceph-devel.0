Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FAEC4332F
	for <ceph-devel@archiver.kernel.org>; Tue,  8 Mar 2022 13:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiCHN3X (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 8 Mar 2022 08:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiCHN3U (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Mar 2022 08:29:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788EF37024;
        Tue,  8 Mar 2022 05:28:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03D7E60F66;
        Tue,  8 Mar 2022 13:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F12C340EE;
        Tue,  8 Mar 2022 13:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646746103;
        bh=vLq6o5KFjM+xxxj4pQVBgaPRU8ME2c8zMC45ZcGJzWE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Lo/N/H9+H+Po5LmWyPErVO98Xe9lqYkXwZtrkxV5O9OKh5jI2HaAl5fUlRXKGT78T
         /bkIbi8GyJTX8GoMNDQIK0QGX/Lt6DtrqaczNVlvbySxTrE6XdPpDpTMwGNjOuIdSF
         kxME36puEa4ksCRr9IvExtKwHjp/phY4kLfX/2Yv9kSMYFFtVbGWogiNB1M8sTaF2O
         ikxFo5G/6vh11AKjumiObHHVOfqbXNANqptebBlR2RNnHD373q5G9aMjMfaK2KC+iT
         K5fCQHjHinNu1jqAEW6S/0bw58bn6Zf8o4wygJHQ3pv6IZGDwIPPnaJwG03QXwHtNC
         uri11W6weTivQ==
Message-ID: <1b892ba94ba4fe23b80fdfe29c92fdcde35e0b5a.camel@kernel.org>
Subject: Re: [PATCH] ceph: uninitialized variable in debug output
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Tue, 08 Mar 2022 08:28:21 -0500
In-Reply-To: <dae26bb75c456e50b196f41966807d05e92b19ff.camel@kernel.org>
References: <20220307142121.GB19660@kili>
         <1019938.1646732163@warthog.procyon.org.uk>
         <dae26bb75c456e50b196f41966807d05e92b19ff.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Tue, 2022-03-08 at 08:24 -0500, Jeff Layton wrote:
> On Tue, 2022-03-08 at 09:36 +0000, David Howells wrote:
> > Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > 
> > > +	u64 inline_version = -1;
> > 
> > ULLONG_MAX?
> > 
> > David
> > 
> 
> ...or maybe CEPH_INLINE_NONE, which is:
> 
>     #define CEPH_INLINE_NONE        ((__u64)-1)      
>                                                    

I went ahead and merged the patch into our testing branch, with the
change to use CEPH_INLINE_NONE instead.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>
