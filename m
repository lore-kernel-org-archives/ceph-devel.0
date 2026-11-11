Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413918;
	b=pLdBEW/VtBIamKT+k15+vIqaw5ArlkRKKF9Cs0j2307w+urisfWrGkZPPggMFnPKFPbw
	 Z+HBuqC+F6gJX9FwqrarDmH822NzhKW3lub3cAylZd/EtKqKh2cMfTQqkVB/5yCPAeI+y
	 ha0fK8zXZFzjNQpOIbDnUH5XVSrAWE0k5LDWNy31kBEe5d+knlcDa2l8d2R7AWNrIdjUc
	 7I8OI4j3TLMU5MA1K0DMxtz83xeriNAPbwkYSLi9cUd0fIMCVhi/3cBR6xIK+SST3PxPA
	 MNOuoNJ2lxMoGlBX4LRTUEfou0z7jH2wqb0CnnZgD6zLw55o4VBa8Y4debCph22Ldrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413918;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=th4q9b08lCLfMlfvam+Sv2PUGdwUZSEvcq1PM3dYcnM=;
	b=nJoYS95wKoL40cRqivKWw4szf4w5F79pYgxp2S15sdEoRcmajOqbM4eETXBJWJiBP8ly
	 ff6KcON3Wm6XX6P/zOmH+oGkKZGz7zZC4ntyAQkInjslYdW1BDu1D9RJ2/RBt81fxsEN3
	 rtP6zFdd8ZQRhWO+vPOkVuJMhZd6i7oX/7D/RM648snqQVZeyMWXxVISFFSrZWlTb2HW/
	 Q00JWleYzo89OB+U6LSg8f4KujAo1YEB6Ix4W1m3ZkcjCHxKvtZq3BLkZy1953zxJYhnK
	 9L0J6aSwPZMtflddALbpbQgugX7jxGH3QBRnK/bkf4FJ2BwldkXQepc97ItZ+IoAHYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=RXGhKNJV;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29A0606A33E
	for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 16:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C29A0606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=RXGhKNJV
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-492f0a1b685so2284235f8f.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 08:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794413916; x=1795018716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=th4q9b08lCLfMlfvam+Sv2PUGdwUZSEvcq1PM3dYcnM=;
        b=RXGhKNJVl1lv5SHKHOJa/S6JDrV8Sp20C/S2L9eAEz/GwvO9FFqGvg+hqQeTBNImNv
         9mCebGGOeLY4rMcUFsR+BUx7/yVL+ZuB96xAIjCLBvVU7/5YLJXZb9rWUBgFK1KBfh9T
         XbVYvEH8+jwQUhVtF5nk/sd43TdWD9t73HlAanUJDzaBrfU7jzzDGaX5N8tMRgTch3I+
         5PBXLDn94OFgCx8/kLnwt/jjsJng0zh2xGyt4Unc8jAZifcjPQGkLWvSe6Y/a/gtCyLa
         unfkx/D1eHjK7NcoIgmwkXgrcdled0Aze/hMHK7GO97zGSEo/jTnnyPh39iq93B/cydT
         MT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413916; x=1795018716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=th4q9b08lCLfMlfvam+Sv2PUGdwUZSEvcq1PM3dYcnM=;
        b=wc/s+WFJvW/oCYfIja/+uCSmbaJRc+u9cTzSaJNmBBdZ/UNRGqqiLs48XPXP+7OzeG
         ZBkGl5g9ZtSRmysQZ3rkmRKq4PrCoqnh8HBoq5+JmW6idtZ4ZMDgt5fm0OwjAZCGKWu9
         MWONG3eRe+XLDfM7CcRNxdoZwzEAsIxK472PPexFiTmPkm5lMuN6nsRrb3GI/ML5X67U
         Ymwq9fjg5gtNLFa7QPBR3C2BFFU1AfNYcrpYdejZCho/lHonR0/x7VYAr1XGtAu44H72
         L4bZj/QwdPv5eS8g7c8hBoS2PqXEZfT56ugPCrITCJLOMyDJJJvp8K3x+pqb6II6GP/4
         6dsw==
