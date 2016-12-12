From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 00/15] wip-crypto
Date: Mon, 12 Dec 2016 21:48:45 +0100
Message-ID: <1481575740-1834-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33447 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbcLLUuE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Dec 2016 15:50:04 -0500
Received: by mail-wm0-f68.google.com with SMTP id u144so13764873wmu.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Dec 2016 12:50:03 -0800 (PST)
Received: from dhcp-1-105.brq.redhat.com ([213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 135sm37201887wmh.14.2016.12.12.12.50.01
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2016 12:50:01 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

This branch started as a rewrite of ceph_*{en,de}crypt*() functions to
cope with the new CONFIG_VMAP_STACK config option, but later expanded
to include fixes for two other issues:

- in-place en/decryption (patches 1-9)
- useless cipher context creation on every request (patches 10-11)
- authorize reply verification (patches 13-14)

Thanks,

                Ilya


Ilya Dryomov (15):
  libceph: ceph_x_encrypt_buflen() takes in_len
  libceph: old_key in process_one_ticket() is redundant
  libceph: introduce ceph_x_encrypt_offset()
  libceph: introduce ceph_crypt() for in-place en/decryption
  libceph: rename and align ceph_x_authorizer::reply_buf
  libceph: tweak calcu_signature() a little
  libceph: switch ceph_x_encrypt() to ceph_crypt()
  libceph: switch ceph_x_decrypt() to ceph_crypt()
  libceph: remove now unused ceph_*{en,de}crypt*() functions
  libceph: uninline ceph_crypto_key_destroy()
  libceph: stop allocating a new cipher on every crypto request
  libceph: no need for GFP_NOFS in ceph_monc_init()
  libceph: verify authorize reply on connect
  libceph: drop len argument of *verify_authorizer_reply()
  libceph: no need to drop con->mutex for ->get_authorizer()

 fs/ceph/mds_client.c           |   4 +-
 include/linux/ceph/auth.h      |   5 +-
 include/linux/ceph/messenger.h |   2 +-
 net/ceph/auth.c                |   4 +-
 net/ceph/auth_x.c              | 197 +++++++++---------
 net/ceph/auth_x.h              |   3 +-
 net/ceph/crypto.c              | 461 ++++++++++-------------------------------
 net/ceph/crypto.h              |  26 +--
 net/ceph/messenger.c           |  19 +-
 net/ceph/mon_client.c          |  12 +-
 net/ceph/osd_client.c          |   4 +-
 11 files changed, 246 insertions(+), 491 deletions(-)

-- 
2.4.3

