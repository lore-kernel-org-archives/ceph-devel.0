Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E92C433EF
	for <ceph-devel@archiver.kernel.org>; Fri, 27 May 2022 09:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbiE0JUT (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Fri, 27 May 2022 05:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiE0JTv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 27 May 2022 05:19:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B89D6AA6B
        for <ceph-devel@vger.kernel.org>; Fri, 27 May 2022 02:19:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DF24521ABB;
        Fri, 27 May 2022 09:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653643188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Xm3f7DVgbCjnh9rDlNbUh79p5wcM8SKl6fUyoD+KT8=;
        b=w7OlG+qZ/7Z7FZGGWgi4Mc8mgdeZ8L4QG18oV6IF3wCnh3QAt3lgdgNn2cEPDiHvKXuAer
        y3wYuH9W+mOz1PIlrk6IU3SK2McjGZJlBQijZpoPxKFvn6ZuNI4BshcvBTW1Kx7RGkxCEW
        cXLrbai5eY2jNj152PH4K64AG5SjCGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653643188;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Xm3f7DVgbCjnh9rDlNbUh79p5wcM8SKl6fUyoD+KT8=;
        b=vZ3BY8BzFB7X8JzZeSYnG4Xee4pIFIVLMPkk15Qa8Q7k3UFWe5xqJO7O52zV582tZf1Fvb
        gNrMlDuStD3KCmAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 828BA139C4;
        Fri, 27 May 2022 09:19:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nmECHbSXkGJyUAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Fri, 27 May 2022 09:19:48 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id f94cb8bf;
        Fri, 27 May 2022 09:20:27 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Xiubo Li <xiubli@redhat.com>, idryomov@gmail.com,
        vshankar@redhat.com, ceph-devel@vger.kernel.org
Subject: Re: [PATCH] ceph: remove useless CEPHFS_FEATURES_CLIENT_REQUIRED
References: <20220526060721.735547-1-xiubli@redhat.com>
        <afb34ae5b243ccea7e799b45812c47ad6efa0541.camel@kernel.org>
Date:   Fri, 27 May 2022 10:20:27 +0100
In-Reply-To: <afb34ae5b243ccea7e799b45812c47ad6efa0541.camel@kernel.org> (Jeff
        Layton's message of "Thu, 26 May 2022 06:37:24 -0400")
Message-ID: <87czfzwcv8.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> On Thu, 2022-05-26 at 14:07 +0800, Xiubo Li wrote:
>> This macro was added but never be used. And check the ceph code
>> there has another CEPHFS_FEATURES_MDS_REQUIRED but always be empty.
>>=20
>> We should clean up all this related code, which make no sense but
>> introducing confusion.
>>=20
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>  fs/ceph/mds_client.h | 1 -
>>  1 file changed, 1 deletion(-)
>>=20
>> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
>> index 636fcf4503e0..d8ec2ac93da3 100644
>> --- a/fs/ceph/mds_client.h
>> +++ b/fs/ceph/mds_client.h
>> @@ -42,7 +42,6 @@ enum ceph_feature_type {
>>  	CEPHFS_FEATURE_DELEG_INO,		\
>>  	CEPHFS_FEATURE_METRIC_COLLECT,		\
>>  }
>> -#define CEPHFS_FEATURES_CLIENT_REQUIRED {}
>>=20=20
>>  /*
>>   * Some lock dependencies:
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Yep, this makes sense.

Reviewed-by: Lu=C3=ADs Henriques <lhenriques@suse.de>

Cheers,
--=20
Lu=C3=ADs
