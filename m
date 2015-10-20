From: Sage Weil <sweil@redhat.com>
Subject: Re: a problem about ReplicatedBackend::start_pushes
Date: Tue, 20 Oct 2015 07:13:58 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510200711580.16833@cobra.newdream.net>
References: <0C3F6DA3760D0C4691E69E5BE224FF495E15F76A@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51851 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbbJTOOB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 20 Oct 2015 10:14:01 -0400
In-Reply-To: <0C3F6DA3760D0C4691E69E5BE224FF495E15F76A@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "yangruifeng.09209@h3c.com" <yangruifeng.09209@h3c.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 20 Oct 2015, yangruifeng.09209@h3c.com wrote:
> Hi Sage?
> 
> In the following function, we can ensure is_missing(soid) is equal with is_missing(soid, primary_have_version) ?
>
> int ReplicatedBackend::start_pushes(
>   const hobject_t &soid,
>   ObjectContextRef obc,
>   RPGHandle *h)
> {
>   ...
>   for (set<pg_shard_t>::iterator i =
> 	 ...
>     if (j->second.is_missing(soid)) {            <---------------------------------
>       ++pushes;
>       h->pushes[peer].push_back(PushOp());
>       prep_push_to_replica(obc, soid, peer,
> 			   &(h->pushes[peer].back()), h->cache_dont_need);
>     }
>    ...
> }
> 
> In my environment, we got a assert, but no more infomation:
> osd/ReplicatedPG.cc: In function 'virtual void ReplicatedPG::on_local_recover(const hobject_t&, const object_stat_sum_t&, const ObjectRecoveryInfo&, ObjectContextRef, ObjectStore::Transaction*)' thread 7fa379c14700 time 2015-08-28 17:56:08.194843 osd/ReplicatedPG.cc: 211: FAILED assert(is_primary())

This looks like

	http://tracker.ceph.com/issues/13111

I really don't think we should be seeing this assert fail.  I would like 
to see logs before making changes... hopefully this is something you can 
reproduce with logging?  (debug osd= 20, debug ms = 1)

Thanks!
sage
