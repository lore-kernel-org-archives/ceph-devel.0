Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F739C634
	for <ceph-devel@vger.kernel.org>; Tue, 24 Feb 2026 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771939627; cv=none; b=VdeT4rQ7BAqvNAELU/VrZQU+NRnx97t3UB5SnCqw9wXxYFWkHCEn7PEsRGhyPPT7t2E2R/8cXxE9aA5HZh+zO0JFHQr93D8DStdV/YuJ6e3XhR0O0kv+PD1EHPvUS5qk1/YpsYSv45QH0siNRLezV8P48iRjtpkQzO0Y42rQgrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771939627; c=relaxed/simple;
	bh=8SpNNi1ayJAt5gC7ktESwVWjn6vLZMtM1DHLO/Koa+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PLwx1y8817JwG49XH+slCPgBq3bwwmYyutCw1N/qY0yqzmqeojc5074pywSF23+itaIjAbhqTQ0zP3qSe1VdAY/Tq10LPLGNSLmyiBJYsWxzIGuhNm2xe0bnMBmytRUMy8ZcJqNESafUVTNPLp5N9RjDNvatSVW+UbSvZTykqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Jqy/upLG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Jqy/upLG"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so32408465e9.3
        for <ceph-devel@vger.kernel.org>; Tue, 24 Feb 2026 05:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1771939624; x=1772544424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFbQTyVOM7RroKjlHHm350U6lcOBB7oSufXTXuhGOpo=;
        b=Jqy/upLGCRxQj3x3SCvLuhOg7OyBodPOBnuP++qSE3gIyWVWbEMCabBLhn3MuiIQuj
         bhpeWRtIB8rQZRHXNSWR9cwHTfmo+VbGmyDl/VR3kxQjGJ1T+OqUh7KokaW92CjMR1JL
         Gpcdp1JQRjzbL5HdymNn6aZogcpx3ZpPgojSw9cIr2brg86A1+6kwnINAeWT0W+LESez
         16Vper6yBjesoPdefxJ9+WWLP3YOlvP7HNphkXvEUbSr//iydbVtX9ZSi+qrmQbBBeWD
         FrztH5V50MZbcQRkEJlRr/wQYghcgaQsS1PpuL5J5u554A5e8srrm8G8aagJLB97BTPm
         lcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771939624; x=1772544424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFbQTyVOM7RroKjlHHm350U6lcOBB7oSufXTXuhGOpo=;
        b=Errf95hVctsC4+2h8R9mWh4gHTYuR0fpQHF2V1HBHh6Wkp80aoxUOLoSPw/Ct4wPmA
         XMfodWLotZOrbud/HMyjmDnBnPcM186OxgoGwa3Ab7xpii3MGixwkCp/6DotTnG24dkP
         DeBA13sei16xCdxIWhuHQG63xBJdadlWDSENzp/KKIiYmqWasaxXMVY5+ABLtzjoxPY5
         yfELzQXDJsEgkbXUEym6I7SYTMSFHgZu/l8ZkDFSajv9QqkYvTdHhWWASe76hdQokhdF
         +MX8r/JM3J4fERZfahU03yoblMWEOHE5n+EbNfpGm7VVmTKR76XophmRFMJdX7MD1oDR
         vW8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVi6XP53Cz4KZ6AZGe58390DplmSI0UnFMDRwgcGJyVvjRWtnaIZHMFrLAFFPs2k5Ajwa1oCyLxOgy/@vger.kernel.org
X-Gm-Message-State: AOJu0YzUq2Zukn96FlyvoQ/Fmy+u1Bjt1BQXxgtwbz1y8+tdPzNWy00c
	3HrwQAT0wTj7eOTt8NfyjZjpnIPE66HncrS2iTiRbB2aKTRHKGN5GlkG7GZJfz3CBU0=
X-Gm-Gg: AZuq6aI5anU6Gjo7pH1UFGCXM3G3QRSIFjtR4t+y9gdwchU+Lr1fiG5AE7W/8LQeu5Q
	4ZvsfRRd+jt9A/9q6xF/HpL7DOu+ZF/SWIQaXX8FZYTLEcxuFF/9YVJB8rkNimN3gl0pXcuEamo
	phmrrH7hg3pUpnfN8+68ttaf5M5f0AjitBrsKr3AlEXLRyJzIltyvBKBixmMhikM/ztRq+ckgKf
	BD4H0hK/OoRRGJ0X6MUClA34u/1nZmra1+v8Onn/ASlGk+DUIb9uciQBz80h9tVWP11wqrxWzg9
	jVMJoFRnjsPWpE4KWhwlsMCXnhIjjQfoudufarFny2Q41Ezd88TuqOPFZXku819gnR4eR+iXtiA
	3DAS+HLJzwbV/DznPc4HBcTzQV04KWAqscr7pHpFklLDdjjn7Hdm9AW9i2xG0ziYfGjikXxdf7h
	09SAJjrtO1s2W9w52lapW2bruRwBnFP8xRMsIgQT3Y3O1Pb1xPUqg0PWqASfbP7/Fn/zu0T9QeD
	pU/uQFCn6jyC4z4QOHNsJXhew==
X-Received: by 2002:a05:600c:6206:b0:47d:92bb:2723 with SMTP id 5b1f17b1804b1-483a95b3e23mr185005635e9.3.1771939623542;
        Tue, 24 Feb 2026 05:27:03 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f3d0100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f3d:100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b820def3sm46597665e9.2.2026.02.24.05.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 05:27:03 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/ceph/mds_client: fix memory leaks in ceph_mdsc_build_path()
Date: Tue, 24 Feb 2026 14:26:57 +0100
Message-ID: <20260224132657.3055222-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __putname() calls to error code paths that did not free the "path"
pointer obtained by __getname().  If ownership of this pointer is not
passed to the caller via path_info.path, the function must free it
before returning.

Fixes: 3fd945a79e14 ("ceph: encode encrypted name in ceph_mdsc_build_path and dentry release")
Fixes: 550f7ca98ee0 ("ceph: give up on paths longer than PATH_MAX")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 23b6d00643c9..b1746273f186 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2768,6 +2768,7 @@ char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
 			if (ret < 0) {
 				dput(parent);
 				dput(cur);
+				__putname(path);
 				return ERR_PTR(ret);
 			}
 
@@ -2777,6 +2778,7 @@ char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
 				if (len < 0) {
 					dput(parent);
 					dput(cur);
+					__putname(path);
 					return ERR_PTR(len);
 				}
 			}
@@ -2813,6 +2815,7 @@ char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
 		 * cannot ever succeed.  Creating paths that long is
 		 * possible with Ceph, but Linux cannot use them.
 		 */
+		__putname(path);
 		return ERR_PTR(-ENAMETOOLONG);
 	}
 
-- 
2.47.3

