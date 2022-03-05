Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7B3C433EF
	for <ceph-devel@archiver.kernel.org>; Sat,  5 Mar 2022 14:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiCEOaj (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Sat, 5 Mar 2022 09:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiCEOai (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Mar 2022 09:30:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA69BD3;
        Sat,  5 Mar 2022 06:29:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6F2EB1F38D;
        Sat,  5 Mar 2022 14:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646490587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R9AM/TM9vZ0PBfzZKsGMayiREwVYLiWXLX6JUe18Ioo=;
        b=zT7YUIu8+/PlQ+AkHY+XvRVewjef/NzD8pDkMFsAuasBtzOpoO/vvYqBWw/Vs2Mm1GZJ3U
        Ylin//RAeim0n6VTlHZ6WWMbs85yDC1VtgAyL0RnkXnEd0HGXDiCSo6QliJeenniHw9RNB
        E2LLF4AL8Yjujmt1+68kLkr5R85pR44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646490587;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R9AM/TM9vZ0PBfzZKsGMayiREwVYLiWXLX6JUe18Ioo=;
        b=JeLnDPHa7Lt5RsNXFiEfnaJsbb0pjjVdKfS7TdW4fkGaSyugHoL+AXvFB0aABdv+tdSFuO
        QUxx9OQvDuPVHeDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1938D13519;
        Sat,  5 Mar 2022 14:29:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3ikbA9tzI2JyWQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Sat, 05 Mar 2022 14:29:47 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id b8123a79;
        Sat, 5 Mar 2022 14:30:03 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ceph: fix error path in ceph_readdir()
References: <20220304161403.19295-1-lhenriques@suse.de>
        <20220304161403.19295-2-lhenriques@suse.de>
        <fbf5211f69b5cda372c90d78c6aeee00524fcfbf.camel@kernel.org>
Date:   Sat, 05 Mar 2022 14:30:02 +0000
In-Reply-To: <fbf5211f69b5cda372c90d78c6aeee00524fcfbf.camel@kernel.org> (Jeff
        Layton's message of "Fri, 04 Mar 2022 13:17:24 -0500")
Message-ID: <87lexoo4k5.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> On Fri, 2022-03-04 at 16:14 +0000, Lu=C3=ADs Henriques wrote:
>> This was introduced by commit
>>=20
>>   "ceph: add support to readdir for encrypted filenames"
>>=20
>> It will eventually leak the fscrypt_str names in this error path.
>>=20
>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
>> ---
>>  fs/ceph/dir.c | 1 -
>>  1 file changed, 1 deletion(-)
>>=20
>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>> index 44395aae7259..0bcb677d2199 100644
>> --- a/fs/ceph/dir.c
>> +++ b/fs/ceph/dir.c
>> @@ -500,7 +500,6 @@ static int ceph_readdir(struct file *file, struct di=
r_context *ctx)
>>  					       next_offset);
>>  			if (err) {
>>  				ceph_mdsc_put_request(dfi->last_readdir);
>> -				return err;
>>  				goto out;
>>  			}
>>  		} else if (req->r_reply_info.dir_end) {
>
> This doesn't seem to apply to the current wip-fscrypt tree. Are you
> working against an older branch, perhaps?

I thought I was on an up-to-date branch but obviously I was wrong.  I'll
rebase the patches.  Sorry.

Cheers,
--=20
Lu=C3=ADs

>
> --=20
> Jeff Layton <jlayton@kernel.org>
