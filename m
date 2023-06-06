Return-Path: <ceph-devel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0926C7EE24
	for <ceph-devel@archiver.kernel.org>; Tue,  6 Jun 2023 09:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbjFFJxY (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 6 Jun 2023 05:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFFJxW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jun 2023 05:53:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D494DF3
        for <ceph-devel@vger.kernel.org>; Tue,  6 Jun 2023 02:53:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8EA1C21995;
        Tue,  6 Jun 2023 09:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686045199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJUSnXnOs86YYQ770lY3t3gvo1efaWlzm4I1CIKpJmQ=;
        b=YgZRBGmELHRyZbyZn1X4BOjMYv8IUGcXYa0VTBiSPRqSHmz3spLi1kbP3sf1BimySraKI2
        SGmiES2evZV02MuY1ffgfR7yZ5oaRe89uVfSryFor0twZWQqGsvNi+oDvKYHiMvJV4y/3W
        iykRmMMtIymJ7IktCs4J0C/x7+vGlvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686045199;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJUSnXnOs86YYQ770lY3t3gvo1efaWlzm4I1CIKpJmQ=;
        b=AJAFQEEOunPZnFPb+F6f9/Xoxnqn9OvjniG9JfUa/pHBhOVZQH8iF0UjHP9v5H2dH3Ga6L
        +qgWrG8b0GlPHpDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 222CF13519;
        Tue,  6 Jun 2023 09:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JEQIBQ8Cf2TYYAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Tue, 06 Jun 2023 09:53:19 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id f43b6654;
        Tue, 6 Jun 2023 09:53:18 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     xiubli@redhat.com
Cc:     idryomov@gmail.com, ceph-devel@vger.kernel.org, jlayton@kernel.org,
        vshankar@redhat.com, mchangir@redhat.com
Subject: Re: [PATCH v2 0/2] ceph: fix fscrypt_destroy_keyring use-after-free
 bug
References: <20230606033212.1068823-1-xiubli@redhat.com>
Date:   Tue, 06 Jun 2023 10:53:18 +0100
In-Reply-To: <20230606033212.1068823-1-xiubli@redhat.com> (xiubli@redhat.com's
        message of "Tue, 6 Jun 2023 11:32:10 +0800")
Message-ID: <87pm689asx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

xiubli@redhat.com writes:

> From: Xiubo Li <xiubli@redhat.com>
>
> V2:
> - Improve the code by switching to wait_for_completion_killable_timeout()
>   when umounting, at the same add one umount_timeout option.

Instead of adding yet another (undocumented!) mount option, why not re-use
the already existent 'mount_timeout' instead?  It's already defined and
kept in 'struct ceph_options', and the default value is defined with the
same value you're using, in CEPH_MOUNT_TIMEOUT_DEFAULT.

Cheers,
--=20
Lu=C3=ADs

> - Improve the inc/dec helpers for metadata/IO cases.
>
>
> Xiubo Li (2):
>   ceph: drop the messages from MDS when unmounting
>   ceph: just wait the osd requests' callbacks to finish when unmounting
>
>  fs/ceph/addr.c       | 10 +++++
>  fs/ceph/caps.c       |  6 ++-
>  fs/ceph/mds_client.c | 14 +++++--
>  fs/ceph/mds_client.h | 11 ++++-
>  fs/ceph/quota.c      | 14 +++----
>  fs/ceph/snap.c       | 10 +++--
>  fs/ceph/super.c      | 99 +++++++++++++++++++++++++++++++++++++++++++-
>  fs/ceph/super.h      |  7 ++++
>  8 files changed, 154 insertions(+), 17 deletions(-)
>
> --=20
> 2.40.1
>

