Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0D43DC4D0
	for <ceph-devel@vger.kernel.org>; Wed,  3 Jun 2026 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501820; cv=none; b=EkHZUreXqca/5KSbnIzEun4/aZVWZ0sVwj5NEXoYiCN6dj3FCu2ynNF5XABB2qFutpIQbKBAkUcr7ffOf3wfeSEaKDLowujjda3bL+x2LsUwZMp+UtBRssMNNVDLsFHVqvKH82A5undECKmLiQv+41+B78FDXq0u6YqCjKKoSHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501820; c=relaxed/simple;
	bh=8NjgZt2ufUAKT0v0bEDjkuL9dEknYB921yRBkS4Ekhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EeTW4HHjrTdglkTuob5rkUKhBeTUfyDwu9Km8PRp8Zaw83womkUJT6r1jPESg++6bqJrgsnZ6hwDgjpyywQ41x0p0M33lGct06Hc+GQSd7OcUa82YdoM0iKsX0dwkMOQ8cY6iLgsVpflVlk58Xz4QzcsQMaobgvker4cHjXRyDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9vX5dMu; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9vX5dMu"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8cce26ee1e9so89661416d6.2
        for <ceph-devel@vger.kernel.org>; Wed, 03 Jun 2026 08:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780501817; x=1781106617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jloqLgrwKVIF8BOkstk2Z6hbrUd4wWC+As7piYPUuNE=;
        b=a9vX5dMuynpRaAkJik8o4navhUrQ8NM2A4PoKipy82rmGpcjFuL//U48zvk/GRQrGa
         /Lj/+F20oB97o3niHKAWc3DBt6Togx7Oydky0uDm9Ukx2P0bwxT0gHtl9rVhxTYPhJ5l
         RkxTblgCtZX5WUu6LrUAcsFv2VZJI2HFglI27mKmssU3hCBWz1sN684tu7JXrlq9nMVy
         qcADAHPNwnkpy+y/NHVC1UoETIB5gYPhTXZ2wGjHMhV1roMIPjmBathS880Sb6oBWELC
         2lRN16nifRraJe7ZEkALsAJjXfjjguPVNMR3WedG8VAl7YnZFGOHEATMBDIoYxs4bm+u
         9+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780501817; x=1781106617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jloqLgrwKVIF8BOkstk2Z6hbrUd4wWC+As7piYPUuNE=;
        b=av1RsHB5fUkZ0rgpLOD/zFh6J9rVySDpeYWd7m83HD4aF/nKDqTfdnrhpcGyyG1+Kl
         D9fgljc16jOUtA2a43Pohn4wLZ6ip924bDGBH7dTAPfoBwBkvXX5l3n3gJB798OyD2U6
         8UyXY5Xtk+ef2km+n7fG7EyeuADBJ5wVcfXvMspGgvEZTBA+ZJawun6T29T+V8fNs9vD
         nRT0vJl4So00OaYNmLQPXsXkCjW+65GcqWj6Ty8rJLBQB6zs3x/Qqa8yW3l8wdnw5v5Z
         uljXUWxmQiSG/SQouBceoLs9lkoOyLbxpywLqR2BB1LSpv9oYCZJyBzic6aqYS522Rjs
         6ZsA==
X-Forwarded-Encrypted: i=1; AFNElJ8tBfpsZWMQfjKIv2codvqc78+3BY5fF8CUuyx4IXPYI/OCNXSWJBZ27vSHJ7i/MrF8m+kpOL+cOQY6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx427oGY6pUSdplljosk2JFRFJc9A4yXgqdyVWQ/M+ZCFEnKLZH
	NUtGtLfzRh4TL7D9IOF9hmIUtufqCqIe+cbAoqNgBbBeOoGD4wJPllvW
X-Gm-Gg: Acq92OFlt3EPx2nWjpF4oIANO7OiqsybTEEnNbyW0cPekyce5i3roACUDvSwroKlDu2
	fiWjiKVRL9FvnJGnCaJhEbIU7roaho9iff+sA/70eSCgkHoTuqk0Bu9pYoDvGGBkn3J4qKbwEjF
	rtytD9n4O0Py9vqMbPdM1Rjo1yEP4gtEE93yi8TH0GHT4jELPMEarrfEvR0pqHYP+Qqxyq1b3T/
	5bukcaAM3GilWB6RyAFA0F5iOKR9KriC9AnrsRjh/avU6Gy+5wnaR0oBrhL3ajcSEe8jszkf9mC
	zIIJBFsYyLOlKkaLRgFdzftek9npR/wndOMgUmR6xVA/+K1E2hfrnAv7xApGd4fo2KCa93hp/ZK
	mb/yzUTQqTJlHLRVRB6fa6KQbyaO3PTZTYsEYrK3cawOqkEnaPK98KitMm2wJrbIm3whJRknJ62
	3gezodmCnmYUHrzgubDqZTAQP0FoLdFtuyt6oMUCZMY/qqWB7gKxIJVGMdsOHayfnwo7HBz5Twf
	W4/RdeGsSMRK7w=
X-Received: by 2002:a05:6214:2589:b0:899:efbf:9292 with SMTP id 6a1803df08f44-8cece16190emr48394546d6.43.1780501816523;
        Wed, 03 Jun 2026 08:50:16 -0700 (PDT)
Received: from zambezi.front.sepia.ceph.com (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fc7dsm23645436d6.5.2026.06.03.08.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:50:15 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Howells <dhowells@redhat.com>,
	linux-crypto@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: testmgr - allow authenc(hmac(sha{256,384}),cts(cbc(aes))) in FIPS mode
Date: Wed,  3 Jun 2026 17:50:04 +0200
Message-ID: <20260603155008.736872-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hmac(sha256), hmac(sha384) and cts(cbc(aes)) algorithms have been
marked as FIPS allowed for years.  Mark the respective authenc()
constructions per RFC 8009 ("AES Encryption with HMAC-SHA2 for
Kerberos 5") as such as well.

SP 800-57 Part 3 Rev. 1 from Jan 2015 [1] links the draft of what
became RFC 8009 in Oct 2016 as approved in section 6.3 Procurement
Guidance (item/recommendation 3).

[1] https://csrc.nist.gov/pubs/sp/800/57/pt3/r1/final

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 crypto/testmgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 4d86efae65b2..7788e6fa80ce 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4215,6 +4215,7 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.alg = "authenc(hmac(sha256),cts(cbc(aes)))",
 		.generic_driver = "authenc(hmac-sha256-lib,cts(cbc(aes-lib)))",
 		.test = alg_test_aead,
+		.fips_allowed = 1,
 		.suite = {
 			.aead = __VECS(krb5_test_aes128_cts_hmac_sha256_128)
 		}
@@ -4256,6 +4257,7 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.alg = "authenc(hmac(sha384),cts(cbc(aes)))",
 		.generic_driver = "authenc(hmac-sha384-lib,cts(cbc(aes-lib)))",
 		.test = alg_test_aead,
+		.fips_allowed = 1,
 		.suite = {
 			.aead = __VECS(krb5_test_aes256_cts_hmac_sha384_192)
 		}
-- 
2.54.0

