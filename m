Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795069283;
	b=dL4OWKMSoXPJRvKHZpQf47ZeM2cUoRzCi6bgUuV3cl3us1a/mSmO1GTUquxFRQXk04KV
	 ExFKoZ4C173nH9N2Hl7r/j8+DsE4APWWlDsnBcYdOyI8d0/YtLFc0XJQ1nia/zZye3v44
	 YN0rvaxoypAkcHOmh9y2xjDrDiJ3YV/82wWyQva6CgSKMAxqXueUXak8T8rp3rQg8QuiQ
	 fHKQW1RN5u2Nm1bDRLRf8N6kiKJGkgW2651dNqUPorhC2pHdOcDl+UdyN5V4TCSQzrbbj
	 9V2geVa+vTeMJycWOs/r5t/ErbT+DT9Wjtl0QSyErRBzrtEFPH6cGjNdixiCIziqXLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=dw4sEEscOzdXh0Zd2TjfgHcpr97CB+RHTHfHcH2OFEY=;
	b=VFRhkNr8iHHcKbD9XISHmS/reeocudb6eGKu1qwikByekxvwYfCtoSDHYmwbpC71vylj
	 En5k2y+q7m6RrPjpEhZVLLOckkrOydPqce9ZPHRMjAkqiMJ7BLyuoQ1bXv0SioDAW0cU7
	 NO5foJ23C/qRZCjcjEFPBHvM11NmfTGx1v/yFC0SimqHgNiVp0/yGewKR7qX3HycNMf8W
	 hAs1oC7GJ9N/AetZ9Z6hDq98chTrLEP+27iQRDdjWAdDrN/NVOE07MiODo6NpObUNvo4h
	 dwzoUJJX5Dskbooue109WaDaxbMLATTUNJgXTdxBGhqLLW4BbPlbF0R5S7tt3HOnKgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lc2q2E6a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A5F606A32F
	for <ceph-devel@vger.kernel.org>; Thu, 19 Nov 2026 06:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20A5F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lc2q2E6a
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91ea3f6a506so17780376d6.0
        for <ceph-devel@vger.kernel.org>; Wed, 18 Nov 2026 22:21:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795069281; cv=none;
        d=google.com; s=arc-20260327;
        b=ATlMcrV1cCPca7PvPM6bhtITD3pCd5FIpSDU11mR3gFaWw/H87qCoZ8Sqt71/wpe32
         PeUS2tFVczs3WkjRB+wmj889OgajuoFhq7DD9HU2wo5scMVTMVUJcwL0J+74HTYrl5oE
         kJE3FBXV86iu2m6z25pY3yvo7oBttrhFeUHTE2TNel2/i+lTPSyCwePbkedHnfDSBe5O
         q/MSEAmZonZuPfk6IOgBevFOmdAzJfk8xe7JCP0UO//DOO05ctpeLSfeZpHB5BoFm5bD
         l+Ku4DTZUaXH6hcuH9t5GZvhrcHzvgJai2GEWJCK/mPlmLt3lGQN4rww8PmVLvaLQ9Ox
         JClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=dw4sEEscOzdXh0Zd2TjfgHcpr97CB+RHTHfHcH2OFEY=;
        fh=8fexzo2m5sqKHdQwaAkEQ/Bm0Nv+4Tyy7k3x55Gfc3k=;
        b=O50WIjIZNNNEhZSRJ211id0eafdtghAbP/h01mJXO6/OVv5E4KtWvo0wepECwZkg/e
         m0pn/G7oUEL+kjguivFnDFnJ7cYmEQRKsqTg0Qa8Dek/uBql7iqC9nX08JUb95xUjwyp
         /ZaOUArCHsFzjSGckecxgvGkqSj4aNy3YP4QwfjE3YehdU8krTSGc9iNw8jkJfmWs/A8
         thG0BxLAnqlSmAmoDt0nAhJKZRoXH5NxUodZg7vJoQNJx1Dy1OxS+/uW+7ldHV47sTHh
         lQMPB5QWbuSQVyKvNKqFcweG0fEuxVDrgUq0W78fHOdfrS2T/KLxScxGrg0ZePGAbEDg
         pVWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795069281; x=1795674081; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dw4sEEscOzdXh0Zd2TjfgHcpr97CB+RHTHfHcH2OFEY=;
        b=Lc2q2E6aq/619ivYO6N3rLuPF4GGpBYfUThFCLnXePbxSRg8VO6GmEpvXmwK3IB1H0
         EdQBzDmWmk0W+i06F7oQcBQUc6Nb9R6sf9NyPovrLi7PJpo59YUGRLnVoEiFmfDJE1eD
         znQZ94clOnQt09sBYjkAIKoibCtHSbm8FORWqeiPBdy7b2aYJ4rtVxT38BnMiZTJyE61
         ECcuTdghI2R9+T9DjSqp7TJwiuyy7cZECFRYrX3L0CEXZ80DgSCd0Da9i5dezHKbAK9m
         Sy9he5BQ5mpF68GITpvRHpHeQ3NJKgQhdy8iqXgtKdaGScMFryzv0jux06v6A8AfLEW7
         StmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069281; x=1795674081;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dw4sEEscOzdXh0Zd2TjfgHcpr97CB+RHTHfHcH2OFEY=;
        b=rMhpdCEpYOPhznnXz5/ESEKYVkX4f7zaa83TsGC6ruNhC9w0NoiecFb9c8u+b3sD9p
         d/G1YYMSC1Bm82+1brQoKpy1MdbJJ6KElbw/TLqziWnxCaBlcQBw0ssrIpdIze/QQO0a
         ioUfak2EU5dJSM6k60hpmpw0RAa2+LDPAG/D2AJgZkS2FC32La6vynxUTKksZuqC7GIx
         c5QN4+FBYOvBxubAdS7BuPE4Tkr0qf3EDOoVRcg3tJpv4Zc8pE5KVOWL7EuNMmX16uQ7
         jsq5MdUT0NvtcaHYMOzPz18zU8Xs08cYZyqcWjiyN1/hqSVeg2Mv/pF9bpa+ZLaPBmiu
         wzsQ==
