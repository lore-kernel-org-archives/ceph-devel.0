Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACC1242D6A
	for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2026 02:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769394468; cv=none; b=FAlzs6mihHduvTi4YBoEmbzkq27LE+oD04bRIFN4W6GeqI5MqYz0ELx0tIKy153aNvujcg6DwP+gIAv+1V7Bpl28YaJ8wHS4FxN8O1gsmTo9bdJf4QsuPMF8vV0viGbAMYyS4UfXpYDLSFh2/h59aJZ0Jv8Yl4kgBFDTIJHXzto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769394468; c=relaxed/simple;
	bh=Qxml4Oo3X0NxPi1XQv1oBcqdTKw581Uv+nkdVlENUf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UYyKOKyJ2n1nMVCrqxKmOEUqK1zbJr1chk1xY1IPp8Em3KqKVtDQ/EMGIOCsTJ1/j+iDDOuQdla5wu9JHDaaoJBQWnCSAZiIYZB3CfutI1VvhKmlULxTmKzwXA82PuEagcBrwNeCISoTJOW/9ny8k399Ms+htGtW4ONzdg67KKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnuDYetx; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnuDYetx"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-121bf277922so6475037c88.0
        for <ceph-devel@vger.kernel.org>; Sun, 25 Jan 2026 18:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769394466; x=1769999266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sK2jVdu2Sb/BymO6toJsIsdkMX9KyR523S9sWV6PRsY=;
        b=HnuDYetxQKfG4XpmMvTw7B/nGlctyErmjCxidtscVuqRpGPqb68bG73UxRvEgXM+Zs
         2XjV4TYUKv5L11qMPz5mDQ5sLSTUqhZYnF1aDO6a2hy/rFGjaD3x9ien9mWbk3Ln8+vi
         ZsEypxUoOacrSpAwSSbqXv4w0XshtjE5a+nSj5xfSIh0mpH3CdqMnQUXLyZc6vafWGhW
         ckE2l9EnlL1ngtrDnhnmo3O+DcnW5jxlZwKuq+4xLA9uw2bTfTn28ZQHXEMMdKHF+RKd
         OA/xW/NygujBJ1qDA0LT3tlYwpHU4mEEvwfTvmarGWe+xxQ8vAeBLWDlfRONuXZWCO0q
         8KBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769394466; x=1769999266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK2jVdu2Sb/BymO6toJsIsdkMX9KyR523S9sWV6PRsY=;
        b=ECeSJrfanWSVF0W+I5tyE5xQB9koUFbyJ0tQZkkH00mhGgzjX5E4xGIti3I8tJG0fo
         d7kLs5gXTVV9S6oNvXuyrNi3TUx/GH45uN90u8Zf0Qt7+Z39ts3OXtZwgGBr+ExR4pc2
         hNuPuV9nrMp/kYUu9AYAio/oRs+2DSOWKdheiFMdYC4aWjRyGqU2d+f7RaXZ+bevJsJK
         h+fQwdTynGngicpBuoQ9hRe1q9C0PPdvbazpLDy9NTWSIoACgWbSYErv+0ByOxfHe11d
         f9EgrNofYsvcZZim454+nh4CstJMX95JqG8HmCI1oVvjrYpJlKAa1nAwdlr2CZnhqyLc
         F6Xg==
X-Forwarded-Encrypted: i=1; AJvYcCW1r5RFnafR/AtqtCADkQWbmvN6dvHYfv/lSgBhmEKEKx/DqcgPBcHbt2m0q2qakmBpXZtgqELA875t@vger.kernel.org
X-Gm-Message-State: AOJu0YyNRI8bPE7nV0DnTf++CGIEq1Se+MVOv+hcNgm5AEBP8S7g8fsW
	1bNQSvb7W0LxVzWZ5G9n22oazPdQa2LWNb7fDjTuqjAwwm2C2rUrKwDsLEXVd8p0
X-Gm-Gg: AZuq6aJ693vdYucM3JPutfqmHP/e+wc0Lg1gkrbhQoqyaIti7z7Ld4px6y+3I4ur7lM
	mG9tzpktdtHES23kge+P6/B3DGPS575f+2kJxDLdRatwcp1NHGu/NkXkTZC0+5jM7L7lqbxDU4j
	MA7bONFak1JRKwg0h0gPNJahVMQfhGu89b5EKlSXPnbXgAjQ2wGrQFADcY8Os4z+yLP16t++cZK
	incL4YIdrRGKk9GgjqZbaXtxN1pL0hXDxoGNWxAE1Pm6/9i3dKbjYMo+ItsWjkABOf3a1Hdp/sz
	H72wbE4UYBSfP9MeT+qwqUYubMAQkzs/IkcA7DCimswEMXc5SGPDR2ESINFa7Dz4jjZgPXiTiGU
	dGJwFgvOz2pK0OEZPceQiAP+rEJP9XnaUmNgOy9hhDk5Ia0wpg/emc2w8eXavdY2ioaH2wu9Y1t
	cJebEEikCjRELRGKPPSksbf7Iw+r65v2LTvNTDLpUHr1UewvIIYYVc
X-Received: by 2002:a05:7022:395:b0:11f:2c9e:87f8 with SMTP id a92af1059eb24-1248ec6f40fmr1483840c88.34.1769394466079;
        Sun, 25 Jan 2026 18:27:46 -0800 (PST)
Received: from luna.turtle.lan (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d90cda6sm15266037c88.1.2026.01.25.18.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 18:27:45 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Milind Changire <mchangir@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 0/2] ceph: Properly clean up after failures in ceph_submit_write()
Date: Sun, 25 Jan 2026 18:27:13 -0800
Message-ID: <20260126022715.404984-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi list,

This series contains two patches from my previous series [1] that are
independent and have no outstanding review comments.

The patches fix a crash that can occur if ceph_inc_osd_stopping_blocker()
fails on write, and split out the complex page-array cleanup logic to a new
helper function (per Slava's suggestion). The first patch is intended for
stable.

There is no known reproducer for this race condition; it appears to be
timing-sensitive. I have a fault-injection patch that can trigger it, which I
can provide on request.

Warm regards,
Sam

[1] https://lore.kernel.org/all/20260107210139.40554-1-CFSworks@gmail.com/

Sam Edwards (2):
  ceph: free page array when ceph_submit_write() fails
  ceph: split out page-array discarding to a function

 fs/ceph/addr.c | 59 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 21 deletions(-)

-- 
2.52.0

