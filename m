Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A63B777C
	for <ceph-devel@vger.kernel.org>; Wed, 27 May 2026 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872357; cv=none; b=YJWcVNUSuS3QoRSf4X/xhpN6IZ5f2RyfXPwJIdhohxJAD6jfBpVqTr6MR1zpOFUGuQYXGdP54GQV4zcY8rFfivJve/aQrpMZ2a34SUu6Ig9Gv9wOKOVyXQbTTyZ/yUPu4wQ6ME2Mr7VEUaacf3AquYp+o0tDrHXizWBUSqGJGp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872357; c=relaxed/simple;
	bh=wt20C9F7iEE4Swxy+x6nXe05s8kFho3jePBzbFxhjdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOdjv90e2lC+8yPCd0LQK7248rxGUxpFSHn2LtEOJ5yAliWN5VtcSXnbl6C8eJQd+Gk4V+Q6a3179PW60YauHPvJvToLJ/R5DQafanqiQp/hiH20jTrC4bxq64YyhjocqSr/jIQeHLPICGknNmsuJ5TVIpmxtVM0uXfebTiPtgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=xtB6taZk; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="xtB6taZk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1779872347; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=wt20C9F7iEE4Swxy+x6nXe05s8kFho3jePBzbFxhjdI=;
 b=xtB6taZk+ZBFUUX+R5KsY0fG9AUYs/f7eni0sEmKsJbsSr+Tl7z+sfkpINvIJcQUI+oCV
 Z/IbgbmieshcuLN7pHPOPB/cx2sdb93nDKp/YIvSJhiCkAWOOUBqKWMTBLBOAO4VqImu/6v
 UYiH3yuT1M8AARO1Z/MkDHB9WYTOrGG6ELT1SXtdhUpLHCc36pHVlQuTbe77HJdQFcifuP1
 yTTxf/YnZQUGxvCk4c3Vw6s6DBTbqDD9gWHq/mK1jxWhI3w/nLcW3Jvxvv47ZEpzEFh1o2B
 ry/1GHwyU7zlQwj6xr1H58dfESxV5y47dM0OAB4ufon3XW/kkH2XmufLomIw==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 14AF65FC52;
	Wed, 27 May 2026 10:59:06 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 9779A5FC99;
	Wed, 27 May 2026 10:59:06 +0200 (CEST)
Message-ID: <d2c60213-a6c1-4caf-980a-575b1c43fcb9@tu-ilmenau.de>
Date: Wed, 27 May 2026 10:59:06 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libceph: Reject monmaps advertising zero monitors
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze
 <amarkuze@redhat.com>, "slava@dubeyko.com" <slava@dubeyko.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
References: <20260522154420.3324836-1-raphael.zimmer@tu-ilmenau.de>
 <502b1825d71f4ec870b64ec8257946a916bb0fee.camel@ibm.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <502b1825d71f4ec870b64ec8257946a916bb0fee.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.05.26 8:30 PM, Viacheslav Dubeyko wrote:
> On Fri, 2026-05-22 at 17:44 +0200, Raphael Zimmer wrote:
>> A message of type CEPH_MSG_MON_MAP contains a monmap that is sent from a
>> monitor to the client. This monmap contains information about the
>> existing monitors in the cluster. Currently, a monmap indicating that
>> there are zero monitors in the cluster is treated as valid. However, it
>> is impossible to have zero monitors in the cluster and still receive a
>> valid monmap from a monitor. Therefore, such a monmap must be corrupted
>> and should be treated as invalid. Furthermore, a monmap with a monitor
>> count of zero can subsequently crash the client when attempting to open
>> a session with a monitor in __open_session(). This happens because the
>> "BUG_ON(monc->monmap->num_mon < 1)" assertion in pick_new_mon() is
>> triggered.
>>
>> This patch extends a check in ceph_monmap_decode() to also reject
>> arriving mon_maps with num_mon == 0 rather than only with
>> num_mon > CEPH_MAX_MON.
>>
>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>> ---
>>  net/ceph/mon_client.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
>> index d2cdc8ee3155..6c5f83379055 100644
>> --- a/net/ceph/mon_client.c
>> +++ b/net/ceph/mon_client.c
>> @@ -114,7 +114,7 @@ static struct ceph_monmap *ceph_monmap_decode(void **p, void *end, bool msgr2)
>>  
>>  	dout("%s fsid %pU epoch %u num_mon %u\n", __func__, &fsid, epoch,
>>  	     num_mon);
>> -	if (num_mon > CEPH_MAX_MON)
>> +	if (num_mon > CEPH_MAX_MON || num_mon == 0)
> 
> The patch makes sense. But, I think we need to reverse the order:
> 
> if (num_mon == 0 || num_mon > CEPH_MAX_MON)
> 
> It will look like more reasonable, from my point of view. What do you think?
> 

I think it may look somewhat cleaner this way. Since there isn't really
any functional difference, I can reverse the order as suggested.

> As far as I can see, usually, Ceph cluster has odd number of monitors (3, 5,
> etc) and not only one. I am thinking should we share some message in system log
> if it is not so? What do you think?
> 

I'm not sure about this. What would be the reason for it? If there is
only one or an even number of monitors in the cluster, that's something
that should be seen from the cluster and managed there if necessary. So
we are talking about a corrupted monmap as considered in this patch.
Claiming there are zero monitors has an actual impact, as it may crash
the client. A non-zero value is valid and can be handled. If a monitor
lies and announces a different number of monitors than are actually
present, this can have some consequences. A log message could be helpful
in detecting it. But a monitor can also announce a wrong number that is
still odd. And if there is actually an even number of monitors, we
create additional useless log output.
Which log level did you have in mind?

Best regards,
Raphael
