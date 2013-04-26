From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: placement group sizing
Date: Fri, 26 Apr 2013 08:17:48 -0500
Message-ID: <517A7E7C.8070602@inktank.com>
References: <02E999F2-8374-4D47-88DC-D8DC30547068@saaby.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:56573 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561Ab3DZNRp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 09:17:45 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so4916897iee.34
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 06:17:45 -0700 (PDT)
In-Reply-To: <02E999F2-8374-4D47-88DC-D8DC30547068@saaby.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anders Saaby <anders@saaby.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/25/2013 07:39 AM, Anders Saaby wrote:
> Hi,
>
> We are working on prototype infrastructure for RADOS clusters, and are now ready to deploy the first production size storage pool. One question remains; How many placement groups will we need, balancing memory footprint and ability to level data placement and data reads. - And still keeping stuff within sane limits.
>
> Our initial plan is to deploy 4PB pools, based on 4TB drives with 3 replicas (One OSD/disk). So, 3.000 disks per pool.
>
> Acording to the documentation 1), we should have: 3.000 OSDs * 100 / 3 replicas == 100.000 placement groups.
>
>  From the maillist, 100.000 PG's is way more than I have seen, so, do you have any insights and advises on pg_num for a RADOS pool with these characteristics? Also, will it be a problem with a pg_num size this bit, if the pool is started out with only ~100 OSDs, and then grown to 3.000.

I pretty regularly test single-mon configurations with 64k PGs.  ~100k 
PGs tends to be starting to get a bit intense, but with a larger mon 
cluster and some tweaking it should be doable.

I don't mean to push anything on you, but if you guys are really 
thinking about deploying multiple 4PB pools, you might want to talk to 
us about some kind of support/consulting agreement.  That's a lot of 
storage!

Mark

>
>
> Thanks in advance,
> Anders
>
> 1: http://ceph.com/docs/master/rados/operations/placement-groups/
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

