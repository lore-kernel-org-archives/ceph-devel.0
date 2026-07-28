Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0003847A0B8
	for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2026 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274200; cv=none; b=SCE9ES5sv3xLypPcooyBXFnwguv2sVqLBMz/bGs5pi+JtY0W/x+yDhMH6LN7WebvjcE/clfeRmlcSr6WXz9dOmnh8dSxv4idKd7f8t1Ory/uxKDcUAI2x6uZEChjHvv5uz1q1qNvTFVCyy4cTnlskFOPEiNGZCmLJN2nTHnGxwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274200; c=relaxed/simple;
	bh=XDQjNbbhKar8uY0avv/kD/aMx3Th5Bc2yUeUMO7wAXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRvOhhvd6oRM3SNqLrvXn7H/xhvWQ6ZL7vDzavHnG/tRUZ61HEpDrCU8i5oCB6ENHeNXmptM+OCsD5aEsh+Aq5E898PFTa3QDhkycgud2749OgrYzDCZeOxfYDXIk4j34qZlvFUxhGeg8XjjZogbgqp0Gxuwc3ER48tizNy9tFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uj3Ados3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uj3Ados3"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-471eeac43bfso265622f8f.3
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2026 14:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785274196; x=1785878996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zGURBnMw6fzU2CZK+DQfnrMi2Ya0rXE6R9ZmtmaHTkk=;
        b=Uj3Ados3I5BygJMeRy1ORSwpuFbNVWU5qbh7dPi1mXyFgd0XbJ7SiSJIzlSSLTWEG3
         O5PtiG0m9pRveLollrN9AX3Xlj8kcX2vuvezY0FIwQ1bEJYoqxlz7RLacuJIa/5THE4Q
         BG+J0mGtIW8OjuShFXBnA/IJvA6FAaII0wF37N5olcgbsBGp8AyOwS9qVGEg+MgFqfkV
         aY1WiHqvj+VJR8oegHWnnvIOq4HKcKRGtC6SxurENOCE/+zImYlNOUKK6zzsdBtUegVu
         CGeI4ugz3Z6J3wegOPtlDrTgjjbdFBmAT+x5dVLWst7Bc7YH3liXWpGRbUWy8MHZuwHt
         qgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274196; x=1785878996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zGURBnMw6fzU2CZK+DQfnrMi2Ya0rXE6R9ZmtmaHTkk=;
        b=PBHoxolMgGUIGv1faVFxeOXUKwpxn60KQPg+C+8fwUI10UruHGvxMXl/NGwD9nSK9e
         LBHZtV43PrmWdAF+gu+GkmUOXemGXgzl4w2wlbI7hWyODOmrQde4GKIIQ/SczONeO161
         OkPUfW244uwfKOFVV/YseVBajlMqejTSz0tE5dfBagqcD3VinV49qib/PQ6dkzvG11+B
         MAus33SGE84j+l6nnqvUhpYdHGLL4c5Kre61FC49xs7eh1XOFnAKukLD9CbUtc/6Lxgu
         nCTKSaSiR4rI2y0gzKNGEac95O1vEPiGQD4APlogVgXQSUxsaULpOFaNRpobTlLGE1O6
         XP1A==
X-Forwarded-Encrypted: i=1; AHgh+Rrwf2Mfdpn0bwqRrof1puuzXTjVm7xOVcN14mhk7rltLwhlnoQ8eZ6kKCrVjiZFSzHr9Sq7qGeh+tz9@vger.kernel.org
X-Gm-Message-State: AOJu0YwdKBoJLSPndSJnwTCphKWTE+/FX+akp1T/pDPz4/2d740CLKmD
	CKsHghChbR9LfvWEShUO23RJme+YaMmPc0Gjnq1Eqx7I3ehn70GNoGQ3
X-Gm-Gg: AR+sD13eT0SRH5wwG0NPfmXUupIaybHkj/ct4nKDXwdhqcmQIivIxKsWA4ZoJV6sVn0
	R6IXLzdHO2GX7DPCi6gj5uup/ewfann57rCphmt9SeHrUTSeFHOmtvvyhIKlo0T2Nlr1tlMHntJ
	emxq+QMWBvk0DPxy3IMztGKaTaKUhm5IpvmOHMgQd8WMgf067NyJ6ThPVRnCbIhcDJYGoYZxHyX
	AcPJYTDe9PzZz1lWUQqR/0jslbyucDzAukFnW4Zmnf9Foc6Na6zQDW248xj+QSwJCxnchIM9xDl
	bQcpN1TJSMhlmTM/xWyUR/I0rSgVNc0/2PKRE5X3DUKm5rJYbea5DXP1keLdUYiPqeHQhC4lLuF
	ODS+ghlVv5h/yteWNfwXVeqdO7o3y2Ik7t4ujqykvGVI8b0bbqPdPDPsQzcTNbwguJXhlT0O0qv
	MuWI74Kd1r69sS/4bc4ZIsYETp/AKTIrCgruC0PuU1S4RGoNoUADymIbBAtU9vcgLypJaKbfiWl
	bkmCxQz
X-Received: by 2002:a5d:5d09:0:b0:47f:94a8:d6db with SMTP id ffacd0b85a97d-47fb1f14a61mr4656094f8f.34.1785274196213;
        Tue, 28 Jul 2026 14:29:56 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:29:54 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: [PATCH v4 07/14] block: forward init_dma_buf_io_ctx to drivers
Date: Tue, 28 Jul 2026 22:29:19 +0100
Message-ID: <e0cc82a15419ba7b38eb0bb00ae34cf3d0c3a938.1785274111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785274111.git.asml.silence@gmail.com>
References: <cover.1785274111.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple proxy implementation of init_dma_buf_io_ctx() forwarding
the call to a new struct block_device_operations operation.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c           | 14 ++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 37d491f45015..d83cdbab65a6 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -926,6 +926,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
 	return generic_file_mmap_prepare(desc);
 }
 
+static int blkdev_init_dma_buf_io_ctx(struct file *file,
+				      struct dma_buf_io_ctx *ctx)
+{
+	struct block_device *bdev = file_bdev(file);
+	struct gendisk *disk = bdev->bd_disk;
+
+	if (!(file->f_flags & O_DIRECT))
+		return -EINVAL;
+	if (!disk->fops->init_dma_buf_io_ctx)
+		return -EINVAL;
+	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_release,
@@ -944,6 +957,7 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC,
+	.init_dma_buf_io_ctx = blkdev_init_dma_buf_io_ctx,
 };
 
 static __init int blkdev_init(void)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9213a5716f95..9f4c92e51dc9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1682,6 +1682,8 @@ struct block_device_operations {
 	/* returns the length of the identifier or a negative errno: */
 	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
 			enum blk_unique_id id_type);
+	int (*init_dma_buf_io_ctx)(struct block_device *,
+				   struct dma_buf_io_ctx *);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 
-- 
2.54.0

