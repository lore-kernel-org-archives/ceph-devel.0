Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632663976B3
	for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2026 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903629; cv=none; b=n3amFKYRQq8LIkMtydVOrRjfMWeM93UqEqaDov0jx+Wjr8wmee41WQR449oNKdN5/vgM+6+x3JK3xd1KEGzOA49NyUVXPCEmH8+zbPZBArnmvwY+YH6KdhhgpMACCvG/7RPdqmOSHKNaY01nuUD8PSuYg3AfEUWj9SMcxo495dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903629; c=relaxed/simple;
	bh=EA+I4mSUw4ecU1/Q1UpFNj+BOFIbnbADbJsnW/Blo5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gjaorrt3V807rgjySNn2BUSFY5qr6kK7bgONxFNXh1WOB37jFGJVNWwVbbF4uaO+hTsfrG+YqVQtmjFbeBX+VGkYAMT3XiHb3gjaHNx/70kWCPTxRuz1YTrFCn0G8X3TGelxlhnuk85rbJsjVYtiSVd8yGwl5I5L7KoaysK5sfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=skwQv3CK; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="skwQv3CK"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6501c9903edso2888008d50.1
        for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2026 13:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1774903627; x=1775508427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7QQI828gHq0y+LyI1J4nLMUDE5XVxDfPDUD0tsfisis=;
        b=skwQv3CKHWNkcTUhIA8jS/3gSPG4Nw/rH2UTKKwH+nqMAkmhUdFUkDm54aQL6FrJLz
         grjntkV5vHIzTgnwrp550zPnljYABT5TTsr6KORxmxyBITibxwihAc1WV8FALARbdWdO
         SF7wmJIkkmOe17aja1EYmWP+7uf63BCJ5Ono8FaRHJVdQUwRqotzSW9ncKfMs8NizBQ5
         BFgkjgA+WQnJmVrPdRiL0/ljkj1Bf3FPJjMzTQUZ+kmj61n92RDUQKQUCLag3zrZnbBh
         VUVMc3Pu4IgyCBGPz/zTMtr4txA1x2IPDX5zg+250LE8JyPbTNeU74qEdoHVaGZ+y5of
         oS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774903627; x=1775508427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QQI828gHq0y+LyI1J4nLMUDE5XVxDfPDUD0tsfisis=;
        b=l7+qDssFrNQIpvrGBAQDuGdqjKIVXMGDmDiGeb9Df6YIw3QvB8TGiuQgS6J9GNTsaE
         q1iiH2x2TfCLSN/4kE30uz97K3o+Ibrmz32rz7wYZLggA3TfSqk1613UFo+AT/k81a2F
         Dysf5fG6Bg3boyG9t6ij0iY0ChYEgu/izDt2kncwyxHwVtojVoC8CYCkdHRzg2uOBjuG
         rpBzLFjbuBTriif5WxkvKqzAkuUZh1iE5+Y4wJhsygXRuEBGua9cXtUlnecuad8rHlod
         PXgLGvawu0iM6sfKzeL2hg5KMbnE3LpiuVd9DLV6g3/f9HeM+vG+mw+2DqGwRb2kBAjs
         neiw==
X-Gm-Message-State: AOJu0YzuqT3LVOlhDz1puROpsW7kQFL9Cvzb5aFb0PwclDVa7gsXky/8
	f6pStXAZG9GwVpn3D0TKFf3zTVnoPGGzybZdohrl1jIlysCf9OCmXxLzes+ssRL/0dKJGkHMJk+
	TJ+LGgju5dw==
