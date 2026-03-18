Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250D3DA7ED
	for <ceph-devel@vger.kernel.org>; Wed, 18 Mar 2026 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852536; cv=none; b=nh0vxWLOd5PeFYD6zYKrI81k14u9UOneYAfhlvRohup4FzFoOhVP8S+2LG5IJ5wF7+2i1uY14Nb4KzCHMs5+YWiE26Y7qygXQW2vcKEhSGVs2sxHqpLZbbRiEjCo8owxCEtkdp+WtWOHMQVVrWy0ojeeTdu49i0jUUyoGYWL8FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852536; c=relaxed/simple;
	bh=hyeUhF+MYdwDpNzD/DQIqLyd/jFXKWsJvV3NCIrqZXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4mm4DjS0a6xlATTNZOnJTKDRjM+RB/F6lh+8taAcs47+mP6MybwMrA1KH4rX0B313BQezilX/fagq7WNXTaSLA1eQht4aot9ji3Jmwqe5KAtpY1qif8aXmZ7rbJYYp6U/eVu3Lt7OmoRjUvQbbgHd5HSCysOSc1uwUirDKp9rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=GP1ktgrU; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="GP1ktgrU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1773852531; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=hyeUhF+MYdwDpNzD/DQIqLyd/jFXKWsJvV3NCIrqZXg=;
 b=GP1ktgrU+IaK5OdQVHH3abT4nuY0tUchDQBtkKbuL+T8lzj0T3Qrg6sUFnyhmleNTNHcP
 xn3cU74sEoIJMkDk4IMhwzhhWg0dxWO3P1Fz1KS+/2pQPNM1YnVhQQGZ0WuedV4oaswHodB
 jGpQ5nUOzFusFP7dfDsiuWFlXBXHkoEy5PYzbhM/IQoApuF5YnClNWpCmvVMPDR0Wb1CXbP
 BNqFAWfrUfg4DbjOusewdH69O2gE1MJdF6ydd1bAdj9RWum/VbIxQJltiEynwps3tUfgC+x
 xo2Zr5c7PruE0V5xpgZa0GDUTMo4aZ+mWPY0KAQC+dz4NxdPR92g9HNGU3Uw==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 478FC5FCE0;
	Wed, 18 Mar 2026 17:48:51 +0100 (CET)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id C4D945FC87;
	Wed, 18 Mar 2026 17:48:50 +0100 (CET)
Message-ID: <15d2c123-888e-4cf6-a242-3d69d98b8a2e@tu-ilmenau.de>
Date: Wed, 18 Mar 2026 17:48:50 +0100
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libceph: Prevent potential null-ptr-deref in
 ceph_handle_auth_reply()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>, ceph-devel@vger.kernel.org
References: <20260318113256.810478-1-raphael.zimmer@tu-ilmenau.de>
 <CAOi1vP-Cpwi7=KnU4UwjOnAYNSWCw3sisM=tCc6UQ2aVxoVsvQ@mail.gmail.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <CAOi1vP-Cpwi7=KnU4UwjOnAYNSWCw3sisM=tCc6UQ2aVxoVsvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18.03.26 5:13 PM, Ilya Dryomov wrote:
> On Wed, Mar 18, 2026 at 12:33 PM Raphael Zimmer
> <raphael.zimmer@tu-ilmenau.de> wrote:
>>
>> If a message of type CEPH_MSG_AUTH_REPLY contains a zero value for both
>> protocol and result, this is currently not treated as an error. In case
>> of ac->negotiating == true and ac->protocol > 0, this leads to setting
>> ac->protocol = 0 and ac->ops = NULL. Thereafter, the check for
>> ac->protocol != protocol returns false, and init_protocol() is not
>> called. Subsequently, ac->ops->handle_reply() is called, which leads to
>> a null pointer dereference, because ac->ops is still NULL.
>>
>> This patch adds an additional check to the logic for auth protocol
>> negotiation in ceph_handle_auth_reply(), that treats a
>> CEPH_MSG_AUTH_REPLY message with protocol set to zero as invalid if the
>> result code is >= 0.
>>
>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>> ---
>>  net/ceph/auth.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/net/ceph/auth.c b/net/ceph/auth.c
>> index 901b93530b21..d97f50d38022 100644
>> --- a/net/ceph/auth.c
>> +++ b/net/ceph/auth.c
>> @@ -238,6 +238,9 @@ int ceph_handle_auth_reply(struct ceph_auth_client *ac,
>>                 if (!protocol && result < 0) {
>>                         ret = result;
>>                         goto out;
>> +               } else if (!protocol) {
>> +                       /* protocol unknown, but no error given? */
>> +                       goto bad;
> 
> Hi Raphael,
> 
> Jumping to bad would emit "failed to decode auth msg" error, which
> seems somewhat misleading since this isn't a classic decoding error
> like a short buffer or similar.  How about changing
> 
>     if (ac->protocol != protocol) {
> 
> to
> 
>     if (!ac->ops) {
> 
> instead?  This way "bad auth protocol ..." error would be emitted.
> 
> Thanks,
> 
>                 Ilya

Hi Ilya,
I see the point. Changing the check to "if (!ac->ops)" would work, but
in my opinion, it isn't obvious what is meant when reading it. I would
suggest changing this line to
	if (!ac->protocol) {
instead. This would lead to the same behavior while making it easier to
follow the reasoning when reading the code.

Best regards,
Raphael

