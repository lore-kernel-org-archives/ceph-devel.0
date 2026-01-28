Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774423D7E6
	for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769596429; cv=none; b=nl92dWW/0Iu2enYd4Kd7k0q1aGM/ZMjdHAT1xejT7J1q++eABoKrJbfm+8yLnCxdcD3hTdeSQH4/5wHTRG2vNCJElGiWiXazp10r5xxRIrkyL3goPiXFUI75hwvnADadwhiZg+3zlrwhfiOM0Xxasp2sVc2V9bktKC2NQRuk/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769596429; c=relaxed/simple;
	bh=OHUQBaO+ox1ay02V8LUA7OCuxLKH71mm2gulWrvp9g4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dV0fN8AgPbGc39uzi+BzEm7GEJBH8uZa25uX3j5Z+j5jnGy9bxuciwIN7KoRIeaQJI18I2pmvZogO6UTOKO/Ov6749JjnFqRSo8J/LokeFqpJDXJgmHWbyXKQdCI5rWgvtA41ewalJBV4kJPzJQp/XsvVztX+WG4Gmn6xD9CL3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fn4k25es; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fn4k25es"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c70b5594f4so83762185a.1
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 02:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769596427; x=1770201227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Td1EECa0viKqF6vhXW4aLtInPIApH/uVptLDKp0COyo=;
        b=Fn4k25esV4x+G3mIYcM0YGxbPim0f5nE1+WgZo6fdfWpLJ7pyjSSbvmLMv2VNZSpRX
         T6uNgJj9vA/zryLMh5I1kxRYHuQSm9yisCyAgdbc41KYouz78ppzfuvxobDODl18V+w0
         KTLaZI+oPw+AsPcWkQKLmZMvDDS/vTS5J2MaIIfNk5W2y5xNyFBXaywFtFAobxj7H7Rv
         O96Ghlc6lyvQCh1/hLWWPTZ5GQuu2VFrjrcUAa+uJ7Xp9Jp9GGNbziFGQ+MqBlry5sqW
         IFs7W3lIkFDg23gr+fwlh7cZcRaaVH+Afu91sv3ZMN/CskI9ZwZ38lO10H908G1bXfAf
         7s/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769596427; x=1770201227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Td1EECa0viKqF6vhXW4aLtInPIApH/uVptLDKp0COyo=;
        b=HVhA9D3LiPotCTXXBmQhcpTWx1ZxEX7bb1XUr3Qu3O2zvJkedY1BmIU+EpGKvfFY6f
         Ix205Se5pvH8geo7qlFwSEzhZHnK/uV70O+REMw35qpjChxXDxFXHf0McAz3WEKxks4t
         N9nLQmYb490gq8Y++2uzUVH4IN62KSpKYTJI8+WgmkLqGSbrTSemltLfqduxvqeca2QR
         4HcTiN/hfPEEv6JMvk4FIWkO44zIHd90BkeyEhHLMVoLYW25cm8EqSbXEvepnC/tKcP6
         c9uSbPoY9+LLiVnBj02fMerXYMJ6egtYnoGyv4qIaLhH8JZERqHponJcjgcg736DU+7c
         UdOA==
X-Gm-Message-State: AOJu0YyQUWmDrGRndn0VhWvaFsVfCwrAMJdU2W4TmIKJ30sASUIuQnxD
	+4kc0hC1SqXWCkVOUe4d1z/bOWBodwq0P30kbatrlAY6iapljZvbNTU1ZRbB9Q==
X-Gm-Gg: AZuq6aI2bbHnDrZnIHiA8uq1INJbSyENtjsDRWRxtjOZ6cb5/w7EuieMx/q3Be8Qj+X
	hW7HDLJY1MFAI5Zs5cfXft9L0hgvapk4h15bVf0xz9bl/+tKAi9lLVTKEl8atSVPHTdMGd8t+kr
	9aVsquRnvdYWH9xGKBsTrXydWy2Dk2RggJNIZi4wD09ncotp1kgMpomgVYUJolbYoyqA+9riOUS
	l9TXTqU7Hs4zypgs0Gyon26x8aaN8+/seYuo9KM+97UrYWHQVGRGGss8BzcHye3FzqmHpMcAmcn
	EedhyJR+xzOxtF0wN3I/+nIcTpFCOOf+SMP7QU3rY4BG8jKuRZ+QbRViqSJFwvOtrFpXtthEoYb
	6n9xUTj+UqDGKTWR36L5uQh5wQgkN17VCYhtg8CHM4SDorSD1J4D+2eXhO7Mr6Pf7ZmXsFD47pt
	/iOc4yNlkCMgWYu+cvVgZF9Ns5rPdFLBS0hu+s9A8HngMC/nkspgBNDw==
X-Received: by 2002:a05:620a:19a5:b0:8b2:e3c1:24b7 with SMTP id af79cd13be357-8c70c221f4amr536996585a.29.1769596426983;
        Wed, 28 Jan 2026 02:33:46 -0800 (PST)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337bbb66dsm12383451cf.29.2026.01.28.02.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 02:33:46 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>
Subject: [PATCH 0/5] libceph: CEPH_CRYPTO_AES256KRB5 (--key-type aes256k) support
Date: Wed, 28 Jan 2026 11:33:22 +0100
Message-ID: <20260128103329.964466-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series adds support for the upcoming CephX key type that is based
on Kerberos 5.

Thanks,

                Ilya


Ilya Dryomov (5):
  libceph: define and enforce CEPH_MAX_KEY_LEN
  libceph: generalize ceph_x_encrypt_offset() and
    ceph_x_encrypt_buflen()
  libceph: introduce ceph_crypto_key_prepare()
  libceph: add support for CEPH_CRYPTO_AES256KRB5
  libceph: adapt ceph_x_challenge_blob hashing and msgr1 message signing

 include/linux/ceph/ceph_fs.h |   5 +-
 net/ceph/Kconfig             |   1 +
 net/ceph/auth_x.c            | 195 ++++++++++++++++++-------
 net/ceph/auth_x_protocol.h   |  38 +++++
 net/ceph/crypto.c            | 275 ++++++++++++++++++++++++++++-------
 net/ceph/crypto.h            |  21 ++-
 net/ceph/messenger_v2.c      |  16 +-
 7 files changed, 433 insertions(+), 118 deletions(-)

-- 
2.49.0

