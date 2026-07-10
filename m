Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711BA1C84D0
	for <ceph-devel@vger.kernel.org>; Fri, 10 Jul 2026 02:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783649813; cv=none; b=ROWir37fVsrDmzZjrG/40A3lsJOnvuXd05JANJEm4W14k2Hus1stYi2JS7u1gXtPSHxtvVM78Es8mSDEXj65pHvwhBNUXOyP6YoemClZAZ1oVt+9spoleSXU2EQ5C63WBSnrd/bvDo6Kw+NtiilCo45WdwZlqKe0oI7fte/195o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783649813; c=relaxed/simple;
	bh=a4xwWRFP63+JiaGGfWaNRiRZYTIu98S9kiRXvF1jBSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rR5q1LprMDzPWw13/rpPmFQKuV14rpM49N6xHhl+rDY+KkgDOl8EO5LZuC5T9E+61xqlghHFyffpt81jVA2wEk0jeBzadHBHopHHGckJqKXFpKvFZ5C+PGxX39sr5u8yprdhN4OjnYKHW2HDMeUnv/xhcIfR2cqMsa2Nbxoo7Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ln5ZgtwL; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ln5ZgtwL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=Vwruevw9tvS4Zrza7fnymZYSO1AUv4G4c/xGjKy6Oe4=;
	b=Ln5ZgtwLFk/b3sRwVoqHIS8k69xnElFeizQI/A7RG2RwTksSaK9/DQPQ6kX6Yx
	sih2+7eBPh6wZKpFd237NmWL8IeeUzpC9PxIK6du1ErNClK3OLQGIWeQXX5YPQOz
	drrT1OZquYjJOq7g2Rv933JjIKgd6Tn/SoEQlUvcWDCE4=
Received: from [192.168.31.228] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBXkWvqVVBqSVsQIQ--.40004S2;
	Fri, 10 Jul 2026 10:16:12 +0800 (CST)
Message-ID: <235ac7b2-cb4d-474b-87f0-53a5962de59e@163.com>
Date: Fri, 10 Jul 2026 10:16:02 +0800
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] libceph: use RCU to protect monmap in
 ceph_compare_options()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
 "enjou1224z@gmail.com" <enjou1224z@gmail.com>
Cc: "dstsmallbird@foxmail.com" <dstsmallbird@foxmail.com>,
 "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze
 <amarkuze@redhat.com>, "slava@dubeyko.com" <slava@dubeyko.com>,
 "sage@newdream.net" <sage@newdream.net>,
 "yuantan098@gmail.com" <yuantan098@gmail.com>
References: <cover.1783423648.git.edragain@163.com>
 <f9b8b94904378d14111606a3cfee801c60492681.1783423648.git.edragain@163.com>
 <f5c76ebace1493337d01385088c5ad066abc1689.camel@ibm.com>
From: Yong Wang <edragain@163.com>
In-Reply-To: <f5c76ebace1493337d01385088c5ad066abc1689.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXkWvqVVBqSVsQIQ--.40004S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3Zw1DZry7tw47WF43AFykuFg_yoW8GrW7Jo
	WftF1xJrs5Cr1DArWxA34xtayY93Wqgw13Ars8JrsrGw43Ka4Uuw17Wa13XFW5uF1rAFW2
	y3WUA3ZaqFWxJF13n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUjiSlUUUUU
X-CM-SenderInfo: 5hgutwxdlqqiywtou0bp/xtbC1Aw-XmpQVezi7AAA30



在 2026/7/9 6:43, Viacheslav Dubeyko 写道:
> On Wed, 2026-07-08 at 11:03 +0800, Ren Wei wrote:
>> From: Yong Wang <edragain@163.com>
>>
>> ceph_compare_options() checks whether a new mount shares any monitor
>> address with an existing client by walking client->monc.monmap via
>> ceph_monmap_contains().  That comparison can run under sb_lock or
>> rbd_client_list_lock, so it cannot take monc->mutex.
>>
>> Meanwhile, monmap update handling replaces monc->monmap under
>> monc->mutex and frees the old map immediately.  A concurrent shared-
>> mount comparison can therefore dereference a freed monmap and walk
>> stale mon_inst[] entries, triggering a use-after-free.
>>
>> Protect the compare path with RCU and publish/free monitor maps with
>> rcu_assign_pointer() and kfree_rcu().  Annotate monc->monmap as an
>> RCU pointer and use rcu_dereference_protected() in mutex-protected
>> paths to keep the accesses consistent with the new pointer contract.
>>
>> This keeps the existing non-blocking comparison semantics while
>> ensuring that replaced monmaps remain alive until readers are done.
> 
> The approach makes sense to me. However, I have some concern. If the replaced
> monmap(s) could be in use with newly allocated one(s), then are we safe here?

