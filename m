From: Mike Christie <mchristi@redhat.com>
Subject: Re: [PATCH 0/5] target/rbd: distributed lun reset support
Date: Fri, 08 May 2015 01:04:05 -0500
Message-ID: <554C51D5.30202@redhat.com>
References: <1430819778-24483-1-git-send-email-mchristi@redhat.com> <20150505174939.GA21297@infradead.org> <55499D46.9040008@redhat.com> <20150506064812.GA5181@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43237 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751612AbbEHGE2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 8 May 2015 02:04:28 -0400
In-Reply-To: <20150506064812.GA5181@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org

On 05/06/2015 01:48 AM, Christoph Hellwig wrote:
>>> As for the API:  I would much prefer to have things at the block layer
>>> in some form than adding side band protocol for specific functionality.
>>>
>>
>> Ok. For what you need for your NFS cluster work, will you have a
>> request_queue or block_device or gendisk?
> 
> All of them.  It's just another consumer of the in-kernel block devices
> interface.

Will users use lio with what you are working on?

I ask because I am thinking it might be better to implement my own
se_subsystem_api and sbc_ops structs and in my backend just make libceph
calls directly for callouts like sbc_ops->execute_rw. So I would not have
a block_device or request_queue if I went that route.

If I do my own backend, for reset support (PR support will be similar
with callouts added to the se_subsystem_api) I would just need the patch
below.


diff --git a/drivers/target/target_core_tmr.c b/drivers/target/target_core_tmr.c
index 315ec34..b5a3b68 100644
--- a/drivers/target/target_core_tmr.c
+++ b/drivers/target/target_core_tmr.c
@@ -323,7 +323,7 @@ static void core_tmr_drain_state_list(
 	}
 }
 
-int core_tmr_lun_reset(
+int target_core_local_tmr_lun_reset(
         struct se_device *dev,
         struct se_tmr_req *tmr,
         struct list_head *preempt_and_abort_list,
@@ -386,4 +386,18 @@ int core_tmr_lun_reset(
 			dev->transport->name);
 	return 0;
 }
+EXPORT_SYMBOL(target_core_local_tmr_lun_reset);
 
+int core_tmr_lun_reset(
+	struct se_device *dev,
+	struct se_tmr_req *tmr,
+	struct list_head *preempt_and_abort_list,
+	struct se_cmd *prout_cmd)
+{
+	if (dev->transport->reset_device)
+		return dev->transport->reset_device(dev);
+	else
+		return target_core_local_tmr_lun_reset(dev, tmr,
+						       preempt_and_abort_list,
+						       prout_cmd);
+}
diff --git a/include/target/target_core_backend.h b/include/target/target_core_backend.h
index d61be72..faad6c4 100644
--- a/include/target/target_core_backend.h
+++ b/include/target/target_core_backend.h
@@ -31,6 +31,7 @@ struct se_subsystem_api {
 	struct se_device *(*alloc_device)(struct se_hba *, const char *);
 	int (*configure_device)(struct se_device *);
 	void (*free_device)(struct se_device *device);
+	int (*reset_device)(struct se_device *);
 
 	ssize_t (*set_configfs_dev_params)(struct se_device *,
 					   const char *, ssize_t);
@@ -139,4 +139,7 @@ int	se_dev_set_max_sectors(struct se_device *, u32);
 int	se_dev_set_optimal_sectors(struct se_device *, u32);
 int	se_dev_set_block_size(struct se_device *, u32);
 
+int	target_core_local_tmr_lun_reset(struct se_device *, struct se_tmr_req *,
+					struct list_head *, struct se_cmd *);
+
 #endif /* TARGET_CORE_BACKEND_H */

