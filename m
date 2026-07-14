Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DFF3F0AA0;
	Tue, 14 Jul 2026 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016827; cv=none; b=ShwV4hh3e+4157RxmI3jFyBXr1ZWTk0wTl7kGhxqsZ/laGKW4xQW1IbH3lW/5/OH/Oi9ICtorQsrtRSan2f0gKVzh551+w6/GgNwiXrky9/OVSgguiKGhGknmA3uebSS5XD0wBPV4OsTf360F+mGjxncABcQmwn+O5mz4Uiu+1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016827; c=relaxed/simple;
	bh=PNV5jE9fdgiPSWMSUeFErNMwYv2w094cTzcaHlc1R/U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tbok/Z5Yp3fFGXEhjYkwKfbEwY2FNrBGiHDLTHFnHzXKpaps/7gNPDXwq7Mo9JcoveeLCt9IxYuPYIEH3t5LBimd13F/sA0i1i3b5wP7gfMD7nCd3HBuF9/GbNbRwwdNqJC0MgLBfKsvr6dNPJ29AJaKqj2URiV/bssyWgDwT0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEG0Dxie; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEG0Dxie"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65070C2BCB8;
	Tue, 14 Jul 2026 08:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784016827;
	bh=PNV5jE9fdgiPSWMSUeFErNMwYv2w094cTzcaHlc1R/U=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=uEG0DxieCBbfoovo1vEIP0af9F65j69cX5JauiLZOlnc4tnGfNSkRyTTGSVSdElU/
	 sIw75z8MBjFajJMqN+CXWXKxclfG/3oIJrX7LJrDWW/4+P0aNHbiSFatVgE8bBeiRB
	 a6v+Mf/aRdVEqAYsihUP7QHFFritRpZZ0qxmfKg2dqTndJXoRrOuYYw387RPoPTrF4
	 mnyGlOTlwL4PbCh27io/EcMPNAlwoQEJooXQUuNzU1j5BWeSHQKjNxZ7v+sFyveCax
	 rnUvtLdWLH1m51QU1YmyIJ0NLQQT1jJeqL5h12+FgkKAgFMXCQRBZQ3XekcTeBo9W2
	 bWSG1AAhhBxqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA90C43458;
	Tue, 14 Jul 2026 08:13:47 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Subject: [PATCH 0/2] ceph: fix UAF bugs in cap flushing and MDS session
 handling
Date: Tue, 14 Jul 2026 16:13:42 +0800
Message-Id: <20260714-ceph-uaf-fixes-v1-0-5c7603c181d5@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMywqDMBCF4VeRWXcgCV6oryJdmHii48JKpoogv
 nvTuvw4/OckRRIotcVJCbuovJcM+ygoTP0ygmXIJmdcbRpbcsA68dZHjnJA2WOIMNF5Wz0pR2v
 Cf8hN97qtm58RPr8Xuq4vuHfyfXIAAAA=
X-Change-ID: 20260714-ceph-uaf-fixes-bedfe0f2b159
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784016823; l=995;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=PNV5jE9fdgiPSWMSUeFErNMwYv2w094cTzcaHlc1R/U=;
 b=xJSmvVNxGoP7MXON55glnzjJGHw5spBRmzKlRy9bQ2ADZpiSP13RKVc6nwX2xXEcthyr2I/Cc
 3Myo6/w0bEqC0pQAdCCTt9jgztdxqsR395j3HomMmuG8jGW9DEr5KjL
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

These two patches fix use-after-free bugs:

Patch 1 fixes __kick_flushing_caps(), which drops i_ceph_lock during
list_for_each_entry() iteration.  A concurrent handle_cap_flush_ack()
can free the current cf entry, making the loop's next-pointer advance
read freed memory.

Patch 2 fixes check_new_map(), where three code paths drop mdsc->mutex
and access the session pointer without taking a reference, opening a
window for another thread to unregister and free the session.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
Xiubo Li (2):
      ceph: fix UAF in __kick_flushing_caps() on cf entry freed during unlock
      ceph: fix UAF in check_new_map() on session freed during unlock

 fs/ceph/caps.c       | 11 +++++++++--
 fs/ceph/mds_client.c |  6 ++++++
 2 files changed, 15 insertions(+), 2 deletions(-)
---
base-commit: fc67edb66b3c9924c4e0bb366a92b32ea13c526a
change-id: 20260714-ceph-uaf-fixes-bedfe0f2b159

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


