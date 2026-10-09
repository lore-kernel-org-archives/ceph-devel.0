Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDD4233946;
	Fri,  9 Oct 2026 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791511448; cv=none; b=Oh7UM5sXrJk7ZfbjnnShAvF3LxxDu4IlfAnrylu1bp5DSAmbakwV0pBwVmxXlkBLVd9lNTlIgWfUEFV5/DEpKIOBdEfrQPJ5saav/Kcny1olXOPlZuf7tG3gD+iMcP/U5ARuVhQ1k7UW/1uoAG4T8sJZAgxjUBms0beVmprpIbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791511448; c=relaxed/simple;
	bh=PfIJ/oo57ERTPazg1O0pQaG8gJUsbL6unPaCDx3RFOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B5Hr0DwifUxLF0RhwwoDWYUIIz/kJktFSlWNp/jJ/q4q+5jB3584fvLNkBLM1JVTHcW8xiWhIA0UYG1LUmEnHk81iFgn0JU877VovZ7bPHeeINGbE2ZdcesqiuWJFiFjpcvNcCOVYhaAQyjfbOxpsBMeCPX5Z+VkQPUCJcYJVdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPvhDLzY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPvhDLzY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BBBCC2BCC7;
	Fri,  9 Oct 2026 02:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791511448;
	bh=PfIJ/oo57ERTPazg1O0pQaG8gJUsbL6unPaCDx3RFOc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=NPvhDLzYk7/GWEO+SJjB5qjtpHiFfy4ACr+enPgnhsd/nFuqbcsxBLIS5CJ1pgLZB
	 Dv5GP6jfw6qTmUfcJphSVYabG+6A8pa1uPrMbM5c557VJn756cCVcn00ILJQU2O13y
	 QFbjHWjUjM5BeUW3RLq8QcM29bHLDVbPcRaSHlMAHsvhnPSewAJUHSE/ar/eWrlpIN
	 a8LDgiuUzOcn2KhoAV/Psrb3d8CYXkWZ3saHRjr92zw5HA0s1SwlSC6D3I8gqxVeut
	 YYRD9gg9bAUroaBp83IyOmHg9imPrBjl6HVly/nKcLwu8LFs9DQQRYOV1l6Ha0PWby
	 dW780mVMl2pOw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147D8CA6017;
	Fri,  9 Oct 2026 02:04:08 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Fri, 09 Oct 2026 04:04:00 +0200
Subject: [PATCH] MAINTAINERS: update ceph and libceph maintainers
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-ceph-maintainers-v1-1-298e8158087f@clyso.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBCF4avErBNUKKSrRAuzqSbIxKkIwrtnt
 XiLb/H+GxgjIUNT3BDxJKbNZ6iyADdbP6GgIRu01LWS0giHYRarJb/nYWQhK9OPSptB6RryLUQ
 c6fqSbfebj35Bt78dSOkBI2QHznQAAAA=
X-Change-ID: 20261008-ceph-maintainers-058bf128d126
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791511445; l=1286;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=UNHZxFLoDthSpbH7ZtQYJv77/Hv0b2jZ2TirzHOPBc4=;
 b=QItQR9Lu3CFJWk2CGX4actviVoxo5VQjgYAWKc5drEJez8n+/QyNlhEDzn3mcqaHhIo4uVkQ3
 VcPm/enaM/6DKguDSCpO+HWo0rugOq393x5dbVNdmFs4BO/7+fAhKT1
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

Add myself as a maintainer for the CephFS kernel client and the
libceph common code, and move Viacheslav Dubeyko from maintainer to
reviewer for both.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8d4b913f26c..d197c6928b08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5892,7 +5892,8 @@ F:	drivers/power/supply/cw2015_battery.c
 CEPH COMMON CODE (LIBCEPH)
 M:	Ilya Dryomov <idryomov@gmail.com>
 M:	Alex Markuze <amarkuze@redhat.com>
-M:	Viacheslav Dubeyko <slava@dubeyko.com>
+M:	Xiubo Li <xiubo.li@clyso.com>
+R:	Viacheslav Dubeyko <slava@dubeyko.com>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/
@@ -5905,7 +5906,8 @@ F:	net/ceph/
 CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)
 M:	Ilya Dryomov <idryomov@gmail.com>
 M:	Alex Markuze <amarkuze@redhat.com>
-M:	Viacheslav Dubeyko <slava@dubeyko.com>
+M:	Xiubo Li <xiubo.li@clyso.com>
+R:	Viacheslav Dubeyko <slava@dubeyko.com>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/

---
base-commit: b5650e70565c380d52c36f6bd0e1a4b1bdb385cd
change-id: 20261008-ceph-maintainers-058bf128d126

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


