Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A05A3DD519
	for <ceph-devel@vger.kernel.org>; Fri,  5 Jun 2026 08:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780648997; cv=none; b=XFsYorWApM9MYewJHTkZtitvDJD/QL+n3Ct6rK3QkScCc8jcPrM+BKK1onWL6NaSebBH609eqs4VHv+gotw9HnMihbnczy5d/N31tT+aKCIVYVHpAbiUr6KussIbT2TH9vGvqLB3zgk1hWzfBjhWmiK3L1yOV/1iz340JnmD6Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780648997; c=relaxed/simple;
	bh=M+7YNMzBkYbgC4fvNNwmTWEArQFJI5RXALr+nS5uySY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5YZzWJ1VF3yPHwEvYcCMB89oFIPsS8XwJeUxNKg+jvfN9BEIL9RuAgOZGihXjldk1EdnP/hbsax4EtsrCvUEytlSjsLi3/znf7wWTXtSZPl6c8hgtM6ZNy8b1fmkNHAxAFVPM7MzYPOG/SS1lV2G7QG+PR1tEDHIshjHfNVXw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAC31L4ajCJqUxtfAA--.31502S2;
	Fri, 05 Jun 2026 16:43:06 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: Viacheslav Dubeyko <vdubeyko@redhat.com>,
	ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	sage@newdream.net,
	Slava.Dubeyko@ibm.com,
	yuantan098@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	ldy3087146292@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH v5 0/2] libceph: reject zero bucket types and clean up type 0 uses
Date: Fri,  5 Jun 2026 16:43:03 +0800
Message-ID: <cover.1780640154.git.ldy3087146292@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAC31L4ajCJqUxtfAA--.31502S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr43Ww4DKw1xJr4fKF1DGFg_yoWxurX_ur
	9a9w15JrWxZa9xCa9FyF4DJF4xJ3sagayFq34Fvrn3X34rXa4agF4kuFZxWFya9FZ5AF4k
	Xr1DJryrt3WxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
	W8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQ0JCWoihtAA5QAAs3

From: Douya Le <ldy3087146292@gmail.com>

This series fixes a CRUSH map decode issue in libceph and keeps the
follow-up type-0-to-constant cleanup in a separate patch.

Patch 1/2 rejects bucket type 0 during CRUSH map decode and defines the
reserved device type in a separate enum.

Patch 2/2 uses that type constant consistently in the CRUSH mapper
paths that identify leaf devices.

Douya Le (2):
  libceph: reject zero bucket types in crush_decode
  libceph: crush: use CRUSH_ITEM_TYPE_DEVICE for leaf device checks

 include/linux/crush/crush.h | 6 +++++-
 net/ceph/crush/mapper.c     | 8 ++++----
 net/ceph/osdmap.c           | 2 ++
 3 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.47.3

