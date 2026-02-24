Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F012E2DFB
	for <ceph-devel@vger.kernel.org>; Tue, 24 Feb 2026 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968565; cv=none; b=a+CvtSbDYblSCZa/1NlVe3gDK3HN+mqoxUGjJS0/Ro5G2eYAMba4KoafDV6xGzWdnr6mVuPQ7uJ+rU1dXfnYx3IF/0CYGtRThtBYEol/vU4OCRvRN7LLMQ/92k0jin5N+3kSIsIlhrpmUXS4Mf9lVdjNk5YjTEH1vbcE65FYxT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968565; c=relaxed/simple;
	bh=CXsyInkQvXINtNBXok+B1sXABCB2UqLeM3rug4f2yRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGnpD7iIQkDpKxjEBuV/nIGfpflfQyFWARo8VLw4OyLwOUhZ5kQUEuTzO5jZjaFziRPyCcG3exS1PhAUd9WFVMIUxrD8vBleqe51IKSLd29OQLEWkaZyaKcfaO9aZQGJqkH1JIyh6xZGC/ppbIp/TxmjriB5PljxrT6xAKZodxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=CocKkk9B; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="CocKkk9B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1771968560; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=CXsyInkQvXINtNBXok+B1sXABCB2UqLeM3rug4f2yRo=;
 b=CocKkk9BuigZnF1aoxI26HZKieQ4GecMQnpDQoK8dyoAE/2CU6AHZ1QY87F+N76raij3+
 ushjlNYYhtIC39bB0ClWOU73jSko4uIRo9TXFWD1fkN0xQbGm2H44YFItvxABnZhitgRZq3
 dm+rBHvn3JiK8RPF+WRTt55ePvFwJ0T4/JZ/S6MYj3fBx18kczKYQsyrafWDH1CV+D/utT9
 5xpeA8H3cjy4ha+1zwgodhJ6x0D/+wHyJ7JVKQZQQNELmp7Yqil5dgsWrtSnKq7ZoeRZiFy
 vTSkauFWllii2aA6nieNCyZVRiIRE2bA0lrJwwI+SzGpY/nM26GDaAvjGzgA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 36EE260198;
	Tue, 24 Feb 2026 22:29:20 +0100 (CET)
Received: from [192.168.178.114] (unknown [217.252.212.162])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 602195FB23;
	Tue, 24 Feb 2026 22:29:19 +0100 (CET)
Message-ID: <fd907fc2-8449-4576-82ec-43a8be28cc3a@tu-ilmenau.de>
Date: Tue, 24 Feb 2026 22:29:18 +0100
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libceph: Use u32 for non-negative values in
 ceph_monmap_decode()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze
 <amarkuze@redhat.com>, "slava@dubeyko.com" <slava@dubeyko.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
References: <95b6e21f-0bfd-4d39-93c1-757f3706590f@tu-ilmenau.de>
 <03568ee4e42923e939a77b7d04244070122d89bd.camel@ibm.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <03568ee4e42923e939a77b7d04244070122d89bd.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/26 8:31 PM, Viacheslav Dubeyko wrote:
> On Tue, 2026-02-24 at 16:38 +0100, Raphael Zimmer wrote:
>> This patch fixes unnecessary implicit conversions that change signedness
>> of blob_len and num_mon in ceph_monmap_decode().
>> Currently blob_len and num_mon are (signed) int variables. They are used
>> to hold values that are always non-negative and get assigned in
>> ceph_decode_32_safe(), which is meant to assign u32 values. Both
>> variables are subsequently used as unsigned values, and the value of
>> num_mon is further assigned to monmap->num_mon, which is of type u32.
>> Therefore, both variables should be of type u32. This is especially
>> relevant for num_mon. If the value read from the incoming message is
>> very large, it is interpreted as a negative value, and the check for
>> num_mon > CEPH_MAX_MON in line 117 does not catch it. This leads to the
>> attempt to allocate a very large chunk of memory in line 120, which will
>> most likely fail. In this case, an unnecessary attempt to allocate
>> memory is performed, and -ENOMEM is returned instead of -EINVAL. For
>> consistency, the type of variable i is also changed to u32, as it is
>> also only used for non-negative values.
> 
> I agree that blob_len and num_mon should be u32 because it makes the code more
> consistent. But do we really need to change the i counter from int to u32? We
> are using this counter here [1]. And we check the num_mon here [2]. So, it
> cannot be bigger than 31 [3]. So, it's completely safe to use the integer data
> type for counter.
> 
> Thanks,
> Slava.
> 
Hi Slava,

I agree that it's completely safe to leave the i variable as integer. I 
included it because, for me, it looked more consistent to use the same 
data type for all variables that aren't supposed to take negative 
values. But if you think it shouldn't be changed without a specific 
reason, I can exclude it from the patch.

Best regards,
Raphael

>>
>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>> ---
>>    net/ceph/mon_client.c | 10 +++++-----
>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
>> index fa8dd2a20f7d..8ced3a9297b3 100644
>> --- a/net/ceph/mon_client.c
>> +++ b/net/ceph/mon_client.c
>> @@ -72,12 +72,12 @@ static struct ceph_monmap *ceph_monmap_decode(void
>> **p, void *end, bool msgr2)
>>           struct ceph_monmap *monmap = NULL;
>>           struct ceph_fsid fsid;
>>           u32 struct_len;
>> -       int blob_len;
>> -       int num_mon;
>> +       u32 blob_len;
>> +       u32 num_mon;
>>           u8 struct_v;
>>           u32 epoch;
>>           int ret;
>> -       int i;
>> +       u32 i;
>>
>>           ceph_decode_32_safe(p, end, blob_len, e_inval);
>>           ceph_decode_need(p, end, blob_len, e_inval);
>> @@ -112,7 +112,7 @@ static struct ceph_monmap *ceph_monmap_decode(void
>> **p, void *end, bool msgr2)
>>           }
>>           ceph_decode_32_safe(p, end, num_mon, e_inval);
>>
>> -       dout("%s fsid %pU epoch %u num_mon %d\n", __func__, &fsid, epoch,
>> +       dout("%s fsid %pU epoch %u num_mon %u\n", __func__, &fsid, epoch,
>>                num_mon);
>>           if (num_mon > CEPH_MAX_MON)
>>                   goto e_inval;
>> @@ -141,7 +141,7 @@ static struct ceph_monmap *ceph_monmap_decode(void
>> **p, void *end, bool msgr2)
>>                   if (ret)
>>                           goto fail;
>>
>> -               dout("%s mon%d addr %s\n", __func__, i,
>> +               dout("%s mon%u addr %s\n", __func__, i,
>>                        ceph_pr_addr(&inst->addr));
>>           }
> 
> [1] https://elixir.bootlin.com/linux/v6.19-rc5/source/net/ceph/mon_client.c#L130
> [2] https://elixir.bootlin.com/linux/v6.19-rc5/source/net/ceph/mon_client.c#L117
> [3]
> https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/ceph/ceph_fs.h#L35

