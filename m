Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413920;
	b=x9Esim+kEhb7ZbFpD2SvM4GGQFAu0tXEWygA0DWSELeqepTmaZtHL779hcptq24lnL37
	 YiWJGsL/HcJb3dQyhhFZiT7a6J1Icl+MG1YdRn5HiTSboZUoi7sd2KP/YRGF5Fq72DEXD
	 u8B5vRAKRHWO9Fg83omKTJ98rsqsPD/d21+rDuVt/XcV9YL0xzZBmE9iahEVNFDFwgH37
	 +3tBi36JELBDB0vH3zUT26ty6rF9FfmIozojpx9jN9cWHWkOGr8G9uOM33Asdco0xczEX
	 vhTeormnqGvXMdFCaHdoI985qfOip5QChlv2+mndORAkMr2nMP6Fr4UT4VoDnyYUzvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oM/6l2zeyiYa7HEKwL18/fyBBln2kYpUTJiHwLiTo84=;
	b=eQjSZjtoao3jIFvH33h8Pcf6k033Zsy0C0rPvLxCg7XXpjhgvCrzZJaoavrWgQiBFAwZ
	 7QXlF8hxIyC4sJrsx9ovbtBBswRaR+td/OgHub2Nus5Zjm2A2eVkl4l4iitID2WJueKew
	 MpaIieBKvdted9V2s2hoWWvvEf2+Np7nAXClGVBALxVkqhMH2ZDxhnoSmbOaVxvL4koyV
	 WvlPxPjbAWf9zaLA8efMupMQHmpxNx/57UTNhXc1DFuvWWdMZ02fv965/GDt5O0OHBW5/
	 R7jjsLVyD76EMSF5xiSiXy02pkaLxCMLG9+a8KLoWsNjUEjuWnxwCTp1hmfqU5+XOyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=ExLC8ry0;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47C560A2603
	for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 16:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B47C560A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=ExLC8ry0
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-490d59c3edaso2437471f8f.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 08:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794413918; x=1795018718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oM/6l2zeyiYa7HEKwL18/fyBBln2kYpUTJiHwLiTo84=;
        b=ExLC8ry04gNbzdm24tLh3UFZXQJ6TJH01gda+GcXsaqej5tdZPsNkiqdM6uyRs5I1G
         GEu1GFYAU2GzhquwA3Rvz5MQBofvL6s8Gvtba0o7qo39XNpOg391HOYXtomqgceGl/Wm
         vhKuf996W7fesOBSmrP6cF78g9x2nvX2pZPY10uDJ823xfguO8D82SYjS0mRmDPeG3RJ
         9pBbBFgQkdrNNkSHadG3YLmCd6oAcuo8oqwbgNqZFKGvjzTY0R+pFM5wY4iIJ9rLpoYY
         uxN5T1Gvf0zpwzDIRyKyVUw7BVXH8Dp3BYu23m9jBtCFziMG360GMAXrIAsHRbRMDEgg
         s+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413918; x=1795018718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oM/6l2zeyiYa7HEKwL18/fyBBln2kYpUTJiHwLiTo84=;
        b=2oashW72KROYT8rJjClTWw189WGtxsVhjgYBkqPvQKGtmhmi3ZPQ4VCmhItp6AiSRV
         UWVvwqALaGNHlgzs6UThj57P23RSc2jr0KJKxg2C0yRseW9p9sdFlUbd+jsnwF3gvG26
         EFTWBYmg8YhYft/C7NmcOB+4nmB9obCX22UN8ecHTENUbXAHPOu7esMs/xuDcMR2AQ7X
         Ym+gbpdkCi2fSgHbltYBmeu4Pwa3GOaDbelsOM7NPQqTZtcZs01Zop+Fxzd67mPBQaob
         r+dBHQJn8eh1ybELqzkfvVLEz0OQv+AjIkabN4gwEu/DcxfFxupHeV9F2Yc7fqSxHe+K
         otrQ==
X-Forwarded-Encrypted: i=1; AL+hErFlGz4yNPC6GoUEsInBE6LDLv2T7NUrbYLagFgdZprJROv9MJIwYXWS6Q+ZKnT6ygoKAeHiDlxfn29w@vger.kernel.org
X-Gm-Message-State: APuU4Z8c21ZH1tHGaE2IZnVSaasIRpuJAIQtYHbQNiA92pGiDwn95mgs
	pf32DI/4RGCubZ7HS9lAIotIrGniuxKAoct9vrxNzihnKC0G1TiQNLyczZ7hnPud4M4=
