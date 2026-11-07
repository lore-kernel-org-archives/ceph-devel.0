Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794019892;
	b=KCy75HekxtjBDhpumzk5XBB0xLY9nP4pyHEoS++0MRUGUpTrfgchjYIia2+S+hVA4Sfg
	 hSPOXmmGtOjOm4aTtnSrm8v8nQ5Y+hQWcQ2ZjipsQCb/Q2qGQBjSyDgy2alymnPDWe0qC
	 7LnrVWwcDiKz24bK9LaUA+cE2Iv0PjMievC0+qZ/xkT9qjf3lYqN00gSFw7xqyltXVaLn
	 pF+oXkKITzCd864G1Mzmza2qDiW1QU4uiDtlClCp7+vPmZ8o7TGBA4ZSrOs422YQS54qY
	 DnbgPJ5uMnBiS3ZbBMsmGASE2aadu1w7gkwA6ZYuJo5pU4+1nRim+BAcqEApmloLf7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794019892;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=G0qX692yCrPHWXYQmC0A5HlQOQYPvUgGHbY9hYbBHFE=;
	b=PHZzxtvTEDNQ9w7cYezDQKaxMJKgJRpeKXSbPWY3XxwaYPxhKWBJ4Z5Iz2znHNpfpi08
	 IVDN0ZvQyAnZ3AtDx/pale2oa1PfiLKlUL+iLM4paH5IXv4l3ovaAgKboD76iPK9vKti9
	 HGXWt/UYvxlJE3JBD9ui3eVHac2iiPR8fWOTFpQIDGI6WTE7xE6MUZL88ZuTwAvlH50gk
	 J1nA7xKuTZGoRUt/YrFiuiIf2nyE+aQEiP5GXZmYVGA22CYJ0a5+0qEVvI/ie/Z0u2Pjp
	 WVrklskwdxp0ekdVxq0jbpcau27CAA/Jf+VDKvA7C0MulmWa46uhKR/kxKNy+D1sIqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jp+xeKTE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A273D606A335;
	Sat,  7 Nov 2026 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jp+xeKTE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794019891;
	b=Kny0AlGpIxplqruG2zG+pDa5J3ZhEmroyaAmiR7dRhlYcd03xzZGBrBLI6gG9M980vsq
	 Z0tQVVBWmSg96IZ4xzM3MDZc0jjtOPxn7rkNEjXHrpW2vUVjhwUAkwj41PC2MdKDJdMjU
	 taq4VP/yOL8/SFiht26M5FQd3uOMqIp+6VCEfYN1542Cv2vAU/zq6JXqd8T6HECfHVPW7
	 YTMj5yzvLBmebsw2S5I4FuWetSpABig0BRwO7jgDuu3hs+N33W2TdurW+8JfTAFwF6Gbq
	 /+5uNw+pT866h3kODSBgmpfED4zYR0n4M0/eausA5vLkSxTQIadaN6ZxXcaB46YC1WQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794019891;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=G0qX692yCrPHWXYQmC0A5HlQOQYPvUgGHbY9hYbBHFE=;
	b=qbVoSqJAwabko621G/wxxtu0ul1EFYqFuaRDFIySd+v9fr5wCFHs+K3OJQUl+FYA2NXm
	 84zwcPHfTi/wieYIUPMXzbuIR+iwTMBTYbrqnlXiH4MXY4K3FFW0HENECHAaQtEzatXtv
	 yTTy7YR2tQiY4HpwQs8r3iTpQDS9A2+fksjk98L36l2Krw30//yL6zwPRdEIAQk23xAI0
	 QPwtD8DCx7AKxRYxUVuCVK8GnTYQQK7IF6c/fK6CoaKj8ah9AF1uKWiIyhH7xkwcZimRD
	 G58bC9hkrBH2KsM58NlOTwKIHc2a8WOxoWB/Cq6FzMSf3wXzW4zhnx96wPhPo/M9Vcw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3B61E1F008A1;
	Sat,  7 Nov 2026 02:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794019891;
	bh=G0qX692yCrPHWXYQmC0A5HlQOQYPvUgGHbY9hYbBHFE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=jp+xeKTEWX2OHRfLKF9wDxJIAXC9MLEdw4lXumxGjNIyrIMe2AQ3rHjKym8p7fUFp
	 giNQKERm8y16mz4/DHPLe5XD4qpT19AARzTEu7I427/VuHH8CIFUDOl8PIW5/55FI8
	 CVJIKALTDiEocXTzIaGqRyZLBteEfQ9G8d8yn0AJ6rDrz5+qfY3BuHmhXGTlwZC6LP
	 bdkIfremsd51cNSdTTRwWe+XqeMHDUQTTuv58QXhNpBIt+2V1PLGC2QcaVG/CS7lHe
	 0HPiXYe4F53KqYtb7wDKELknlY5fmJlQpun6k+bpdNpBfnMMSYlQYWl/fms9et5hMy
	 ywW6TCDkIrcoA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 897594798A;
	Sat,  7 Nov 2026 02:51:29 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Subject: [PATCH 0/2] ceph: lazy I/O write and LAZYIO revoke fixes
Date: Sat, 07 Nov 2026 03:51:26 +0100
Message-Id: <20261107-ceph-lazyio-noread-v1-0-d04369c70ab7@clyso.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMPQ6DMAxA4asgz7WUMPB3lapD4hgwQglKCqJF3
 J3Qjt/w3gGJo3CCrjgg8iZJgs/QjwJoNH5gFJcNpSorrVWNxMuIs/l+JKAPkY1D1dSusg0RtQ5
 yuETuZf9Nn6+/02onpvd9gvO8AEKrP0x2AAAA
X-Change-ID: 20261107-ceph-lazyio-noread-087d6b8ccc9d
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794019887; l=1322;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=Rt9GdhU0hJ6GKS5DTC/LEiSJ5efVuLlYUtDa5pZErT4=;
 b=ICVt88DiL4mxZcHw9QuGGAJYlGkalcIbfDdszWjbZ6YkG5VG0ZAr9JPN5kR5ziLwlYDwW7oN3
 tEXcY61EEFWCI73DlZTRqcNrN6p/AZJY6JTnqvUJi27r/O9b+iNUalB
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

Two lazy I/O changes on top of the lazy I/O series already in testing.

Patch 1 stops a buffered lazy I/O write into part of a folio that is
not uptodate from reading the folio in first.  That read is done
synchronously under i_rwsem and serialises every writer of a shared
file on the client; with lazy I/O only the dirty range of the folio
goes out, so the read buys nothing.  16 writers on 4 clients writing
47008-byte records into one shared file go from 0.27 to 0.71 GiB/s.

Patch 2 makes ceph_adjust_caps_used_for_lazyio() move a use to LAZYIO
only when that use is in the used set and its cap is not issued.
Otherwise a file with only clean cached pages holds a LAZYIO revoke
until the delayed cap check, up to 60 s, and a getattr from another
client waits that long.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
Xiubo Li (2):
      ceph: don't read a folio in for a partial lazy I/O write
      ceph: do not hold a LAZYIO revoke for pages that CACHE covers

 fs/ceph/addr.c | 163 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 fs/ceph/caps.c |  11 +++-
 2 files changed, 159 insertions(+), 15 deletions(-)
---
base-commit: 5dcec86cc31f8144857c0d9bf2a7fa13b6e6f531
change-id: 20261107-ceph-lazyio-noread-087d6b8ccc9d

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


