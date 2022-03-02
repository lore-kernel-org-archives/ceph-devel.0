Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC46C433EF
	for <ceph-devel@archiver.kernel.org>; Wed,  2 Mar 2022 15:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiCBPkr (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Wed, 2 Mar 2022 10:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiCBPkp (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Mar 2022 10:40:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDA7CA724
        for <ceph-devel@vger.kernel.org>; Wed,  2 Mar 2022 07:40:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D04ED21991;
        Wed,  2 Mar 2022 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646235600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ndH0CI7XX+oMVnGsMdy/Op6QsNyZnnGMM6Xnes6nKJo=;
        b=I+Yx9B3j+4djYxaumAykjfHAtc6f533fw5QQumLuYaRuqX1h2U6REcsTLd3GWzZkkIomA5
        MVSdMye8VPydBgP0iRPfUYdJnQe1zz9ZVvQFhZFHF8gJR4C33Yc/sx3/oexR8ySUb3MuPH
        fXstbBW5Art1RZ/thESg8oyHtwmDwMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646235600;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ndH0CI7XX+oMVnGsMdy/Op6QsNyZnnGMM6Xnes6nKJo=;
        b=+n1phKj9V7F/pofpIlZSpICrtuVoggN2knigeP8tHkBLssdNByK+Z+aixcNRBJBpOo6/gy
        ItxfPLC2Ei/DqBBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7539F13A84;
        Wed,  2 Mar 2022 15:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UnqVGdCPH2IBHAAAMHmgww
        (envelope-from <lhenriques@suse.de>); Wed, 02 Mar 2022 15:40:00 +0000
Received: from localhost (brahms.olymp [local])
        by brahms.olymp (OpenSMTPD) with ESMTPA id c9600fcf;
        Wed, 2 Mar 2022 15:40:16 +0000 (UTC)
From:   =?utf-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>
To:     xiubli@redhat.com
Cc:     jlayton@kernel.org, idryomov@gmail.com, vshankar@redhat.com,
        ceph-devel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] ceph: encrypt the snapshot directories
References: <20220302121323.240432-1-xiubli@redhat.com>
Date:   Wed, 02 Mar 2022 15:40:16 +0000
In-Reply-To: <20220302121323.240432-1-xiubli@redhat.com> (xiubli@redhat.com's
        message of "Wed, 2 Mar 2022 20:13:17 +0800")
Message-ID: <87mti88isf.fsf@brahms.olymp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

Hi Xiubo,

xiubli@redhat.com writes:

> From: Xiubo Li <xiubli@redhat.com>
>
> This patch series is base on the 'wip-fscrypt' branch in ceph-client.

I gave this patchset a try but it looks broken.  For example, if 'mydir'
is an encrypted *and* locked directory doing:

# ls -l mydir/.snap

will result in:

fscrypt (ceph, inode 1099511627782): Error -105 getting encryption context

My RFC patch had an issue that I haven't fully analyzed (and that I
"fixed" using the d_drop()).  But why is the much simpler approach I used
not acceptable? (I.e simply use fscryt_auth from parent in
ceph_get_snapdir()).

> V3:
> - Add more detail comments in the commit comments and code comments.
> - Fix some bugs.
> - Improved the patches.
> - Remove the already merged patch.
>
> V2:
> - Fix several bugs, such as for the long snap name encrypt/dencrypt
> - Skip double dencypting dentry names for readdir
>
> =3D=3D=3D=3D=3D=3D
>
> NOTE: This patch series won't fix the long snap shot issue as Luis
> is working on that.

Yeah, I'm getting back to it right now.  Let's see if I can untangle this
soon ;-)

Cheers,
--=20
Lu=C3=ADs


> Xiubo Li (6):
>   ceph: fail the request when failing to decode dentry names
>   ceph: do not dencrypt the dentry name twice for readdir
>   ceph: add ceph_get_snap_parent_inode() support
>   ceph: use the parent inode of '.snap' to dencrypt the names for
>     readdir
>   ceph: use the parent inode of '.snap' to encrypt name to build path
>   ceph: try to encrypt/decrypt long snap name
>
>  fs/ceph/crypto.c     |  95 ++++++++++++++++++++++++++++++++---
>  fs/ceph/crypto.h     |  10 +++-
>  fs/ceph/dir.c        |  98 ++++++++++++++++++++++--------------
>  fs/ceph/inode.c      | 115 ++++++++++++++++++++++++++++++++++++++-----
>  fs/ceph/mds_client.c |  57 +++++++++++++--------
>  fs/ceph/mds_client.h |   3 ++
>  fs/ceph/snap.c       |  24 +++++++++
>  fs/ceph/super.h      |   2 +
>  8 files changed, 327 insertions(+), 77 deletions(-)
>
> --=20
> 2.27.0
>

