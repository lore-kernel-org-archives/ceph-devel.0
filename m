Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB330C433F5
	for <ceph-devel@archiver.kernel.org>; Wed,  2 Mar 2022 16:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243579AbiCBQ6m (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 2 Mar 2022 11:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243571AbiCBQ6j (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2022 11:58:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45A524BF9
        for <ceph-devel@vger.kernel.org>; Wed,  2 Mar 2022 08:57:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 943F3219A5;
        Wed,  2 Mar 2022 16:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646240273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAjgo+3jQG/NSIcaPjKqnrupczEVkOcmUVUYDpcRKBc=;
        b=gTGjuYWpv5nHO3Ine0eSyXJupreWG6hby9DTjSezK6JtGfDHmR30FoRoDrS43bQEsrQNWc
        h/pckf/ntBMb1HVmZ1emrOVNdE0I7rkppssJHuR1IcfdlAo0P3rFs6cM+YilPGLSmDc36+
        WZ02vMDhddwboI3UGqThWdUGUeqnY2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646240273;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAjgo+3jQG/NSIcaPjKqnrupczEVkOcmUVUYDpcRKBc=;
        b=w6bCMFmyjn/TVqNtUmDBRBxIfNXSA66L6ZgZT1fcrdZnPxhdCj+SWvK1+LO+/w+Qg8Nba3
        F/YsBBK4rfAFY8BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 331C413A93;
        Wed,  2 Mar 2022 16:57:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rlFMCRGiH2IvPwAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 02 Mar 2022 16:57:53 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id 0b9dffd6;
        Wed, 2 Mar 2022 16:58:09 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     xiubli@redhat.com
Cc:     jlayton@kernel.org, idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] ceph: encrypt the snapshot directories
References: <20220302121323.240432-1-xiubli@redhat.com>
        <87mti88isf.fsf@brahms.olymp>
Date:   Wed, 02 Mar 2022 16:58:09 +0000
In-Reply-To: <87mti88isf.fsf@brahms.olymp> (=?utf-8?Q?=22Lu=C3=ADs?=
 Henriques"'s message of
        "Wed, 02 Mar 2022 15:40:16 +0000")
Message-ID: <87ilsw8f6m.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Lu=C3=ADs Henriques <lhenriques@suse.de> writes:

> Hi Xiubo,
>
> xiubli@redhat.com writes:
>
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> This patch series is base on the 'wip-fscrypt' branch in ceph-client.
>
> I gave this patchset a try but it looks broken.  For example, if 'mydir'
> is an encrypted *and* locked directory doing:
>
> # ls -l mydir/.snap
>
> will result in:
>
> fscrypt (ceph, inode 1099511627782): Error -105 getting encryption context
>
> My RFC patch had an issue that I haven't fully analyzed (and that I
> "fixed" using the d_drop()).  But why is the much simpler approach I used
> not acceptable? (I.e simply use fscryt_auth from parent in
> ceph_get_snapdir()).
>
>> V3:
>> - Add more detail comments in the commit comments and code comments.
>> - Fix some bugs.
>> - Improved the patches.
>> - Remove the already merged patch.
>>
>> V2:
>> - Fix several bugs, such as for the long snap name encrypt/dencrypt
>> - Skip double dencypting dentry names for readdir
>>
>> =3D=3D=3D=3D=3D=3D
>>
>> NOTE: This patch series won't fix the long snap shot issue as Luis
>> is working on that.
>
> Yeah, I'm getting back to it right now.  Let's see if I can untangle this
> soon ;-)

OK, I've an initial attempt with PR#45224.  I don't think I have the right
permissions to explicitly request reviews, so I thought I'd better let you
know about the PR by email.

Cheers,
--=20
Lu=C3=ADs
