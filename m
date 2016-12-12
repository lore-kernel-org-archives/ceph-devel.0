From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 00/15] wip-crypto
Date: Mon, 12 Dec 2016 22:04:12 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612122203560.27603@piezo.novalocal>
References: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53538 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932298AbcLLWEP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 17:04:15 -0500
In-Reply-To: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 12 Dec 2016, Ilya Dryomov wrote:
> Hello,
> 
> This branch started as a rewrite of ceph_*{en,de}crypt*() functions to
> cope with the new CONFIG_VMAP_STACK config option, but later expanded
> to include fixes for two other issues:
> 
> - in-place en/decryption (patches 1-9)
> - useless cipher context creation on every request (patches 10-11)
> - authorize reply verification (patches 13-14)
> 
> Thanks,
> 
>                 Ilya
> 
> 
> Ilya Dryomov (15):
>   libceph: ceph_x_encrypt_buflen() takes in_len
>   libceph: old_key in process_one_ticket() is redundant
>   libceph: introduce ceph_x_encrypt_offset()
>   libceph: introduce ceph_crypt() for in-place en/decryption
>   libceph: rename and align ceph_x_authorizer::reply_buf
>   libceph: tweak calcu_signature() a little
>   libceph: switch ceph_x_encrypt() to ceph_crypt()
>   libceph: switch ceph_x_decrypt() to ceph_crypt()
>   libceph: remove now unused ceph_*{en,de}crypt*() functions
>   libceph: uninline ceph_crypto_key_destroy()
>   libceph: stop allocating a new cipher on every crypto request
>   libceph: no need for GFP_NOFS in ceph_monc_init()
>   libceph: verify authorize reply on connect
>   libceph: drop len argument of *verify_authorizer_reply()
>   libceph: no need to drop con->mutex for ->get_authorizer()

Reviewed-by: Sage Weil <sage@redhat.com>

> 
>  fs/ceph/mds_client.c           |   4 +-
>  include/linux/ceph/auth.h      |   5 +-
>  include/linux/ceph/messenger.h |   2 +-
>  net/ceph/auth.c                |   4 +-
>  net/ceph/auth_x.c              | 197 +++++++++---------
>  net/ceph/auth_x.h              |   3 +-
>  net/ceph/crypto.c              | 461 ++++++++++-------------------------------
>  net/ceph/crypto.h              |  26 +--
>  net/ceph/messenger.c           |  19 +-
>  net/ceph/mon_client.c          |  12 +-
>  net/ceph/osd_client.c          |   4 +-
>  11 files changed, 246 insertions(+), 491 deletions(-)
> 
> -- 
> 2.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
