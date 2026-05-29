Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2782E3AB29D
	for <ceph-devel@vger.kernel.org>; Fri, 29 May 2026 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040059; cv=none; b=HWxlyzxbuiMu0HYUQCyh6YiHyIB6jnjBU9lQtrNXR2wzHw752GrYFRzmRRFwpNT65LfDStg5ynKnP5TfPutn51tuljIJoC8OnKn3zHQWRYiUO7yiOmJPknPpf6Ll5kMyBVa452oOE/EfHsOXLWMWgvAI+wcpjXl/9jtVnoqAAvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040059; c=relaxed/simple;
	bh=Et85y0hqz1XEoDqllDZI/lilp4Ai9j9INA8La77fXmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBw22Ys0f6MxBQzWjq+JbL9a345OgPh7M1G2q4z2nWIBCaFVWsyZu6b/UbZJ9e7Rm7W9fLR9QCINIRBrPi2hZLSazATJI9REFU4+2Ctrr/bIDRxo1yp8QSqxVLLY0za+oJ8nAqk6Qu1gvKxbEnJKQ18bsk16A2JFc/0Ndv8vVTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=X28q+gwT; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="X28q+gwT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1780040053; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=Et85y0hqz1XEoDqllDZI/lilp4Ai9j9INA8La77fXmU=;
 b=X28q+gwT60cyBS7thL2a28dGFpdblsKMzhMgVdbA90LlVnZgPm8EVsPQdiZDxm4LKKWzF
 dPK4Wvx7u2huHWjLOcAgK4Q6YbTCPF9/jKCxpjTOgFbGyU88F2y1Kb12rQU3sRSoevjGhUt
 q9cSgeBwA/E37RNHNzTHShZK0Y+kzyv33DoE6sKBO0cwGN2/d9T1uxPYLoaHb360auw0rWO
 du0jITNwdBkjyNHB57KM3sQ6eypy/STyHcq4mjgGLKDsaA52k6fAYS/46qPjVBNHEybWN1M
 u9G0KzmoWeZtSY52RJ446jmcz8I9as7gcJEGdadRXwYdv5KkWFhRMNIMXD+g==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 852685FA24;
	Fri, 29 May 2026 09:34:13 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 28D8E5FC96;
	Fri, 29 May 2026 09:34:12 +0200 (CEST)
Message-ID: <2d810551-dd73-4e99-b2e2-2dfffc1e03e2@tu-ilmenau.de>
Date: Fri, 29 May 2026 09:34:11 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] libceph: Reject monmaps advertising zero monitors
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze
 <amarkuze@redhat.com>, "slava@dubeyko.com" <slava@dubeyko.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
References: <20260528080023.3634455-1-raphael.zimmer@tu-ilmenau.de>
 <3954b88a1354b96d65a88a379daed3cc53e3d88f.camel@ibm.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <3954b88a1354b96d65a88a379daed3cc53e3d88f.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28.05.26 8:36 PM, Viacheslav Dubeyko wrote:
> On Thu, 2026-05-28 at 10:00 +0200, Raphael Zimmer wrote:
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
>> num_mon > CEPH_MAX_MON. Additionally, a log output is added for unusual
>> values of num_mon.
>>
>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>> ---
>>  net/ceph/mon_client.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
>> index d2cdc8ee3155..461a9caa7609 100644
>> --- a/net/ceph/mon_client.c
>> +++ b/net/ceph/mon_client.c
>> @@ -114,9 +114,13 @@ static struct ceph_monmap *ceph_monmap_decode(void **p, void *end, bool msgr2)
>>  
>>  	dout("%s fsid %pU epoch %u num_mon %u\n", __func__, &fsid, epoch,
>>  	     num_mon);
>> -	if (num_mon > CEPH_MAX_MON)
>> +	if (num_mon == 0 || num_mon > CEPH_MAX_MON)
>>  		goto e_inval;
>>  
>> +	if (num_mon == 1 || (num_mon & 1) == 0)
>> +		pr_notice("received monmap with unusual num_mon %u\n",
>> +			  num_mon);
> 
> Maybe, we need to consider pr_notice_ratelimited(). The patch looks good.
> 

That sounds like the better choice. I will send another version with
pr_notice_ratelimited().

>> +
>>  	monmap = kmalloc_flex(*monmap, mon_inst, num_mon, GFP_NOIO);
>>  	if (!monmap) {
>>  		ret = -ENOMEM;
> 
> Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> 
> Thanks,
> Slava.

