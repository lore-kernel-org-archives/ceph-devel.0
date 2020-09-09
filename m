Return-Path: <SRS0=Tper=CS=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B48C43461
	for <ceph-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2232166E
	for <ceph-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599669676;
	bh=6bHSGVAzJ/0ZNGfqhYFCU17L0fZcIXLFlFJHUEqQMnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=meNcqJSCaxBemzm11FySOC2+3HpHdTArCLloe1GkA8sL8kjtXA/kkR9L9Ss5kRiO0
	 a340ktfuWLgRSue/8e8+L5OHKkwU1KNp3oQkabpa6agndwPtAg8R4oGmRdUkH6jrzQ
	 HHlEtO5R+NNyxIRFh7hI4s88FEf4JWvOPwxyNJVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgIIQVk (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:21:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730154AbgIIQT6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:19:58 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E609206A2;
        Wed,  9 Sep 2020 16:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599668307;
        bh=6bHSGVAzJ/0ZNGfqhYFCU17L0fZcIXLFlFJHUEqQMnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zhAiRvDolhF1Zq87f78XPyTqHtCUFsJiWcl1hG70Bm3J8L4DTrFRbuGYH4cd+vWKf
         N+RUn0kckatA23+wcT0LQcVpi98e6eaon0hITzLuo5X+tTKujdMHI7weTd2Evcl3/w
         7t7VAL6jNC7CMduyyTiCxe9DDdPZ2z7HnzeERIDk=
Date:   Wed, 9 Sep 2020 09:18:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v2 15/18] ceph: make d_revalidate call fscrypt
 revalidator for encrypted dentries
Message-ID: <20200909161825.GB828@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
 <20200904160537.76663-16-jlayton@kernel.org>
 <20200908051238.GM68127@sol.localdomain>
 <393b410e192986bdf4eb01d4d96a348c7e0e737f.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <393b410e192986bdf4eb01d4d96a348c7e0e737f.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Wed, Sep 09, 2020 at 08:26:51AM -0400, Jeff Layton wrote:
> On Mon, 2020-09-07 at 22:12 -0700, Eric Biggers wrote:
> > On Fri, Sep 04, 2020 at 12:05:34PM -0400, Jeff Layton wrote:
> > > If we have an encrypted dentry, then we need to test whether a new key
> > > might have been established or removed. Do that before we test anything
> > > else about the dentry.
> > 
> > A more accurate explanation would be:
> > 
> > "If we have a dentry which represents a no-key name, then we need to test
> >  whether the parent directory's encryption key has since been added."
> > 
> 
> Can't a key also be removed (e.g. fscrypt lock /path/to/dir)?
> 
> Does that result in the dentries below that point being invalidated?

It results in the dentries (and inodes) being evicted, not invalidated.
See try_to_lock_encrypted_files() in fs/crypto/keyring.c.

So, fscrypt_d_revalidate() doesn't need to consider key removal.

- Eric
