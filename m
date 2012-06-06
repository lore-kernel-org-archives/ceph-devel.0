From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH v2 1/3] libceph: fix overflow in __decode_pool_names()
Date: Wed, 6 Jun 2012 13:54:43 -0400
Message-ID: <3035A1C4-C66F-41F7-AA9B-7331F0ACA750@gmail.com>
References: <1335682765-1643-1-git-send-email-xi.wang@gmail.com> <4F9CE8A0.80306@gmail.com> <4FCF849F.7000704@dreamhost.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:48732 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757633Ab2FFRys convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 13:54:48 -0400
Received: by gglu4 with SMTP id u4so5224375ggl.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 10:54:48 -0700 (PDT)
In-Reply-To: <4FCF849F.7000704@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elder@inktank.com
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Jun 6, 2012, at 12:26 PM, Alex Elder wrote:
>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>> index 29ad46e..f80afc3 100644
>> --- a/net/ceph/osdmap.c
>> +++ b/net/ceph/osdmap.c
>> @@ -495,15 +495,12 @@ static int __decode_pool_names(void **p, void *end, struct ceph_osdmap *map)
>> 		ceph_decode_32_safe(p, end, pool, bad);
>> 		ceph_decode_32_safe(p, end, len, bad);
>> 		dout("  pool %d len %d\n", pool, len);
>> +		ceph_decode_need(p, end, len, bad);
>> 		pi = __lookup_pg_pool(&map->pg_pools, pool);
>> 		if (pi) {
>> 			kfree(pi->name);
>> -			pi->name = kmalloc(len + 1, GFP_NOFS);
>> -			if (pi->name) {
>> -				memcpy(pi->name, *p, len);
>> -				pi->name[len] = '\0';
>> -				dout("  name is %s\n", pi->name);
>> -			}
>> +			pi->name = kstrndup(*p, len, GFP_NOFS);
>> +			dout("  name is %s\n", pi->name);
> 
> Instead:
> 		if (pi) {
> 			char *name = kstrndup(*p, len, GFP_NOFS);
> 
> 			if (!name)
> 				return -ENOMEM;
> 			kfree(pi->name);
> 			pi->name = name;
> 			dout("  name is %s\n", pi->name);
> 		}

Looks good to me.  Thanks!

Do you want me to send another patch?

- xi

