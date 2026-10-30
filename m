Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384267;
	b=JUde62XWyBXM4scX+ZaudKRHHmGgesoW8HSM9ZfF9ShdcEG7w9HlyB272tuN+jTnwXY1
	 uyw0BPNxskgaJme4h0AB+na254RQR2Z691xk+snPao3FVk95+Tkcvo2J6k7YxRNogdla3
	 4NQZMeuG2dwjzG+YuAFq021tvHVXXLyKo4xB0Ek50RLtPm6/NSoIyNHEoZ8yqEgzCodMC
	 rb7i+BFG9EA2FjHyZ2kTv2ChbxoJTZCs23UTMOYoEqAAFTCSiAWqqKJZno+930yAPaKL5
	 2DWa3jfNNapKASdxIbT+cDcjXRf50m9OVojOm8dfKq8Qj1XIlrPICftzn77RXrEQCHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=4Ccy6/ccBlrGrIhW2xqzP5senj2nJ8dZiTgtmFDaR5Q=;
	b=R044583FXlKKCp/D+wEF0N1m3hrEfBMuDPFyqxtfCb0vZOOQBCyBzI+vXB5FhuuZQJYE
	 9ugwzHehI9GqGRVAkv4OfhryAgFnu49jQ5+FjmuOgGduB99drmj7MSmh6/zUKXChPl7gi
	 ufbaGg7DwT2rFbz55HKE7q//c7Go3p7Ja5ClBHJA++GjgePhLWW6SaA26K1qjYfUiZTZO
	 k7kYPxsWJwgMo8h/BhX72MOIkLdl+ObFGdMCFxqzT3Ry9Pvh2atddVdY6NoBEZVBfprdw
	 Tg3xmIykrm9M6WycPsg50OlLS/X+lKXUHFwfQrlsBdMKI+3+d4C1il+Am4/2gJJKidQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iZ7LLgxU;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3E6606A31E
	for <ceph-devel@vger.kernel.org>; Fri, 30 Oct 2026 18:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A3E6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iZ7LLgxU
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91986c5cb75so11102376d6.0
        for <ceph-devel@vger.kernel.org>; Fri, 30 Oct 2026 11:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793384265; x=1793989065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Ccy6/ccBlrGrIhW2xqzP5senj2nJ8dZiTgtmFDaR5Q=;
        b=iZ7LLgxUmLeXQNNLhi8kuxZkkh9yvnyz6xI69DZcfx2lmT6yJpVbw00Ahn6RQn1BSY
         58PkaL20o8AI84pMqnr8xGjpGAmD3ZcqnPECDVcr9rr9HCz37nhruR6o0uby7sRg3U9P
         b7WYG64CN4RjYRFj/LFg6YBw1ukBOH3tauHWUR9coLK9WkkdcDVDhOggTaLJ8oPMNJ07
         SYhEc0cDkXmX5UB1Ybi5HPgeYkO9M7jnVMq7UbUrXbcs5ALHNDQ+NQDR9tFf/vdt/Hc6
         dsfQ9le9n6fxB0gXyvphVPw0L5YY+D0f2yoYCHTofVHRgpDF7l/IhwPicxomj+70xY/p
         hJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793384265; x=1793989065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Ccy6/ccBlrGrIhW2xqzP5senj2nJ8dZiTgtmFDaR5Q=;
        b=ttsPZqCDfNWgxelaBI3MJ8K4aeYfylug23/NvAFKaVULxfB9F1mJg1bEDaiX3OUW/v
         MxDrsUjSMJnc5eHt0OFvpS5vp8fFqvD28sNY/8WkWAjZzLoqr1m8B9UiVUWHYqNovrX/
         2dVghkKSZsZJ99X9Fp9GW1Zw7EJZAYfQ98Qi0zymkD5yix3DKXW/c2Hn4GxJvqLZOvuz
         C/PsEVqpINrCYy5Z1+WvtsimpSQ7LXCRNQ8rQYjjocX7SssH9qNLLDy64XNVZbk+Nvph
         zr3RlqfTh7Pyoe1iGQzJQyT1eBUI1HoEzNNhn/3aCiRhkCIoGF7OSp9O48xefdrup+oA
         vf6Q==
X-Gm-Message-State: AFq9FYIaudztPZ99J1Oqrd85HN2vTXk3watmNfeQm944XbFis0O5l8/S
	yQjnAEkggKFjYZefPczH4Z6KU7gcX5XjyNBRpKX/OQhPFmfR3bswSHc9u+fxiJb9
