Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC7E24E4C4
	for <ceph-devel@vger.kernel.org>; Fri, 26 Jun 2026 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492880; cv=none; b=ccxlisJUgd8k0UFb0FC3HJER6Eb4VMuN/Z9r/Ok+imoKgWKW/s/0y9feStIKRiyhzZpEH1ZDl7x6ZOnOb/5pGRqaDx0QxEhR9xT9HIqRUlldjj8iaMNqw4YuA89Dm3A8j8+PWtTCxzhbSpjoXBF6ArlyxL8rObc+o7ulPgVV6iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492880; c=relaxed/simple;
	bh=xmXcewLt03E8x1XC7IPVZKDgoBXrZfa8vmcvFHR58NE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUftnbXWgcy2QRLlALWGxvr0aQl1KbYRxeqq4KUY9YAWJPJSB2pAFYriRZ8Eek7tquq9YcO5vc4aCfm51HVevvUd5EuPGh9U2nqkZoQ1AroZeQ9f1M8MuMLf085TWQ01aKS48OBoNwxuif3caAeoebkoYVdCsa86YjxyvVZhoX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk9BCdqb; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk9BCdqb"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8df9393e4d5so11510176d6.3
        for <ceph-devel@vger.kernel.org>; Fri, 26 Jun 2026 09:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782492878; x=1783097678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XnYGowzLN1l7zlLdr/aXUS7lJ9JUt9ytoAyaK+m9WzE=;
        b=Uk9BCdqbtc4l8/9vXL17YlV8bFXeuAavuknBISQU60bUq7xTdSHgc6xbu2YrfmDbCq
         d5pbU+ggQuWe1Y/2QueNHtrN1qAR4V6HjX+MlMwZdjf6G3oCZ0cJs7K+wYgoIfm6+JI1
         /84uIb3IcEWnxcdg4U8nPDkTRaB4I5IhPiZdJUZOUGZQ5ZndTzxGR3ZIqP2ZBBemZ9gt
         GKaDfWQiw/I9+TC73b7tw/pnVV4somNZuXQVjIlyRVdwWMPUSvftVNDb8JQghQ2SAkc5
         MmfeqoQfwmdUmf30P1hWyOUxjmPY3ugYqkd8BY9E+CB6Jyh8v6c70+fMOUw9zIOJKk7E
         y0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782492878; x=1783097678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnYGowzLN1l7zlLdr/aXUS7lJ9JUt9ytoAyaK+m9WzE=;
        b=rwrzQlgGVrw1FJfB9ocMtnPH5J7VBweqBx0sQntKtsbbg+VAYnNUOIJU4TDIa7yyoL
         Mzn6TttuU8IsrFoGYOxoZkN7mHY8v7tagNJwSIyIOSp9gkMQW7PlzJmpbOt+XRpQlOBq
         UBib4w0Z1k4aIDXmHWzq4KzR29rqEr0rcs/7Irgm6LNlF30PgYXprmtOFDknCQc3qEwn
         WoK3n4vsU4CN1ZOJP+Td3rcab6doO1I8VKgpRjWFdFe/vXnVOzm+hGCrvHmvpCs88M8Z
         vZcQ0ayqObkVK6apVnoORLZ03FYs1DYLy3Fyiu0/T2meq6ElvMh4rY92T/H4LsPJtSzp
         qXWQ==
X-Gm-Message-State: AOJu0YynPZ1LTZ65ZUBT9gV48o57YD2s9iDgZkwNH6tRdfRArM9y5kx5
	KcjmZUgLiM85VpVnS12lXulMHK/Aj8FGtvSNsLNgOWmuT6oefGbn+1n9
X-Gm-Gg: AfdE7ckb5IjNcK0FCjiYKwsX5FPCAN64lvyBejUMRuC1HXNfPRWB4l0Iul0GzZbfrsi
	dVXc58fbEiRqVMlKDtzBMnIVWnZb162wwE1RrMBmSkZxB+tqyrzvbntHYLzRAGMxf5jcJlQ7DKL
	B7Tmr05h+zFrK3gh2E6+qgaicaAzjw5XYcjcN68n6Ne+Xeg+wyd2ZvxK3VIAiVWypT2XOZvjSuE
	eAWEl22yiS17tpB/wvGiD73nRY+m0nT5sV1pyYqE0bw3WiATgFUmAOyMmMtkGdUJYClvKNzabks
	XwKcsgtSYe7WQrnKZPU+rKF7kks5lmcCv1HgPI/hZPRJYG6ZupUg78RsAqZQcXEaFnAmcQ630PO
	PavmiJ+j/UfJlWCReA+HK9T6L0EoVXiUZJX/wU0Gstm+CyCbtjerAtc+z+CJXWX90oAvj1LM0/4
	XnGsu6KrZ4
X-Received: by 2002:a05:6214:27c3:b0:8d3:9bb9:4459 with SMTP id 6a1803df08f44-8e6d452f009mr126376776d6.21.1782492878005;
        Fri, 26 Jun 2026 09:54:38 -0700 (PDT)
Received: from zambezi ([2a02:8308:b10e:9400:faf:460b:2f23:8f6f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df823ab84esm217820426d6.37.2026.06.26.09.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:54:37 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph updates for 7.2-rc1
Date: Fri, 26 Jun 2026 18:54:28 +0200
Message-ID: <20260626165429.2673444-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 8cd9520d35a6c38db6567e97dd93b1f11f185dc6:

  Linux 7.1 (2026-06-14 15:58:38 +0100)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-7.2-rc1

for you to fetch changes up to 7e1f9e2cd2d0e780c394a4402c40e125109fec72:

  ceph: add manual reset debugfs control and tracepoints (2026-06-22 22:45:05 +0200)

----------------------------------------------------------------
This adds support for manual client session reset in CephFS, allowing
operators to get out of tricky livelock situations involving caps and
file locks without evicting the problematic client instance on the MDS
side or rebooting the client node both of which can be disruptive.

----------------------------------------------------------------
Alex Markuze (6):
      ceph: convert inode flags to named bit positions and atomic bitops
      ceph: use proper endian conversion for flock_len in reconnect
      ceph: harden send_mds_reconnect and handle active-MDS peer reset
      ceph: add diagnostic timeout loop to wait_caps_flush()
      ceph: add client reset state machine and session teardown
      ceph: add manual reset debugfs control and tracepoints

Johan Hovold (1):
      rbd: switch to dynamic root device

 drivers/block/rbd.c         |  23 +-
 fs/ceph/addr.c              |  20 +-
 fs/ceph/caps.c              |  34 +-
 fs/ceph/debugfs.c           | 103 ++++++
 fs/ceph/file.c              |  13 +-
 fs/ceph/inode.c             |   5 +-
 fs/ceph/locks.c             |  38 ++-
 fs/ceph/mds_client.c        | 800 ++++++++++++++++++++++++++++++++++++++++++--
 fs/ceph/mds_client.h        |  52 ++-
 fs/ceph/snap.c              |   2 +-
 fs/ceph/super.h             |  70 ++--
 fs/ceph/xattr.c             |   2 +-
 include/trace/events/ceph.h |  67 ++++
 13 files changed, 1111 insertions(+), 118 deletions(-)