X-Forwarded-Encrypted: i=1; AL+hErFSJd1HdbaAMAkzRbQ6M8wTJa//PA6h2l45Dy8KSFZFzbeXc4jzl3ogBJSS54mEIkUVWL0lLeK7vc6K@vger.kernel.org
X-Gm-Message-State: APuU4Z9HEGKPYtovVGVZyFXgkKh9anXjIIG195GiLO2SGYLTn7MpnYxI
	f+7tr60yj2yF6iYEJoxv9RJuBsaF7T1BP2x8SPkwN/ktXRDaeZ8zA0WiMs0RWeMA0aA=
X-Gm-Gg: AYBFou3vxhgvHMAg+UVbJCFHchH0pBleu0vwZC3OYUhctiUJpEaJkkNMO4P7Vu+Usv7
	v7+prAz04wggxYanfl1jk/vgwgunhKU4bOKuK626t7FFQi2OTTS5BX0vp6FcxKpGX9K2vF4GpzH
	pcLev5yIbu6xesCwa2zHDlWcC7bdCAguyjslV2T3kwV0+iEbhDfAj7CcvrZvqeEDfJKueuAA7cO
	Tv9su7jde/jSOPdMwdqClGcVaCIHszX2j4kokLtBksy33BONbnuTbgxtMs/UKI+aZQho9ANnzAJ
	2dA9JeAA4db1SWZre51ylaMPdtvCIroOjnkgNqT0MsgoiQlnDc48VSJ9aEhbsVd9cfNgACEKjmR
	IFu/Y7i+f/6HSDGabJ769Qd//cHcc1qeFiElRDmUDGF3/TzA3jyZgM3aE0BYoGlkZkw2jaSzqxM
	0zVuvye5nw+0uaJyjnnWoHcEo1qTUqZ0tAzfNsTPZSfQ7iHHZhgEoGeAeCgNOPC4TRRyxfrJzwn
	kq53LCh0Doje/+U6eEZm4FM8ZTSN7bjrx8P7ZAa4VktVmq44zScKKW+wHYFgyG2rGVMeSZE94Bt
	tlou3c2V1+Tl16wqUAIYVtwN9jBqwbcR5SpdBHQgZJtym+8sjupO/1AA9iUkMdxfnlmsnaODuwA
	SH2DN+nrDS3TmgtOhYFI+VWeQvrSgUQ==
X-Received: by 2002:a5d:5d13:0:b0:48e:2108:4d28 with SMTP id ffacd0b85a97d-499c60275ebmr6470199f8f.13.1794413916177;
        Wed, 11 Nov 2026 08:18:36 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm12209506f8f.28.2026.11.11.08.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:18:35 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/9] ceph: fix mdsmap use-after-free in debugfs mdsmap_show()
Date: Wed, 11 Nov 2026 17:18:23 +0100
Message-ID: <20261111161830.1336485-3-max.kellermann@ionos.com>
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

mdsmap_show() walks mdsc->mdsmap without holding mdsc->mutex, but
ceph_mdsc_handle_mdsmap() replaces the mdsmap and frees the old one
under that mutex.  Reading the debugfs "mdsmap" file while an MDS
changes state can therefore access freed memory, including the m_info
array.

Hold mdsc->mutex while printing the map.

Fixes: 76aa844d5b2f ("ceph: debugfs")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/debugfs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 6a9a5551d9d7..01c9f1896aa1 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -59,11 +59,17 @@ static int mdsmap_show(struct seq_file *s, void *p)
 {
 	int i;
 	struct ceph_fs_client *fsc = s->private;
+	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mdsmap *mdsmap;
 
-	if (!fsc->mdsc || !fsc->mdsc->mdsmap)
+	if (!mdsc)
 		return 0;
-	mdsmap = fsc->mdsc->mdsmap;
+
+	/* ceph_mdsc_handle_mdsmap() replaces and frees the mdsmap */
+	mutex_lock(&mdsc->mutex);
+	mdsmap = mdsc->mdsmap;
+	if (!mdsmap)
+		goto out;
 	seq_printf(s, "epoch %d\n", mdsmap->m_epoch);
 	seq_printf(s, "root %d\n", mdsmap->m_root);
 	seq_printf(s, "max_mds %d\n", mdsmap->m_max_mds);
@@ -76,6 +82,8 @@ static int mdsmap_show(struct seq_file *s, void *p)
 			       ceph_pr_addr(addr),
 			       ceph_mds_state_name(state));
 	}
+out:
+	mutex_unlock(&mdsc->mutex);
 	return 0;
 }
 
-- 
2.53.0

