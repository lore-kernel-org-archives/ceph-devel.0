Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E1138236E;
	Mon, 20 Apr 2026 06:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776666614; cv=none; b=SQCQU5FT5AoKjXl+PQQkOqGSTP0dKqoFajQpJp+Wn/oHbDB8ddaIEkMQxS52mgQrUn0MCW4Q9gWQUdURiw5bIyH4OdvPUjYb4ycJsKlMpuF04bgrVke2TkGim5iixYXv+pqWfkZvB1Y5o05zQYHuwfVkSelcbNcfoUUvd2qzn1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776666614; c=relaxed/simple;
	bh=VldLjcwq4803Wd3UDjkxNT0hGPf6K0QO+zv2RTPaP+k=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=qv90FiZZCMlwnneYB4z7F0Zzn0UPxHUrjoSdRE1WeKTFZJ+oW6tApf6j1w4Gp6ar4GqviR5tHq/GVkEA/ZX1A4kT2ci/nJOoIUqG9K1qYDNVr6Z7tL2UVNtvcKbCOwDMOZoZHzirGTE4Pad5qMkrCE1GajXTivNU6A4DGgEjBCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=bn9Wi/D+; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="bn9Wi/D+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=/lJF0WfAFWy+64QqNE6bNXqxHb6cahtngw8tXYELF+U=;
	b=bn9Wi/D+Vq3PAkhnaHvJsWQRUBAjykhOiIqJxSciVkPjsGdCRWl7v7s1MtKBEn
	msskB6lmoImLgKtvKLuW3+xZL/bxmdWFhuBPyz/8EFME1fErMyz53PLEvWxPmpkg
	nyjYLscpC+J74lliGlY9HZwWnk63ceQxQf2YCgtfF2tmo=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnt2DLx+Vpn4WuCQ--.12531S2;
	Mon, 20 Apr 2026 14:29:31 +0800 (CST)
Message-ID: <69E5C798.8050705@126.com>
Date: Mon, 20 Apr 2026 14:28:40 +0800
From: nana <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
 "idryomov@gmail.com" <idryomov@gmail.com>,
 "zenghongling@kylinos.cn" <zenghongling@kylinos.cn>, 
 "slava@dubeyko.com" <slava@dubeyko.com>,
 Alex Markuze <amarkuze@redhat.com>, 
 "brauner@kernel.org" <brauner@kernel.org>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ceph: fix potential ERR_PTR dereference in ceph_submit_write()
References: <20260417080609.51361-1-zenghongling@kylinos.cn> <494716d7aa3fe860d89e19866fa3b59755183de8.camel@ibm.com>
In-Reply-To: <494716d7aa3fe860d89e19866fa3b59755183de8.camel@ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnt2DLx+Vpn4WuCQ--.12531S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1xZFykWw4UWF45GFyrtFb_yoW8ZFWUp3
	yUKayjyF1rZa4xtFsFga4rZ3WFkrsYvryayr1rKF42kF93XFZFyFyUGr9Igw47AF4xJryk
	tr1UAFZrXa4ayF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5eOJUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrwz4yWnlx8xKtgAA3p

  Hi  Slava
       You're correct: the fix doesn't make sense.The 
BUG_ON(IS_ERR(req))  ensures that req is a valid pointer, There is no 
code path that can skip the allocation code.

Thank you for your review.

在 2026年04月18日 01:48, Viacheslav Dubeyko 写道:
> On Fri, 2026-04-17 at 16:06 +0800, Hongling Zeng wrote:
>> Fix smatch warning:
>>   fs/ceph/addr.c:1489 ceph_submit_write() error: 'req' dereferencing possible ERR_PTR()
>>
>> Add a check to ensure req is not an ERR_PTR before calling
>> ceph_osdc_put_request().
>>
>> Fixes: 1551ec61dc55 ("ceph: improve error handling in writeback")
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>> ---
>>   fs/ceph/addr.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>> index fa4f25f99409..6091818674be 100644
>> --- a/fs/ceph/addr.c
>> +++ b/fs/ceph/addr.c
>> @@ -1468,7 +1468,8 @@ int ceph_submit_write(struct address_space *mapping,
>>   			unlock_page(page);
>>   		}
>>   
>> -		ceph_osdc_put_request(req);
>> +		if (!IS_ERR(req))
>> +			ceph_osdc_put_request(req);
>>   		return -EIO;
>>   	}
>>   
> I don't think that this fix makes sense. We create and check the request here
> [1]:
>
> 	req = ceph_osdc_new_request(&fsc->client->osdc,
> 				    &ci->i_layout, vino,
> 				    offset, &len, 0, ceph_wbc->num_ops,
> 				    CEPH_OSD_OP_WRITE, CEPH_OSD_FLAG_WRITE,
> 				    ceph_wbc->snapc, ceph_wbc->truncate_seq,
> 				    ceph_wbc->truncate_size, false);
> 	if (IS_ERR(req)) {
> 		req = ceph_osdc_new_request(&fsc->client->osdc,
> 					    &ci->i_layout, vino,
> 					    offset, &len, 0,
> 					    min(ceph_wbc->num_ops,
> 						CEPH_OSD_SLAB_OPS),
> 					    CEPH_OSD_OP_WRITE,
> 					    CEPH_OSD_FLAG_WRITE,
> 					    ceph_wbc->snapc,
> 					    ceph_wbc->truncate_seq,
> 					    ceph_wbc->truncate_size,
> 					    true);
> 		BUG_ON(IS_ERR(req));
> 	}
>
> So, it should be the valid request pointer when we called
> ceph_osdc_put_request(). Am I missing something?
>
> Thanks,
> Slava.
>
> [1] https://elixir.bootlin.com/linux/v7.0/source/fs/ceph/addr.c#L1421