X-Forwarded-Encrypted: i=1; AL+hErErXUaIfuAAObQXHhVJ4Frc0bb6shSRgBg8uG3P7OpCbPyj6ZcQF1oqEupNJKBdDgll40N1LN4vDQrp@vger.kernel.org
X-Gm-Message-State: APuU4Z9jQEE5jmBHJlD1kpHuJO8GwUywotdD0hOFrdnrlCBgKnsuhfJe
	PV0RBazNbEy5znkfpEn8yRR6VKpsN966//O68MRFa4VA7hfLQnyhXYh99WDJXjxS93414LAAUzm
	FfXLRS3ECKUGRB4R/yPHllKf6nIhngjo=
X-Gm-Gg: AZFdTZdiCmdAVSqjk4UNZ/wldJ5oDC3Hxp3RjkXNcuwcliSWd74tHkr6fLjOUlFdSIL
	i6DcxCDAJ1dw9ACpzb19mtDXpwuClkpITII7qUPGNa+wCZfgV90Y9uzR9MgyYh0e9O/KW55QGIe
	ssgbrmAVbUXRKLjEvOG/QGNwA9CR7u1YiQTxCue1BDBuFBSc4OXWA5FJV177U0f17hHoY1hJYHk
	SNKuMNdMIvfVx7tTqJn6q0UdnipZoiIMYZ2UD/kOBx6P+llJe+UF+VyX/lmMReJikDWt4rY04tY
	03lQWIfrdTbYw8P3LSIOfSsHgnbpq9ueoFTdnTW/lkh+oTXTv4kjYDzMPe/4nyYIsZEHYHwSpoP
	jGqqTapG6QBm/Oh9XtcIANvNZLpaiWrkPPG0YcMc6LWxO2CQvGkBlDx3r/EzE3BJ3aJsl1if3Jn
	94JWbobdNWDq6DWZVH0rY=
X-Received: by 2002:a05:6214:8602:b0:921:117d:2e88 with SMTP id
 6a1803df08f44-92114f1258fmr78619116d6.28.1795069280925; Wed, 18 Nov 2026
 22:21:20 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 01:21:09 -0500