X-Gm-Gg: AYBFou1M7G43Sh8dEZFj1vbpODK2tlO2AP0t0vLthBkrOgD6+4wtm8PdFKm/MkG+GfB
	zUs6ThaidwllxxpXIFMElKTYkwoSjpU4z02CiE4j3PIoamtF4EmTBTCqse2VuoK8VfmaX+NRgPi
	UKpfzSSzQVrb46r0SZsSlY+oyuaF5X4To/bWr2WgQ0JjPM/JTrHh+rriSY1QOSmh/FumGIpymzY
	DlNjXokfFw26nmCCkF40XPLUzyW1DwEZNfHW92WpNsHNXwoAyoRI+NrUdeVkCA7/6MxB7jbRLSc
	vJXs0wTbH0B6xhyzhIbweywrcfIRkq3ojmND/fxzIZoZ+a0LnYEGVuuhTI4/5aSToeFFV2pm8Z6
	kfvqaLD+Qlvu23teby/OljhSqUF/YtDlUDCgLmrCJbJEpWbEhUoq9LhIELcQp4XJwRHlhZVjwkQ
	z71LJZ3nGWaDZIbRirRjsjB4duJCbvzBqFK8Pxw6fYsmd433Kl8Pgz+jTYz1Z/1GspYJIlYkwsM
	fScBKw2AkAH2yFT3nCtq4afslyp1iqHpXRr/NVAQM4ToIcylM5tBdiIVSNvea08wrVG/ssQ85if
	wVLwc8QnasqPl3KCawAFUHTC87GAarqcU+0le7Khgc7FXttJxp2stUp7rUjuorLN3d96eADzQMO
	My0k0FTmg4+muehmKV1hGwgm8wZvDVA==
X-Received: by 2002:a05:6000:4615:b0:48f:8eb6:2320 with SMTP id ffacd0b85a97d-499c3c96806mr5058142f8f.3.1794413917994;
        Wed, 11 Nov 2026 08:18:37 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm12209506f8f.28.2026.11.11.08.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:18:37 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/9] ceph: fix mdsmap use-after-free in send_renew_caps() and renewed_caps()
Date: Wed, 11 Nov 2026 17:18:25 +0100
Message-ID: <20261111161830.1336485-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111161830.1336485-1-max.kellermann@ionos.com>
References: <20261111161830.1336485-1-max.kellermann@ionos.com>
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

send_renew_caps() and renewed_caps() read mdsc->mdsmap while holding
only session->s_mutex, but ceph_mdsc_handle_mdsmap() replaces the
mdsmap and frees the old one under mdsc->mutex.  They are called from
delayed_work() and handle_session(), both of which can run while a
new mdsmap arrives, so they can read the MDS state and the session
timeout from freed memory.

Read those values while holding mdsc->mutex.  Callers hold s_mutex
but not mdsc->mutex, and taking mdsc->mutex under s_mutex is the
existing lock order (e.g. check_new_map(), handle_session()).

Fixes: 2f2dc053404f ("ceph: MDS client")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index da40f2cb80f2..a43ce23d48f4 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2190,7 +2190,9 @@ static int send_renew_caps(struct ceph_mds_client *mdsc,
 
 	/* do not try to renew caps until a recovering mds has reconnected
 	 * with its clients. */
+	mutex_lock(&mdsc->mutex);
 	state = ceph_mdsmap_get_state(mdsc->mdsmap, session->s_mds);
+	mutex_unlock(&mdsc->mutex);
 	if (state < CEPH_MDS_STATE_RECONNECT) {
 		boutc(cl, "ignoring mds%d (%s)\n", session->s_mds,
 		      ceph_mds_state_name(state));
@@ -2232,14 +2234,19 @@ static void renewed_caps(struct ceph_mds_client *mdsc,
 			 struct ceph_mds_session *session, int is_renew)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
+	u32 session_timeout;
 	int was_stale;
 	int wake = 0;
 
+	mutex_lock(&mdsc->mutex);
+	session_timeout = mdsc->mdsmap->m_session_timeout;
+	mutex_unlock(&mdsc->mutex);
+
 	spin_lock(&session->s_cap_lock);
 	was_stale = is_renew && time_after_eq(jiffies, session->s_cap_ttl);
 
 	session->s_cap_ttl = session->s_renew_requested +
-		mdsc->mdsmap->m_session_timeout*HZ;
+		session_timeout * HZ;
 
 	if (was_stale) {
 		if (time_before(jiffies, session->s_cap_ttl)) {
-- 
2.53.0