X-Gm-Gg: ATEYQzwHa1hW3nqK1XbGqszsy0/GbiwI+4HlZEIbZB1DY+3HimeMwYpt+zBxRfJSfje
	WhCetTXUu46g7CExzuPWgdhfZ7OHnou1i2WYmvblW5UjFPolZoCco2sj6xCiJDOpjLbR86LRY4M
	OUf6i1zqP1Z5GjBaPrfiQGupjRxeQ3FExh/eKIGRuQ2jZtKvz0wk7SfpQntNs11DxDOazuafksQ
	tV4BVLEjLkhHxPle7VSBHC9PDMUUuONJlAh0VWGelI/gtvlY8nnmC+OksE1ZhZ5fXd61G+nEaV4
	SEl13F84d0Nu5uOre2OgKHMKj50q529kvymafpq9Tn5GzXCJcScJ78PWyrg9wi45F0fbq37QEx2
	tCy3h6Zs3umFjL8WlL1DovlpeA2nB03qFioGx1kJkChnY+EzJ8Se59BXEcVlpQzIlrwlxNJTIyW
	9cVjQNRK77lUMu7IDw+0IVfkM969CNoNBmb3UoIA7T33G6i6XnWy9pisiSWqBPJ2qIeoYinyylV
	WLdFlP5YrbBpyfcrO6vx3EvcA//6y4=
X-Received: by 2002:a05:690c:c190:b0:79a:3d1a:a667 with SMTP id 00721157ae682-79bde0645b8mr135007797b3.48.1774903627014;
        Mon, 30 Mar 2026 13:47:07 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:9a8d:d769:beac:5a70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cba46f3ccsm40140397b3.40.2026.03.30.13.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:47:06 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org,
	dan.carpenter@linaro.org
Cc: idryomov@gmail.com,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [PATCH] libceph: cleanup in crush_do_rule() method
Date: Mon, 30 Mar 2026 13:46:53 -0700
Message-ID: <20260330204652.178736-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Commit 41ebcc0907c5 ("crush: remove forcefeed functionality") from
May 7, 2012 (linux-next), leads to the following Smatch static
checker warning:

	net/ceph/crush/mapper.c:1015 crush_do_rule()
	warn: iterator 'j' not incremented

Before commit 41ebcc0907c5 ("crush: remove forcefeed functionality"),
we had this logic:

  j = 0;
  if (osize == 0 && force_pos >= 0) {
      o[osize] = force_context[force_pos];
      if (recurse_to_leaf)
          c[osize] = force_context[0];
      j++;           /* <-- this was the only increment, now gone */
      force_pos--;
  }
  /* then crush_choose_*(..., o+osize, j, ...) */

Now, the variable j is dead code — a variable that is set
and never meaningfully varied. This patch simply remove
the dead code.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 41ebcc0907c5 ("crush: remove forcefeed functionality")
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Patrick Donnelly <pdonnell@redhat.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 net/ceph/crush/mapper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 3a5bd1cd1e99..17b041779fb9 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -911,7 +911,7 @@ int crush_do_rule(const struct crush_map *map,
 	int osize;
 	const struct crush_rule *rule;
 	__u32 step;
-	int i, j;
+	int i;
 	int numrep;
 	int out_size;
 	/*
@@ -1012,7 +1012,6 @@ int crush_do_rule(const struct crush_map *map,
 					if (numrep <= 0)
 						continue;
 				}
-				j = 0;
 				/* make sure bucket id is valid */
 				bno = -1 - w[i];
 				if (bno < 0 || bno >= map->max_buckets) {
@@ -1036,7 +1035,7 @@ int crush_do_rule(const struct crush_map *map,
 						weight, weight_max,
 						x, numrep,
 						curstep->arg2,
-						o+osize, j,
+						o+osize, 0,
 						result_max-osize,
 						choose_tries,
 						recurse_tries,
@@ -1058,7 +1057,7 @@ int crush_do_rule(const struct crush_map *map,
 						weight, weight_max,
 						x, out_size, numrep,
 						curstep->arg2,
-						o+osize, j,
+						o+osize, 0,
 						choose_tries,
 						choose_leaf_tries ?
 						   choose_leaf_tries : 1,
-- 
2.53.0

