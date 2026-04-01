Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668B361647
	for <ceph-devel@vger.kernel.org>; Wed,  1 Apr 2026 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775074523; cv=none; b=mo+MBXVgH4Qva0i/jX1lVb8+F4PwAZb8farVFG9hh9RKkcavimjwltI7pXmBS+/NADrPpYYqJLZy3iPKgk+RzXlGYUknwhIOoXLXMYO+l3vVV532rUpi/4+oM2cffdwZqGVgGo7uQKcAkoHfD/Yy1cIAaiSwRl5Off/8kArHfiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775074523; c=relaxed/simple;
	bh=+NyedGPq1rStLKQTmmwd8BAUj2lg28XfvNuBuGOQOeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7Iu1cAQgdjHaclU/0FDH7k6QYRhozwwtunw1d060BUdUUluV1Mad7ZRMp1hsSCiXBAh2GdvTU49itD8UZlQFO3lvKLBglx3ZxqwBi/mCtDc9/zzETueivaUHmYcUO3vcfxFHNbowjfSMF3rd57CqJox92oIbGapkO8sTRNe/Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=quZTdUct; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="quZTdUct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1775074517; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=+NyedGPq1rStLKQTmmwd8BAUj2lg28XfvNuBuGOQOeo=;
 b=quZTdUctqywjn/vemFfgcFVnDeV9V0stIZgalLnkXBwXE0peNNlGbqOEmZwbE+JDHhgHT
 jLrIa+PYXlst+RbtPRyUFm7d+nyjSb1z+8FmlA6v+A+ye1P55SBc+lAeIC/LokfjuNhJhXi
 zu/jflNpZdskN77oBgFRIWMIrW0FtjDB6qqoFCejSoGDsvi49Y/v9NUpd8+bfgsmojCSani
 5uT68f24nqbJw6pP1Ml5Y0Rs1lB7ZhbFZyGKirdOQJEo/0yyi58JEhes1puQWgcTjcCxmwG
 R8cGjAnm2iF20Lx8jCafSyWOyw4otwopGKziQEFYxt6W8i7sOWf1LbB1/Pvg==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 8BF485FF0A;
	Wed,  1 Apr 2026 22:15:17 +0200 (CEST)
Received: from [192.168.178.114] (unknown [217.252.212.162])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id DA14F5FCBA;
	Wed,  1 Apr 2026 22:15:16 +0200 (CEST)
Message-ID: <264caf34-2b06-4dda-9c8b-a1e46d940621@tu-ilmenau.de>
Date: Wed, 1 Apr 2026 22:15:16 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re:[PATCH] libceph: Fix potential out-of-bounds access in
 crush_decode()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze
 <amarkuze@redhat.com>, "slava@dubeyko.com" <slava@dubeyko.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
References: <20260401135132.3642689-1-raphael.zimmer@tu-ilmenau.de>
 <513d275666da93b1430124955e515704361a43ec.camel@ibm.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <513d275666da93b1430124955e515704361a43ec.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/26 9:06 PM, Viacheslav Dubeyko wrote:
> On Wed, 2026-04-01 at 15:51 +0200, Raphael Zimmer wrote:
>> A message of type CEPH_MSG_OSD_MAP containing a crush map with at least
>> one bucket has two fields holding the bucket algorithm. If the values
>> in these two fields differ, an out-of-bounds access can occur. This is
>> the case because the first algorithm field (alg) is used to allocate
>> the correct amount of memory for a bucket of this type, while the second
>> algorithm field inside the bucket (b->alg) is used in the subsequent
>> processing.
>>
>> This patch fixes the issue by adding a check that compares alg and
>> b->alg and aborts the processing in case they differ. Furthermore,
>> b->alg is set to 0 in this case, because the destruction of the crush
>> map also uses this field to determine the bucket type, which can again
>> result in an out-of-bounds access when trying to free the memory pointed
>> to by the fields of the bucket.
>>
>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>> ---
>>   net/ceph/osdmap.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>> index c89e66d4fcb7..daae4230bf38 100644
>> --- a/net/ceph/osdmap.c
>> +++ b/net/ceph/osdmap.c
>> @@ -516,6 +516,10 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
>>   		b->id = ceph_decode_32(p);
>>   		b->type = ceph_decode_16(p);
>>   		b->alg = ceph_decode_8(p);
>> +		if(b->alg != alg) {
> 
> The Linux kernel coding style requires to have a space:
> 
> if (b->alg != alg)
> 
> Have you ran checkpatch.pl [1] before sending the patch? Usually, it can catch
> such issues.
> 
> Thanks,
> Slava.
> 

Hi Slava,
I already noticed that the space wasn't included in the patch, but 
unfortunately, only after sending it out. Then I didn't want to send two 
almost identical versions in a row without waiting for feedback that may 
also need to be incorporated. Nevertheless, thanks for pointing this 
out. I try not to let this mistake happen again.

If you have any additional objections to this patch, please let me know. 
Otherwise, I will send a v2 tomorrow.

Best regards,
Raphael

>> +			b->alg = 0;
>> +			goto bad;
>> +		}
>>   		b->hash = ceph_decode_8(p);
>>   		b->weight = ceph_decode_32(p);
>>   		b->size = ceph_decode_32(p);
> 
> [1] https://elixir.bootlin.com/linux/v7.0-rc6/source/scripts/checkpatch.pl