The new monmap is fully allocated and initialized before publication, then
installed with rcu_assign_pointer() under monc->mutex. Readers only dereference
an RCU snapshot and treat the monmap as immutable, while the replaced monmap is
freed with kfree_rcu(), which means the old map is not reclaimed immediately, 
but is delayed until all readers that are still accessing it have exited the 
read-side critical section.Readers only see either the old map or the new map.

So it is safe to use.

> Have you tried to run xfstests for the patch?

I ran the ceph xfstests in QEMU on the patched kernel, and all ceph-
specific tests in the current tree passed: ceph/001-006.

> Thanks,
> Slava.
> 
>>
>> Fixes: 4e7a5dcd1bbab ("ceph: negotiate authentication protocol; implement AUTH_NONE protocol")
>> Cc: stable@vger.kernel.org
>> Cc: ceph-devel@vger.kernel.org
>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>> Reported-by: Xin Liu <dstsmallbird@foxmail.com>
>> Assisted-by: Codex:gpt-5.4
>> Signed-off-by: Yong Wang <edragain@163.com>
>> Reviewed-by: Ren Wei <enjou1224z@gmail.com>
>> ---
>>  fs/ceph/super.c                 |  7 +++--
>>  include/linux/ceph/mon_client.h |  4 ++-
>>  net/ceph/ceph_common.c          | 21 ++++++++++----
>>  net/ceph/debugfs.c              | 11 ++++---
>>  net/ceph/mon_client.c           | 51 ++++++++++++++++++++++-----------
>>  5 files changed, 65 insertions(+), 29 deletions(-)
>>
>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>> index c05fbd4237f8..4145594ba710 100644
>> --- a/fs/ceph/super.c
>> +++ b/fs/ceph/super.c
>> @@ -60,6 +60,7 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
>>  {
>>  	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(d_inode(dentry));
>>  	struct ceph_mon_client *monc = &fsc->client->monc;
>> +	struct ceph_monmap *monmap;
>>  	struct ceph_statfs st;
>>  	int i, err;
>>  	u64 data_pool;
>> @@ -111,8 +112,10 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
>>  	/* Must convert the fsid, for consistent values across arches */
>>  	buf->f_fsid.val[0] = 0;
>>  	mutex_lock(&monc->mutex);
>> -	for (i = 0 ; i < sizeof(monc->monmap->fsid) / sizeof(__le32) ; ++i)
>> -		buf->f_fsid.val[0] ^= le32_to_cpu(((__le32 *)&monc->monmap->fsid)[i]);
>> +	monmap = rcu_dereference_protected(monc->monmap,
>> +					   lockdep_is_held(&monc->mutex));
>> +	for (i = 0 ; i < sizeof(monmap->fsid) / sizeof(__le32) ; ++i)
>> +		buf->f_fsid.val[0] ^= le32_to_cpu(((__le32 *)&monmap->fsid)[i]);
>>  	mutex_unlock(&monc->mutex);
>>  
>>  	/* fold the fs_cluster_id into the upper bits */
>> diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
>> index 7a9a40163c0f..98a745f6d9ab 100644
>> --- a/include/linux/ceph/mon_client.h
>> +++ b/include/linux/ceph/mon_client.h
>> @@ -4,6 +4,7 @@
>>  
>>  #include <linux/completion.h>
>>  #include <linux/kref.h>
>> +#include <linux/rcupdate.h>
>>  #include <linux/rbtree.h>
>>  
>>  #include <linux/ceph/messenger.h>
>> @@ -19,6 +20,7 @@ struct ceph_monmap {
>>  	struct ceph_fsid fsid;
>>  	u32 epoch;
>>  	u32 num_mon;
>> +	struct rcu_head rcu;
>>  	struct ceph_entity_inst mon_inst[] __counted_by(num_mon);
>>  };
>>  
>> @@ -69,7 +71,7 @@ struct ceph_mon_generic_request {
>>  
>>  struct ceph_mon_client {
>>  	struct ceph_client *client;
>> -	struct ceph_monmap *monmap;
>> +	struct ceph_monmap __rcu *monmap;
>>  
>>  	struct mutex mutex;
>>  	struct delayed_work delayed_work;
>> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
>> index 952121849180..929df54cf3bb 100644
>> --- a/net/ceph/ceph_common.c
>> +++ b/net/ceph/ceph_common.c
>> @@ -133,6 +133,7 @@ int ceph_compare_options(struct ceph_options *new_opt,
>>  {
>>  	struct ceph_options *opt1 = new_opt;
>>  	struct ceph_options *opt2 = client->options;
>> +	struct ceph_monmap *monmap;
>>  	int ofs = offsetof(struct ceph_options, mon_addr);
>>  	int i;
>>  	int ret;
>> @@ -180,13 +181,20 @@ int ceph_compare_options(struct ceph_options *new_opt,
>>  	if (ret)
>>  		return ret;
>>  
>> +	rcu_read_lock();
>> +	monmap = rcu_dereference(client->monc.monmap);
>> +	ret = -1;
>> +
>>  	/* any matching mon ip implies a match */
>>  	for (i = 0; i < opt1->num_mon; i++) {
>> -		if (ceph_monmap_contains(client->monc.monmap,
>> -				 &opt1->mon_addr[i]))
>> -			return 0;
>> +		if (ceph_monmap_contains(monmap, &opt1->mon_addr[i])) {
>> +			ret = 0;
>> +			break;
>> +		}
>>  	}
>> -	return -1;
>> +
>> +	rcu_read_unlock();
>> +	return ret;
>>  }
>>  EXPORT_SYMBOL(ceph_compare_options);
>>  
>> @@ -791,6 +799,7 @@ int __ceph_open_session(struct ceph_client *client)
>>  {
>>  	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>>  	long timeout = ceph_timeout_jiffies(client->options->mount_timeout);
>> +	struct ceph_monmap *monmap;
>>  	bool have_monmap, have_osdmap;
>>  	int err;
>>  
>> @@ -803,7 +812,9 @@ int __ceph_open_session(struct ceph_client *client)
>>  	for (;;) {
>>  		mutex_lock(&client->monc.mutex);
>>  		err = client->auth_err;
>> -		have_monmap = client->monc.monmap && client->monc.monmap->epoch;
>> +		monmap = rcu_dereference_protected(client->monc.monmap,
>> +						   lockdep_is_held(&client->monc.mutex));
>> +		have_monmap = monmap && monmap->epoch;
>>  		mutex_unlock(&client->monc.mutex);
>>  
>>  		down_read(&client->osdc.lock);
>> diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
>> index 83c270bce63c..f0aa4631cf6e 100644
>> --- a/net/ceph/debugfs.c
>> +++ b/net/ceph/debugfs.c
>> @@ -35,15 +35,18 @@ static int monmap_show(struct seq_file *s, void *p)
>>  {
>>  	int i;
>>  	struct ceph_client *client = s->private;
>> +	struct ceph_monmap *monmap;
>>  
>>  	mutex_lock(&client->monc.mutex);
>> -	if (client->monc.monmap == NULL)
>> +	monmap = rcu_dereference_protected(client->monc.monmap,
>> +					   lockdep_is_held(&client->monc.mutex));
>> +	if (!monmap)
>>  		goto out_unlock;
>>  
>> -	seq_printf(s, "epoch %d\n", client->monc.monmap->epoch);
>> -	for (i = 0; i < client->monc.monmap->num_mon; i++) {
>> +	seq_printf(s, "epoch %d\n", monmap->epoch);
>> +	for (i = 0; i < monmap->num_mon; i++) {
>>  		struct ceph_entity_inst *inst =
>> -			&client->monc.monmap->mon_inst[i];
>> +			&monmap->mon_inst[i];
>>  
>>  		seq_printf(s, "\t%s%lld\t%s\n",
>>  			   ENTITY_NAME(inst->name),
>> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
>> index d2cdc8ee3155..d7e600a74ca5 100644
>> --- a/net/ceph/mon_client.c
>> +++ b/net/ceph/mon_client.c
>> @@ -206,19 +206,22 @@ static void __close_session(struct ceph_mon_client *monc)
>>   */
>>  static void pick_new_mon(struct ceph_mon_client *monc)
>>  {
>> +	struct ceph_monmap *monmap =
>> +		rcu_dereference_protected(monc->monmap,
>> +					  lockdep_is_held(&monc->mutex));
>>  	int old_mon = monc->cur_mon;
>>  
>> -	BUG_ON(monc->monmap->num_mon < 1);
>> +	BUG_ON(monmap->num_mon < 1);
>>  
>> -	if (monc->monmap->num_mon == 1) {
>> +	if (monmap->num_mon == 1) {
>>  		monc->cur_mon = 0;
>>  	} else {
>> -		int max = monc->monmap->num_mon;
>> +		int max = monmap->num_mon;
>>  		int o = -1;
>>  		int n;
>>  
>>  		if (monc->cur_mon >= 0) {
>> -			if (monc->cur_mon < monc->monmap->num_mon)
>> +			if (monc->cur_mon < monmap->num_mon)
>>  				o = monc->cur_mon;
>>  			if (o >= 0)
>>  				max--;
>> @@ -232,7 +235,7 @@ static void pick_new_mon(struct ceph_mon_client *monc)
>>  	}
>>  
>>  	dout("%s mon%d -> mon%d out of %d mons\n", __func__, old_mon,
>> -	     monc->cur_mon, monc->monmap->num_mon);
>> +	     monc->cur_mon, monmap->num_mon);
>>  }
>>  
>>  /*
>> @@ -240,6 +243,9 @@ static void pick_new_mon(struct ceph_mon_client *monc)
>>   */
>>  static void __open_session(struct ceph_mon_client *monc)
>>  {
>> +	struct ceph_monmap *monmap =
>> +		rcu_dereference_protected(monc->monmap,
>> +					  lockdep_is_held(&monc->mutex));
>>  	int ret;
>>  
>>  	pick_new_mon(monc);
>> @@ -256,7 +262,7 @@ static void __open_session(struct ceph_mon_client *monc)
>>  
>>  	dout("%s opening mon%d\n", __func__, monc->cur_mon);
>>  	ceph_con_open(&monc->con, CEPH_ENTITY_TYPE_MON, monc->cur_mon,
>> -		      &monc->monmap->mon_inst[monc->cur_mon].addr);
>> +		      &monmap->mon_inst[monc->cur_mon].addr);
>>  
>>  	/*
>>  	 * Queue a keepalive to ensure that in case of an early fault
>> @@ -542,6 +548,7 @@ static void ceph_monc_handle_map(struct ceph_mon_client *monc,
>>  				 struct ceph_msg *msg)
>>  {
>>  	struct ceph_client *client = monc->client;
>> +	struct ceph_monmap *old_monmap;
>>  	struct ceph_monmap *monmap;
>>  	void *p, *end;
>>  
>> @@ -564,10 +571,12 @@ static void ceph_monc_handle_map(struct ceph_mon_client *monc,
>>  		goto out;
>>  	}
>>  
>> -	kfree(monc->monmap);
>> -	monc->monmap = monmap;
>> +	old_monmap = rcu_dereference_protected(monc->monmap,
>> +					       lockdep_is_held(&monc->mutex));
>> +	rcu_assign_pointer(monc->monmap, monmap);
>> +	kfree_rcu(old_monmap, rcu);
>>  
>> -	__ceph_monc_got_map(monc, CEPH_SUB_MONMAP, monc->monmap->epoch);
>> +	__ceph_monc_got_map(monc, CEPH_SUB_MONMAP, monmap->epoch);
>>  	client->have_fsid = true;
>>  
>>  out:
>> @@ -775,6 +784,7 @@ static void handle_statfs_reply(struct ceph_mon_client *monc,
>>  int ceph_monc_do_statfs(struct ceph_mon_client *monc, u64 data_pool,
>>  			struct ceph_statfs *buf)
>>  {
>> +	struct ceph_monmap *monmap;
>>  	struct ceph_mon_generic_request *req;
>>  	struct ceph_mon_statfs *h;
>>  	int ret = -ENOMEM;
>> @@ -802,7 +812,9 @@ int ceph_monc_do_statfs(struct ceph_mon_client *monc, u64 data_pool,
>>  	h->monhdr.have_version = 0;
>>  	h->monhdr.session_mon = cpu_to_le16(-1);
>>  	h->monhdr.session_mon_tid = 0;
>> -	h->fsid = monc->monmap->fsid;
>> +	monmap = rcu_dereference_protected(monc->monmap,
>> +					   lockdep_is_held(&monc->mutex));
>> +	h->fsid = monmap->fsid;
>>  	h->contains_data_pool = (data_pool != CEPH_NOPOOL);
>>  	h->data_pool = cpu_to_le64(data_pool);
>>  	send_generic_request(monc, req);
>> @@ -975,6 +987,7 @@ static __printf(2, 0)
>>  int do_mon_command_vargs(struct ceph_mon_client *monc, const char *fmt,
>>  			 va_list ap)
>>  {
>> +	struct ceph_monmap *monmap;
>>  	struct ceph_mon_generic_request *req;
>>  	struct ceph_mon_command *h;
>>  	int ret = -ENOMEM;
>> @@ -999,7 +1012,9 @@ int do_mon_command_vargs(struct ceph_mon_client *monc, const char *fmt,
>>  	h->monhdr.have_version = 0;
>>  	h->monhdr.session_mon = cpu_to_le16(-1);
>>  	h->monhdr.session_mon_tid = 0;
>> -	h->fsid = monc->monmap->fsid;
>> +	monmap = rcu_dereference_protected(monc->monmap,
>> +					   lockdep_is_held(&monc->mutex));
>> +	h->fsid = monmap->fsid;
>>  	h->num_strs = cpu_to_le32(1);
>>  	len = vsprintf(h->str, fmt, ap);
>>  	h->str_len = cpu_to_le32(len);
>> @@ -1138,17 +1153,18 @@ static int build_initial_monmap(struct ceph_mon_client *monc)
>>  	__le32 my_type = ceph_msgr2(monc->client) ?
>>  		CEPH_ENTITY_ADDR_TYPE_MSGR2 : CEPH_ENTITY_ADDR_TYPE_LEGACY;
>>  	struct ceph_options *opt = monc->client->options;
>> +	struct ceph_monmap *monmap;
>>  	int num_mon = opt->num_mon;
>>  	int i;
>>  
>>  	/* build initial monmap */
>> -	monc->monmap = kzalloc_flex(*monc->monmap, mon_inst, num_mon);
>> -	if (!monc->monmap)
>> +	monmap = kzalloc_flex(*monmap, mon_inst, num_mon);
>> +	if (!monmap)
>>  		return -ENOMEM;
>> -	monc->monmap->num_mon = num_mon;
>> +	monmap->num_mon = num_mon;
>>  
>>  	for (i = 0; i < num_mon; i++) {
>> -		struct ceph_entity_inst *inst = &monc->monmap->mon_inst[i];
>> +		struct ceph_entity_inst *inst = &monmap->mon_inst[i];
>>  
>>  		memcpy(&inst->addr.in_addr, &opt->mon_addr[i].in_addr,
>>  		       sizeof(inst->addr.in_addr));
>> @@ -1157,6 +1173,7 @@ static int build_initial_monmap(struct ceph_mon_client *monc)
>>  		inst->name.type = CEPH_ENTITY_TYPE_MON;
>>  		inst->name.num = cpu_to_le64(i);
>>  	}
>> +	RCU_INIT_POINTER(monc->monmap, monmap);
>>  	return 0;
>>  }
>>  
>> @@ -1232,7 +1249,7 @@ int ceph_monc_init(struct ceph_mon_client *monc, struct ceph_client *cl)
>>  out_auth:
>>  	ceph_auth_destroy(monc->auth);
>>  out_monmap:
>> -	kfree(monc->monmap);
>> +	kfree(rcu_access_pointer(monc->monmap));
>>  out:
>>  	return err;
>>  }
>> @@ -1267,7 +1284,7 @@ void ceph_monc_stop(struct ceph_mon_client *monc)
>>  	ceph_msg_put(monc->m_subscribe);
>>  	ceph_msg_put(monc->m_subscribe_ack);
>>  
>> -	kfree(monc->monmap);
>> +	kfree_rcu(rcu_access_pointer(monc->monmap), rcu);
>>  }
>>  EXPORT_SYMBOL(ceph_monc_stop);
>>  

