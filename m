From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] rbd: implement REQ_OP_WRITE_ZEROES
Date: Tue, 23 May 2017 17:08:27 +0200
Message-ID: <1495552107-1237-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33458 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760007AbdEWPIh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 May 2017 11:08:37 -0400
Received: by mail-qk0-f195.google.com with SMTP id o85so23145320qkh.0
        for <ceph-devel@vger.kernel.org>; Tue, 23 May 2017 08:08:36 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>

Commit 93c1defedcae ("rbd: remove the discard_zeroes_data flag")
explicitly didn't implement REQ_OP_WRITE_ZEROES for rbd, while the
following commit 48920ff2a5a9 ("block: remove the discard_zeroes_data
flag") dropped ->discard_zeroes_data in favor of REQ_OP_WRITE_ZEROES.

rbd does support efficient zeroing via CEPH_OSD_OP_ZERO opcode and will
release either some or all blocks depending on whether the zeroing
request is rbd_obj_bytes() aligned.  This is how we currently implement
discards, so REQ_OP_WRITE_ZEROES can be identical to REQ_OP_DISCARD for
now.  Caveats:

- REQ_NOUNMAP is ignored, but AFAICT that's true of at least two other
  current implementations - nvme and loop

- there is no ->write_zeroes_alignment and blk_bio_write_zeroes_split()
  is hence less helpful than blk_bio_discard_split(), but this can (and
  should) be fixed on the rbd side

In the future we will split these into two code paths to respect
REQ_NOUNMAP on zeroout and save on zeroing blocks that couldn't be
released on discard.

Fixes: 93c1defedcae ("rbd: remove the discard_zeroes_data flag")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 454bf9c34882..c16f74547804 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4023,6 +4023,7 @@ static void rbd_queue_workfn(struct work_struct *work)
 
 	switch (req_op(rq)) {
 	case REQ_OP_DISCARD:
+	case REQ_OP_WRITE_ZEROES:
 		op_type = OBJ_OP_DISCARD;
 		break;
 	case REQ_OP_WRITE:
@@ -4420,6 +4421,7 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	q->limits.discard_granularity = segment_size;
 	q->limits.discard_alignment = segment_size;
 	blk_queue_max_discard_sectors(q, segment_size / SECTOR_SIZE);
+	blk_queue_max_write_zeroes_sectors(q, segment_size / SECTOR_SIZE);
 
 	if (!ceph_test_opt(rbd_dev->rbd_client->client, NOCRC))
 		q->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
-- 
2.4.3