X-Gm-Features: Aa3M54rKctNstj-xAw2aIWk4fNeHbccByvy8aMtrRliTYHyg6gQPWk7NFTjZLmk
Message-ID: <CAMcAce918POMDvZtF6QbhZMzmf+m49jKGdBEKV2pUi_Y3nn-Ug@mail.gmail.com>
Subject: [PATCH bpf 3/3] bpf: Add missing raw_tp_null_args[] entries for fs tracepoints
To: bpf@vger.kernel.org
Cc: dsterba@suse.com, dhowells@redhat.com, pc@manguebit.org, 
	idryomov@gmail.com, linux-btrfs@vger.kernel.org, netfs@lists.linux.dev, 
	ceph-devel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Four built-in filesystem tracepoints pass NULL pointer arguments without
corresponding PTR_MAYBE_NULL masks in raw_tp_null_args[]:

  1. btrfs_prelim_ref_insert (include/trace/events/btrfs.h:2878):
     fs/btrfs/backref.c:328 passes literal NULL for arg 2 (newref),
     and TP_fast_assign (:2856) checks newref ? newref->count : 0.
     Add { "btrfs_prelim_ref_insert", 0x100 }. (Also affects 6.12.y.)

  2. cachefiles_no_space (include/trace/events/cachefiles.h:718):
     fs/cachefiles/namei.c:122 passes literal NULL for arg 0 (obj),
     and TP_fast_assign (:729) checks obj ? obj->debug_id : 0.
     Add { "cachefiles_no_space", 0x1 }.

  3. netfs_failure (include/trace/events/netfs.h:413):
     raw_tp_null_args[] currently lists 0x10 (arg 1, sreq only), while
     fs/netfs/buffered_read.c:790 calls trace_netfs_failure(NULL, NULL,
     ret, netfs_fail_check_write_begin), passing literal NULL for arg 0
     (rreq) as well. Update mask to 0x11. (Also affects 6.12.y.)

  4. ceph_mdsc_suspend_request (include/trace/events/ceph.h:89):
     fs/ceph/mds_client.c:3691,3726,3749 invoke
     trace_ceph_mdsc_suspend_request(mdsc, session, req, ...) with
     session == NULL (arg 1), and TP_fast_assign (:107) checks
     session ? session->s_mds : -1. Add { "ceph_mdsc_suspend_request", 0x10 }.

Verified in QEMU on x86_64 7.4.0-rc3 (20eef29b7c84, all 4 tracepoints
flip LOADED -> REJECTED) and 6.12.118 (btrfs_prelim_ref_insert and
netfs_failure flip LOADED -> REJECTED; cachefiles_no_space and
ceph_mdsc_suspend_request are post-6.12 tracepoints).

Fixes: 838a10bd2ebf ("bpf: Augment raw_tp arguments with PTR_MAYBE_NULL")
Cc: stable@vger.kernel.org # 6.12+
Signed-off-by: BoBppy <inkxiao12@gmail.com>
---
 kernel/bpf/btf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ef10af2..30be05b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7274,6 +7274,8 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "afs_make_fs_call2", 0x10 },
  { "afs_protocol_error", 0x1 },
  { "afs_flock_ev", 0x10 },
+ /* btrfs */
+ { "btrfs_prelim_ref_insert", 0x100 },
  /* cachefiles */
  { "cachefiles_lookup", 0x1 | 0x200 },
  { "cachefiles_unlink", 0x1 },
@@ -7284,6 +7286,7 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "cachefiles_mark_inactive", 0x1 },
  { "cachefiles_vfs_error", 0x1 },
  { "cachefiles_io_error", 0x1 },
+ { "cachefiles_no_space", 0x1 },
  /* ext4, from ext4__mballoc event class */
  { "ext4_mballoc_discard", 0x10 },
  { "ext4_mballoc_free", 0x10 },
@@ -7314,7 +7317,7 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  /* .. from mm_page event class */
  { "mm_page_alloc_zone_locked", 0x1 },
  /* netfs */
- { "netfs_failure", 0x10 },
+ { "netfs_failure", 0x11 },
  /* power */
  { "device_pm_callback_start", 0x10 },
  /* qdisc */
@@ -7416,6 +7419,8 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "pnfs_mds_fallback_write_done", 0x10000 },
  { "pnfs_mds_fallback_read_pagelist", 0x10000 },
  { "pnfs_mds_fallback_write_pagelist", 0x10000 },
+ /* ceph */
+ { "ceph_mdsc_suspend_request", 0x10 },
  /* coda */
  { "coda_dec_pic_run", 0x10 },
  { "coda_dec_pic_done", 0x10 },
