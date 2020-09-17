Return-Path: <SRS0=SvUK=C2=vger.kernel.org=ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004E4C43461
	for <ceph-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F3772220A
	for <ceph-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600368877;
	bh=dsrHqCpL2En5vdo8EKO9ihwbSqFxqTvchyF3EQmBx8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IsJxzJMKsRo9Sc1yb6FgL5H/7gAt4ZGf9YvLdsysC+CT0qgqRbjVvzaDHdoVLECOi
	 RcL6F9DxhE13oWipK6xNNa7pLCzityxl9nOMx6k7UeQ+ZEwJ3iXAT80CH87Dl+bw/w
	 RNlqoxb9WqDhO9TtY5blCRtVJSWce+u6zQvag0yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgIQSyb (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728429AbgIQQU3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:20:29 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9F632224A;
        Thu, 17 Sep 2020 15:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600356549;
        bh=dsrHqCpL2En5vdo8EKO9ihwbSqFxqTvchyF3EQmBx8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pLRXIPMU+ebvvDik5sg9LeQLxfPqJ2VfS43CgFM7HSeOTANsZGnTFTJTgezDNSjOp
         JQbxMoBBOjqjx84cP7GtBdk6eGD1U5VV+fNacoBl4rBzEKoFw3oeRWyqZ36HmyXEdw
         DLqkCLEPIBXNzP2ARkC0eEXzCYDCBwGOA5LkiyJw=
Date:   Thu, 17 Sep 2020 08:29:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, ceph-devel@vger.kernel.org,
        Daniel Rosenberg <drosen@google.com>
Subject: Re: [PATCH v3 13/13] fscrypt: make
 fscrypt_set_test_dummy_encryption() take a 'const char *'
Message-ID: <20200917152907.GB855@sol.localdomain>
References: <20200917041136.178600-1-ebiggers@kernel.org>
 <20200917041136.178600-14-ebiggers@kernel.org>
 <41ad3cd50f4d213455bef4e7c42143c289690222.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ad3cd50f4d213455bef4e7c42143c289690222.camel@kernel.org>
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

On Thu, Sep 17, 2020 at 08:32:39AM -0400, Jeff Layton wrote:
> On Wed, 2020-09-16 at 21:11 -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > fscrypt_set_test_dummy_encryption() requires that the optional argument
> > to the test_dummy_encryption mount option be specified as a substring_t.
> > That doesn't work well with filesystems that use the new mount API,
> > since the new way of parsing mount options doesn't use substring_t.
> > 
> > Make it take the argument as a 'const char *' instead.
> > 
> > Instead of moving the match_strdup() into the callers in ext4 and f2fs,
> > make them just use arg->from directly.  Since the pattern is
> > "test_dummy_encryption=%s", the argument will be null-terminated.
> > 
> 
> Are you sure about that? I thought the point of substring_t was to give
> you a token from the string without null terminating it.
> 
> ISTM that when you just pass in ->from, you might end up with trailing
> arguments in your string like this. e.g.:
> 
>     "v2,foo,bar,baz"
> 
> ...and then that might fail to match properly
> in fscrypt_set_test_dummy_encryption.
> 

Yes I'm sure, and I had also tested it.  The use of match_token() here is to
parse one null-terminated mount option at a time.

The reason that match_token() can return multiple substrings is that the pattern
might be something like "foo=%d:%d".

But here it's just "test_dummy_encryption=%s". "%s" matches until end-of-string.

- Eric