X-Gm-Gg: AYBFou0wmPI1ULn9OBis3mq1Qyz97eOhQKt2M3sbwSQGvTkX9H0zcofuKS/1Q2eDA9s
	D4vM02Z5yoqmQWahJvGbmEtsqnQMwcOZGI1dgPfPK3Sly4mBlvrka28VANi4nTvXv1/JKlonQ8d
	BTjPqdQivZQd2tRq/2y078c2IAZHaKy6N7gg6/cVeS0CXZyWyEn56mA7QMnmSZw7VExeJ6qFnyr
	S1g7B6RXXeNlGqPfGjRm5m8c35lphAKCiOgP+Zb7kEKfWziF57r2PrdHPyRInX4PZIMz2/1bIx5
	C2TaiXO0bqqeBLHkzz7BJQy+D39aY3/BuJa3G8auD5qUQHmDRnc0b/iYpUhJ3NXM8ZtByWzgBqM
	eOadnggC3zGIvPMFqfVuGgswuoB6Ag0MgJUD8N1SMvvVT9AkL4QwM05Mo4O65dlCWhdEV4Di7vR
	TX6fUQpnwG23IdQWnL3i0axKXdqwbgaFPfjvNbnb83GohrrS4bycw/Fib0KvHrVfuuUJo+yoH/I
	MciQdKCz6eoZiNNBSGTb5ff2XgrwIrJPKjdPQICdMZwfbSDAN4Ii3qbXiBiG2F8l3DFQK4ot4NW
	ahM1yjbRq+xCYZQ6+CG0dshlFmeOBLP/PXAkpQ9c5Gjk+oyP3H7v
X-Received: by 2002:a05:6214:33c4:b0:91c:7fb5:12fb with SMTP id 6a1803df08f44-91ca4baa7bemr49965426d6.58.1793384265093;
        Fri, 30 Oct 2026 11:17:45 -0700 (PDT)
