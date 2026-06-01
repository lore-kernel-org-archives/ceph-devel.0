Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCAC3D76
	for <ceph-devel@vger.kernel.org>; Mon,  1 Jun 2026 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298876; cv=none; b=o+3Y8Xk8iVQYHMmMiytqtmqMB8N+rS1WsX4jFJdaJHMoyx0hyJfWSrZBiP9+oy7yagKPVtsmBra4y4ry9h0EYZcLvyGamlFidqdAHO9cMSYUDUx3dJywQ2F6F9UhuA0JIxORRJKSQJdCKPgReN2R0OkMRUg6bkm6WYWKlnu2kTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298876; c=relaxed/simple;
	bh=mT6jsyBPOPOEHmCRASklBjxxuf03hwNfi4RPCLL2cPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p02Hw+cjOZv+vp5O7k7gW6sYp4J6MGKyZx3LQv+01e1INJRpP64rxNlbl+B9okh9OOsWRX3/oWJZXfTc2JEioXiqUwroxxLvcDfXSteirqxoqdg0J/ETn9T1P6TCrhO+ZWTtxmK2X3hNjNgvDy8/VKPttKVHzv9qJ7ZK4dT8mgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=wvGMLpzO; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="wvGMLpzO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1780298865; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=mT6jsyBPOPOEHmCRASklBjxxuf03hwNfi4RPCLL2cPM=;
 b=wvGMLpzO+JoX+Dxe2QgLsYzBnZ4B1eLptum9S5DFiBv3lEEoxnab5Ye111qtzfzhxTpXP
 bxEGkAs74b+PAgoE06kEyX1xVOI3FCBjz61/wZ6vGy3il6S9aG4EJInmNGfRQU7U5Pg3uR+
 eGimUVSEmsnLsA/Ng/9MvtOIsJe2+qop4BKHeZnxUzF7VUCyHa/0DTzLCnWhRrFkGPtpMJk
 I8W5/+GghHD04EX4mTWSw4YuXMVeHTdiwCXe7b2AeFoaoUZ0YwHtLR87zGeSECANntKWFUZ
 sfGaBgJOMvYyzlWyv2oBglfplYkJhKKUcTnqNehA61GSYXBLRw/3zkn32JFQ==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 297605FC52;
	Mon,  1 Jun 2026 09:27:44 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 82FDE5FCAC;
	Mon,  1 Jun 2026 09:27:44 +0200 (CEST)
Message-ID: <93a0d6bf-31e5-43af-b20c-70f655b17094@tu-ilmenau.de>
Date: Mon, 1 Jun 2026 09:27:44 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] libceph: Handle rbtree insertion error in
 handle_backoff_block()
To: Viacheslav Dubeyko <vdubeyko@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
References: <20260529082242.3726491-1-raphael.zimmer@tu-ilmenau.de>
 <e02e1e589b3f77902435e5b062b60d1f419b8624.camel@redhat.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 xsJuBGbf7WYRCAC13DYHSN7ycNggRRKRCt984XSwMykhmw+BxsUfkZiDfWoSimWx5VZB1a4L
 7Tx20uE8iJKiTKZjBZyehk1sly3pbR7/Uqdx43vql2ZRVKYSJSoh9sKlfM178INqc2Vfwm7z
 ObExfJ5WZYAnxVKISBEt1c9q416E8gGYIrVwhMMTBrUF0iNTSoagIcVwJF5gY8LChqcW9S7p
 NQI1k5ISXul9QCEAZxd5bLU5BEx3SFZHvwOv9HN1OPkCBYf5FR3vDt/j8aIhVcHBVR5pbbvw
 5qqsN6/5W8f1nofCF5qu4xv1KRIvbWV4KhRN2e/G1zy3aWP0Eet+YZTFQtOMEVVePSGfAQCS
 +Zvxf1BPEjd+NdDK5N63ITc1bfSF9OdglK/6kpopLQf/YD9p9OE+smNAHrvnGnLBELtXdT+3
 SH7uKzvoeP3YKYRANzzwZt3GP/LugM+YJiyWbNCIEgDvMuEX+UGvsMtlc9ORL01idE6RwbYO
 Z9vvIfUjLr4iUfhmWBb3+9Lzp7xC5XmjxLFMTvxOSjf9jSSsHsk0nmYFLJ1lvb4BvlexQHJm
 voIn9d9eeDFb416HK81rvF0dkHsvAT37pOxlglZnsPei34R6OTVTtbxKi84nL7gCHa5PI73r
 5SZUYZB4SioPJhvtHzeUNzJn15VBnhthD8VpkQCOhrXAUpP9A0SB7BCcx6J08ZjTQo4kiio3
 Ve4xm5Y6rmEX+9TZSi5XAyJ4SAf+PIhfjkXrEpbaYzh8wcPE5gB6Fbbe/0bpjt4+e8uxHz5A
 N3yvrQZtcVca7Zh5LaT6/1aJl6w+2h4D8gP23PMSMrdAMRhmUvjUzwdePupj1/TB1QDaIDM2
 8QCrgBFQk3ToU0pEl5veQ8vqgxWNxQZT95aIN6WR2I4hxREG+QBdyP2XLKY/NGnXJsr+CF0u
 wd863H0ES1AJzy5d9BkcVujcvYDgTW8iEoU4FxJncvUASuyB1sTDrr/gvpVbEe4vl19/Dr9U
 VQ2LLCu2vZvKYGpgUJfcmE1NdDlothLnXmJBNyt8pNYGUDRbuwQ87wMGHCtrFEwJ4pOthi89
 dCr1DaxlC80tUmFwaGFlbCBaaW1tZXIgPHJhcGhhZWwuemltbWVyQHR1LWlsbWVuYXUuZGU+
 wpAEExEIADgWIQR22ZuMUxbN1mZz71M9DZlLGW5CZQUCZt/tZgIbAwULCQgHAgYVCgkICwIE
 FgIDAQIeAQIXgAAKCRA9DZlLGW5CZcxJAP0auhPMmCHeBGIYKaN9ZiWIz6+Y/H78jslypEJ4
 KXaCVAD9HerY+wwfFSNqtomWBZNiy6fp9pmep7ge70HIoKs0PRXOwU0EZt/tZhAIAM5w4a4O
 rFIYXDKuTYct59SYNR48lFL71ENNfbMV7ulu8Xa1GXcgTnZGrMkc6LiNSeki4hV+zIkHClEE
 ESyWytIfTu1xqNJJ73AeWqHPLc3u1Jk9NYQIrCTD5yM+E+xdu5ugT4I7oBRaSd2o10ichv0s
 Z/N3D5RMFYHOMOWawCSBE1vhaaVgNbtmcWZVzVltXeXKwpgNucsBLC0KBlBYfrO2bxbUJOGl
 2/E0EmXfoV7nia6EiW0v/R5KdUufdob8jzNNCWl9Vp10PiQ5EjfQuDNdZ61wjLyte3K4Vbm8
 cWECU/fCGrg33uN4N8NXsYo9ZfW5sNdhnRk8EzXao149axMAAwUH/2/25sC5qo0+6p27N74W
 QggRrmVJgiewT58qSB8ygzSBLROUrRCiseOKPek/T2JdcW6g6zRz+QGHDCh9wW8JDin0RkxP
 5jt8Xg5PPwahybAGY1YNPEbQnVTtqQoBo3eCtDAfezitHlY6NFsqNBoyTV00Ex1N7lh+SQwK
 4aRaQLzGBak/Z8M+tXrr/YSy003vA2nMwtrtw/eDtmPwrf0k+d0pHxcA4uzA8P2HMvtsBboG
 Fxn9/+UcEoQDDG7gdsMWl3pKQUAC9VLoos+zoqdV+ZUuWgOQvmF6bSEHaSPqQtSlRFrMZrk2
 34trtXRwZ01FMY+gDNJ2mNbGaVFEMtc93pfCeAQYEQgAIBYhBHbZm4xTFs3WZnPvUz0NmUsZ
 bkJlBQJm3+1mAhsMAAoJED0NmUsZbkJlG4EA/2mxLyHTXwvYnXfwm5Pz0DkpSaGFkPK8i1fU
 ZE1wCR13AP9CWbNf5w1p7sE4muaP2NRCQaG9mdOWsCM7mRnNmH6MiA==
