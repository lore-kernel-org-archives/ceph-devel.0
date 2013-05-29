From: Wido den Hollander <wido@42on.com>
Subject: Re: Finding out via librados if a cluster is near full
Date: Wed, 29 May 2013 10:24:18 +0200
Message-ID: <51A5BB32.3040806@42on.com>
References: <51A5B8EE.5070801@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:53985 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964992Ab3E2IYT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 May 2013 04:24:19 -0400
Received: from [IPv6:2a00:f10:113:0:e9:af4b:b4bc:3103] (unknown [IPv6:2a00:f10:113:0:e9:af4b:b4bc:3103])
	by websrv.42on.com (Postfix) with ESMTPSA id 98419C181C
	for <ceph-devel@vger.kernel.org>; Wed, 29 May 2013 10:24:18 +0200 (CEST)
In-Reply-To: <51A5B8EE.5070801@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/29/2013 10:14 AM, Wido den Hollander wrote:
> Hi,
>
> Is there a way to find out if a cluster is near full via librados?
>

Yes, there is. (Thanks tnt on IRC!)

There is ofcourse rados_cluster_stat which will give you:

struct rados_cluster_stat_t {
   uint64_t kb, kb_used, kb_avail;
   uint64_t num_objects;
};


One thing here is however that you don't know to what the (near)full 
ratio has been set to. So you have to do your own guessing.

> The reason I'm asking is that I'm working on a deployment of the RADOS
> Gateway and one of the potential problems I see is that the RADOS
> Gateway can keep writing and filling up the whole cluster.
>

So, with the cluster stat information we could implement:

rgw_refuse_write_above_ratio DOUBLE 0.90

> It's obvious that it's the admin's responsibility to make sure that
> doesn't happen, but what I'd like to do is make the RADOS Gateway deny
> PUT requests when the cluster is near full.
>
> That way normal meta data operations (thus writes) can continue, but new
> objects won't be accepted until the cluster has enough space available.
>
> This might also be useful for librbd. Refuse the creation of new RBD
> images so that existing images can continue operating.
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