Received: from zambezi.front.sepia.ceph.com ([2a02:8308:b10e:9400:faf:460b:2f23:8f6f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f47fd3sm21552986d6.23.2026.10.30.11.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 11:17:44 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph updates for 7.4-rc1
Date: Fri, 30 Oct 2026 19:17:28 +0100
Message-ID: <20261030181734.3806816-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit c03c1a14507dfaf8b856c2608f9ac216021fc222:

  Linux 7.3 (2026-10-18 13:14:58 -1000)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-7.4-rc1

for you to fetch changes up to 823d21c78453fcdf58dbd8ecefbb41f4f3eb6540:

  ceph: fix uninitialized err in ceph_netfs_issue_read() (2026-10-26 14:15:48 +0100)

There is a trivial conflict with "ceph: replace PagePrivate() with
page_private()" patch that went through the akpm tree.  Tal's change
switches that code to folios, so the resolution is to take this side.
I pushed it to for-linus-merged just in case.

----------------------------------------------------------------
The two things of note here are the disablement of inline data support
and a new lazyio mount option to enable LAZYIO behavior globally
(instead of via an ioctl on a per-file basis), both from Xiubo.
Despite being over a decade old, the inline data feature never lost its
experimental status -- it has always been off by default and required
passing --yes-i-really-mean-it flag to be turned on.  It was officially
deprecated in 2020 and is now in the process of being removed on the
MDS side.  For now it's still possible to re-enable it in Kconfig, but
the code will eventually be dropped from the kernel client entirely.

Outside of that we have a number of bug fixes, a series from Tal to
help phase out older page APIs, some cleanups from Max and a large pile
of LLM-based hardening patches.

Xiubo is also back in a maintainer role, replacing Slava.

----------------------------------------------------------------
Alex Markuze (2):
      ceph: fix page vector leak on encrypted netfs read EIO path
      ceph: fix uninitialized err in ceph_netfs_issue_read()

Darong Lu (1):
      libceph: initialize CRUSH choose argument weights

Felix Hoffmann (1):
      libceph: reject mismatched CRUSH weight-set sizes

Guanglei Zhu (2):
      ceph: clamp the inline data length in ceph_fill_inline_data()
      ceph: fix out-of-bounds read in ceph_netfs_issue_op_inline()

Jiangshan Yi (1):
      ceph: fix longname buffer overflow in ceph_fname_to_usr()

Jeremy Jean (2):
      ceph: fix 32-bit overflow in readdir reply count check
      libceph: fix out-of-bounds reads from repeated CRUSH bucket entries

Max Kellermann (10):
      ceph: remove unused field `i_cap_migration_resv`
      ceph: convert ceph_inode_xattr fields to `bool`
      ceph: convert ceph_cap_snap.writing fields to `bool`
      ceph: consistently use `u32` for `time_warp_seq`
      ceph: add `const` to helpers
      ceph: add helper ceph_in_snap()
      ceph: use ceph_vino() etc. instead of accessing i_vino directly
      ceph: remove redundant inode number from ceph_inode_info
      ceph: __{dir,dentry}_lease_check() returns an enum
      ceph: avoid pending truncate during nonblocking cap acquire

Nguyen Ngoc Thang (1):
      libceph: reject bad connect_seq in msgr1 READY reply

Raphael Zimmer (2):
      libceph: Fix unsafe decode in ceph_redirect_decode()
      libceph: Fix multiple unsafe decodes in ceph_oloc_decode()

Tal Zussman (20):
      ceph: use a folio in ceph_get_caps()
      ceph: use a folio in the inline read branch of ceph_filemap_fault()
      ceph: use a folio in the READ_INLINE path of ceph_read_iter()
      ceph: convert ceph_fill_inline_data() to take a folio
      ceph: convert r_locked_page to r_locked_folio
      ceph: fix error handling when the OSD client is stopping in ceph_submit_write()
      ceph: wait for pending fscache write in write_folio_nounlock()
      ceph: add ceph_folio_snap_context()
      ceph: convert ceph_wait_until_current_writes_complete() to folios
      ceph: convert get_writepages_data_length() to folios
      ceph: convert ceph_submit_write() to folios
      ceph: remove page remnants from write_folio_nounlock()
      ceph: convert page cleanup loop in writepages_finish() to folios
      ceph: remove ceph_fscrypt_pagecache_page() and ceph_fscrypt_page_offset()
      ceph: rename ceph_check_page_before_write() to ceph_check_folio_before_write()
      ceph: fix writeback_count leak when a bounce page allocation fails
      ceph: don't clear write_congested when collecting folios
      ceph: use iov_iter_extract_bvecs() for direct I/O
      libceph: use alloc_page() in ceph_alloc_page_vector()
      ceph: use alloc_page() in fill_fscrypt_truncate()

Venky Shankar (1):
      ceph: don't fail write_begin with -EAGAIN after flushing old snapc

Wentao Liang (2):
      ceph: Fix xattr buffer leak in __send_cap()
      ceph: Fix mds session leak in __open_export_target_session()

Xiang Mei (5):
      ceph: fix off-by-one NUL termination in decode_encrypted_symlink()
      ceph: reject mdsmaps that claim more than CEPH_MAX_MDS ranks
      ceph: require the dentry lease record to cover struct ceph_mds_reply_lease
      libceph: bound mon_command ack decode to front len
      ceph: fix integer overflow in the snap trace bounds check

Xiubo Li (8):
      ceph: disable inline data support
      ceph: mark the superblock active after mounting
      ceph: keep the inode, not the name, when a dentry lease expires
      ceph: wake up i_cap_wq waiters on inode shutdown
      ceph: add 'lazyio' mount option to kclient
      libceph: only set read_from_replica on read requests
      ceph: check the caps of a closed file after caps_wanted_delay_min
      MAINTAINERS: update ceph and libceph maintainers

Yogesh Gaur (2):
      libceph: reject an initial monmap with no monitors
      ceph: don't keep a mon_addr string that failed to parse

Yuanfu Xie (2):
      ceph: clamp MDS reply result code to the errno range
      ceph: fail readdir when the MDS reply carries no dirfrag

sung byeongchan (4):
      ceph: validate fscrypt auth blob length
      ceph: bound name skips in ceph_mdsmap_decode() by the message end
      ceph: validate MDS reply fragtree split array length
      ceph: validate encoded xattr name lengths

 MAINTAINERS                        |   6 +-
 fs/ceph/Kconfig                    |  13 ++
 fs/ceph/acl.c                      |   2 +-
 fs/ceph/addr.c                     | 427 ++++++++++++++++++++++++++-----------
 fs/ceph/cache.c                    |   4 +-
 fs/ceph/caps.c                     | 377 ++++++++++++++++++++++++++++----
 fs/ceph/crypto.c                   |  11 +
 fs/ceph/crypto.h                   |  12 +-
 fs/ceph/dir.c                      |  58 ++---
 fs/ceph/export.c                   |   8 +-
 fs/ceph/file.c                     | 160 +++++++-------
 fs/ceph/inode.c                    | 119 +++++++++--
 fs/ceph/mds_client.c               | 124 ++++++++---
 fs/ceph/mds_client.h               |   5 +-
 fs/ceph/mdsmap.c                   |  12 +-
 fs/ceph/quota.c                    |   6 +-
 fs/ceph/snap.c                     |  17 +-
 fs/ceph/super.c                    |  35 ++-
 fs/ceph/super.h                    | 153 ++++++++++---
 fs/ceph/util.c                     |   4 -
 fs/ceph/xattr.c                    |  18 +-
 include/linux/ceph/ceph_features.h |  14 +-
 include/linux/ceph/ceph_fs.h       |   6 +
 net/ceph/messenger_v1.c            |   8 +-
 net/ceph/mon_client.c              |   5 +-
 net/ceph/osd_client.c              |  13 +-
 net/ceph/osdmap.c                  |  18 +-
 net/ceph/pagevec.c                 |   2 +-
 28 files changed, 1246 insertions(+), 391 deletions(-)