In-Reply-To: <e02e1e589b3f77902435e5b062b60d1f419b8624.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.05.26 10:41 PM, Viacheslav Dubeyko wrote:
> On Fri, 2026-05-29 at 10:22 +0200, Raphael Zimmer wrote:
>> A message of type CEPH_MSG_OSD_BACKOFF is used to block/unblock requests
>> to specific PGs or objects. If this message has op code
>> CEPH_OSD_BACKOFF_OP_BLOCK, handle_backoff_block() is called to block
>> requests. In this function, a backoff struct is created and inserted
>> into two rbtrees for tracking them. Both insertions use the asserting
>> rbtree insertion function by calling insert_backoff(), respectively
>> insert_backoff_by_id(). If a message contains a backoff with the same
>> begin ceph_hobject_id or the same id as a previous one, the assertion in
>> insert_backoff()/insert_backoff_by_id() triggers a kernel BUG when
>> trying to insert the backoff.
>>
>> This patch fixes the issue by switching both calls to the non-asserting
>> rbtree function and ignoring the message if one of the insertions fails.
>>
>> Fixes: a02a946dfe96 ("libceph: respect RADOS_BACKOFF backoffs")
>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>> ---
>>  net/ceph/osd_client.c | 22 ++++++++++++++++++++--
>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> index 2ff00070c181..482b89009649 100644
>> --- a/net/ceph/osd_client.c
>> +++ b/net/ceph/osd_client.c
>> @@ -4427,8 +4427,16 @@ static void handle_backoff_block(struct ceph_osd *osd, struct MOSDBackoff *m)
>>  	backoff->end = m->end;
>>  	m->end = NULL;   /* ditto */
>>  
>> -	insert_backoff(&spg->backoffs, backoff);
>> -	insert_backoff_by_id(&osd->o_backoffs_by_id, backoff);
>> +	if (__insert_backoff(&spg->backoffs, backoff)) {
>> +		pr_err_ratelimited("%s failed to insert backoff\n", __func__);
>> +		goto err_free_backoff;
>> +	}
>> +
>> +	if (__insert_backoff_by_id(&osd->o_backoffs_by_id, backoff)) {
>> +		pr_err_ratelimited("%s failed to insert backoff by id\n",
>> +				   __func__);
>> +		goto err_erase_backoff;
>> +	}
> 
> I just realized that these checks have incorrect logic. We need to check that
> __insert_backoff() and __insert_backoff_by_id() are failed:
> 
>   if (!__insert_backoff(&spg->backoffs, backoff)) {
>       pr_err_ratelimited("%s failed to insert backoff\n", __func__);
>       goto err_free_backoff;
>   }
> 
>   if (!__insert_backoff_by_id(&osd->o_backoffs_by_id, backoff)) {
>       pr_err_ratelimited("%s failed to insert backoff by id\n", __func__);
>       goto err_erase_backoff;
>   }
> 
> Am I right here?
> 

Of course, that's what it's meant to be. I somehow missed the "!".
Thanks for pointing it out.  I'll send a corrected patch.

Best regards,
Raphael

