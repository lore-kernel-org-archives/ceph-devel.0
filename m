Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21F52EB87F
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412460; cv=none; b=suAmUdnK6epHVpkpC4icszJZuPe1Htnpki3kMUh1tCx88qDNRjeoWlL3SJMsn4ffxvyiye9HYUYtrBvIydZKVFXQVeO6ddGnP2vza2/3cpW6JanHl5qxpwuNTY4EyoExy+Iqhc9/u+C/cJ7jzoXuSpHr6dj7z+y5Iwn3G579MSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412460; c=relaxed/simple;
	bh=GlIwueelg5DnBlSgPAYbOalUUCyvcqeJcQ3QV6CtyxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzxHyNQUXS+nvRppjKOTmF+Uua/k7DiyobhBmpLSwJh75EEU9yLzhWBga+3KlRDkoBcEKBQk2nXj7nIDlSf2Afj7R+8CpyhDj460m6ukOiD9pbAJilWnf9kn1VjX5vWIjrQN2NxAsJCzLrLnA1lhYRPo3khW2CSupAjS3e0e5Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=SlDeR1w9; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="SlDeR1w9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1783412450; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=GlIwueelg5DnBlSgPAYbOalUUCyvcqeJcQ3QV6CtyxE=;
 b=SlDeR1w9Kps/GtLj9WMXNYnwso1ajDxTIYtZhJ8R9zd/Rdoo7oEkqaKuLr70yNsQdy8R1
 N7MCgA2pX3/gpANO+Af1YBhpY6096SiWLz9EehLNMM6ieP9xFY+mjpOqaLv6dAh9s2HlkOM
 oXMY4BoSq7eVBWq/fjRoIhlte4v8b1SUUr4C5FIeL8MXwOMYGdWo+CWUoxzaG7rWcTbcaLX
 xLjd5ZMZAQ2qHXDFYc/eAALwQfg7d7W/PQOYTsuWRIHwFtaSaqiwzxuvBiY48FtQgT00DYV
 r7ZDNV/nQI126jy+iad3Zr3xou5PrLJ7m8JoPa1Gnjxc+xyutHevvyFRY2WQ==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 3FDF35FB1A;
	Tue,  7 Jul 2026 10:20:50 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 16F395FAD6;
	Tue,  7 Jul 2026 10:20:49 +0200 (CEST)
Message-ID: <ee9ea781-398f-4aea-80ae-343899d45f0c@tu-ilmenau.de>
Date: Tue, 7 Jul 2026 10:20:49 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libceph: Reject osdmaps advertising pools of unsupported
 types
To: Viacheslav Dubeyko <slava@dubeyko.com>, Ilya Dryomov
 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
References: <07595980-b8aa-432b-bf1e-e21cb036bfb8@tu-ilmenau.de>
 <20260608151310.1061874-1-raphael.zimmer@tu-ilmenau.de>
 <a4b07ea74167dfb681c481bc21243b5e7e652472.camel@dubeyko.com>
 <de36d3583c1802a75af59da673dac65db4c878a6.camel@dubeyko.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <de36d3583c1802a75af59da673dac65db4c878a6.camel@dubeyko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11.06.26 6:07 AM, Viacheslav Dubeyko wrote:
> On Wed, 2026-06-10 at 20:53 -0700, Viacheslav Dubeyko wrote:
>> CC: ceph-devel@vger.kernel.org
>>
>> On Mon, 2026-06-08 at 17:13 +0200, Raphael Zimmer wrote:
>>> osdmaps are received over the network and typically contain
>>> information
>>> about existing pools. Information about each pool is decoded in
>>> decode_pool(). A pool is either replicated or erasure coded, which
>>> is
>>> encoded in the type field as an 8-bit value. Currently, any value
>>> in
>>> this field is treated as valid even though only two values have an
>>> actual meaning. If this field contains a value other than
>>> CEPH_POOL_TYPE_REP or CEPH_POOL_TYPE_EC, a BUG() assertion in
>>> ceph_can_shift_osds() can be triggered subsequently. This happens
>>> the
>>> next time calc_target() is called for a request in this pool.
>>>
>>> This patch fixes the issue by adding a check that verifies the pool
>>> type
>>> directly during decoding and rejecting osdmaps that contain invalid
>>> values.
>>>
>>> Fixes: 4f6a7e5ee139 ("ceph: update support for PGID64, PGPOOL3,
>>> OSDENC protocol features")
>>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>>> ---
>>>  include/linux/ceph/rados.h | 5 +++++
>>>  net/ceph/osdmap.c          | 4 ++++
>>>  2 files changed, 9 insertions(+)
>>>
>>> diff --git a/include/linux/ceph/rados.h
>>> b/include/linux/ceph/rados.h
>>> index 73c3efbec36c..5b5c33845301 100644
>>> --- a/include/linux/ceph/rados.h
>>> +++ b/include/linux/ceph/rados.h
>>> @@ -86,6 +86,11 @@ struct ceph_pg_v1 {
>>>  #define CEPH_POOL_TYPE_RAID4   2 /* never implemented */
>>>  #define CEPH_POOL_TYPE_EC      3
>>>  
>>> +static inline bool ceph_pool_type_is_supported(__u8 type)
>>> +{
>>> +	return type == CEPH_POOL_TYPE_REP || type ==
>>> CEPH_POOL_TYPE_EC;
>>> +}
>>> +
>>>  /*
>>>   * stable_mod func is used to control number of placement groups.
>>>   * similar to straight-up modulo, but produces a stable mapping as
>>> b
>>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>>> index f8d5621bc767..e440f6019d58 100644
>>> --- a/net/ceph/osdmap.c
>>> +++ b/net/ceph/osdmap.c
>>> @@ -818,6 +818,10 @@ static int decode_pool(void **p, void *end,
>>> struct ceph_pg_pool_info *pi)
>>>  
>>>  	ceph_decode_need(p, end, 4 + 4 + 4, bad);
>>>  	pi->type = ceph_decode_8(p);
>>> +	if (!ceph_pool_type_is_supported(pi->type)) {
>>> +		pr_warn_ratelimited("got unsupported pool type
>>> %u",
>>> pi->type);
>>> +		return -EINVAL;
>>> +	}
>>>  	pi->size = ceph_decode_8(p);
>>>  	pi->crush_ruleset = ceph_decode_8(p);
>>>  	pi->object_hash = ceph_decode_8(p);
> 
> Makes sense.
> 
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
> 
> Thanks,
> Slava.

Hi,

I noticed that this solution does not cover all trigger paths for this
BUG() assertion. It fixes the problem for full maps. In the case of an
incremental map, the update is performed in-place. This means that by
the time, the "!ceph_pool_type_is_supported(pi->type)" check triggers,
pi->type is already set to the unsupported type in the current osdmap.
Therefore, the BUG() can still be triggered. I suggest also removing the
partially decoded (corrupted) pool from the osdmap again in
__decode_pools() when decode_pool() returns an error. This fixes the
issue for incremental maps and further ensures that no otherwise
corrupted pools remain in the current osdmap after their decoding failed.

I would suggest adding this logic to this patch, as it has not yet been
applied upstream. Therefore, I will send a v2 of this patch.

Best regards,
Raphael

