Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6993633F8C3
	for <ceph-devel@vger.kernel.org>; Wed, 18 Mar 2026 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873507; cv=none; b=fRKmDy6Bth7X+0DmcxO5/aL4tZrgZhnuQ1kNYMn/iCOmQGV1Yih57lSIen6wdPJ9s6qoA4QaRT6iMTEYLW+PJDymzDvGdunyOJUshBnH/SbTKjrsQRcGhD/0ejkJknTBIOJuQhhZyd4h1obWmRHMYqnNLsOu6ejKz8fvK0XLGmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873507; c=relaxed/simple;
	bh=VBsTejieZ4/3JN0cuPvkOf3dN8STc9QC3P7rgFdbtt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVUvNEW5qL2yvWvyJyMhpZ8aqVq8Kce5nGSKa8pFZU4IorJLd0cUQ2crbFhQshFqa7oSyTcmhShk/5n7ma0kPGcheddTkBkqZC5AgfJ+seLKL8NgFLhSpsMla1tWrguxtdvZZJzRx+wTXWVWUrchQ8STg7dQ1XCTI+ulEAp7ZvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czchIZvk; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czchIZvk"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso589050eec.1
        for <ceph-devel@vger.kernel.org>; Wed, 18 Mar 2026 15:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773873505; x=1774478305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sFZ8Dw3ibckO1MSlkY5sWNvcjNJn2NjoNVKwCGOBcLE=;
        b=czchIZvkOI4C9/L3qj0irB/tGdL3JEHojFnQ5fLu//QCLK454kg70eVGAbQE898kUM
         td8vvPHsRMJdGxypfPD2xwroqoa+B/WOX3hiiFlTsnZrLBDyu+laHD1Av6qE+2AfVi7Q
         mWXPawWhWWbZF1tqxyltwkJFmAu+u6HXLcYo//ptIzq5yGO44lJACYzkShcJpz1z/07/
         OXmtuWjZF3L//Z+hvpPIRMlOGxxysXFz3f5ZHgpnQbO8B+1WHxaPGrkZ0quR1kIMm1k9
         I1GWNvzhHpyX9/b1QsjAbGijeQUc5GXBiHL8wg+fyGMay2DSPGjCUx15fWZp059Ipn4k
         LuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773873505; x=1774478305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFZ8Dw3ibckO1MSlkY5sWNvcjNJn2NjoNVKwCGOBcLE=;
        b=l6uV024thNiLnrxFGzToNPiCQ/7gVNLbcRTB5ck8LbdadLsGmezx7NBcoD/b/sSYva
         tZVy/PhIEtJUBQlsJg5UuLUsdIMavM/FPu9gVyrHuBtGkkepOyefA21THv7o9i/XwEL8
         IBwevpJN/VoVo+3bAEMpT8BuztcFK6WVHFE3J0fvsoyV3n93QcnWbm/9YtMUdvAGFh5t
         Rt5+mlN7Mro6o4RMm8999iLoMBj2KoNaok9Eu1lIS18M+gVWBz75Iwet9LNtJiXTq1HU
         OSYuKbpBfMVSVImxsApWswlfxJmdqPQxuZnROpy81RC1IGwvNkYX1w/dyyj5aPB8zcL5
         +61g==
X-Forwarded-Encrypted: i=1; AJvYcCUvYyzfg7IDJgWeQTjONq4O3S4qRXc1J+cP3vzQXPmNmOaH5BurtGnc1i0nwJxghyA18PXx9d82xC2l@vger.kernel.org
X-Gm-Message-State: AOJu0YxsedR/GEZA5DKg5xko9A4ugCFrVLIaqPihrXf1ByCa1cLOFjX2
	V4dc6eeijHk8QstJWArLcU+ka/dy7Q/DWQhuYKLXMlno4izFvIHH4l6+
X-Gm-Gg: ATEYQzxO/fqMHWmEW9o/O1BUzeFUZmCwo/5bRUqfGT0Rb3ydiUdou0+eTOGbPcukK/a
	BlVfFVItFLZAmE/ydoijXpVW458ezjlWT2hrAlH/IVzL8QyeKYWyKJ3ZDzzl+xn8Xu7b8ossXRK
	JAVF7ZlygyIv4XzAPFfnte+fPkfGMbkJ1GvNuU+mvszh2YDTyeKK+5/8Ta1U1gOmx9o97UIsnps
	0fFsxl0GUg9YcI21A/IsQXVwDp7iaEAunBj4EszrJ+lEeQqR5NxzS9neqG1V717LwKJePlsWaAe
	19nYNeiWX14iFCPDeKAjO83NoaYDMVESU75VCg2Dfib+uo1fWocGAlO8m7LpUQ9XXNYgocf0wSg
	IzqfEPm0X7tMsh2Jl+VJ9TIFp4e4B8Yg57atMtVZNeynVPy6vfWbznKsd3PVkMhmcIfF4cOS3Wx
	qNMkupD9lEUJiiQpvC6LN6rZvzNAAVYVLRjHu0Q7C7HZP1n6zC4uArkYHJ8Rbsi1Fy4OTGAwsgj
	Q==
X-Received: by 2002:a05:7300:fb97:b0:2c0:c1e0:244a with SMTP id 5a478bee46e88-2c0e509746emr2235424eec.9.1773873505407;
        Wed, 18 Mar 2026 15:38:25 -0700 (PDT)
Received: from [192.168.68.191] (67-2-26-43.slkc.qwest.net. [67.2.26.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e5583533sm6354714eec.18.2026.03.18.15.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 15:38:25 -0700 (PDT)
Message-ID: <a7d899ba-1e42-4a78-8835-f89a01d10328@gmail.com>
Date: Wed, 18 Mar 2026 16:38:24 -0600
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ceph-users] Cephfs kernel client bug report
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 Venky Shankar <vshankar@redhat.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
 "ceph-users@ceph.io" <ceph-users@ceph.io>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
References: <0100019cfdd4fb2d-5355e1f0-8561-4826-a592-16093c7bc4de-000000@email.amazonses.com>
 <CACPzV1=Fz9Qxu2hT=23wApZjW=m2DBtDx__g=wE8Pgy=9k98aA@mail.gmail.com>
 <2106322c86b05486ecf34b35198a644e112aac23.camel@ibm.com>
Content-Language: en-US
From: Alain Bertrand <the.roger.thornhill@gmail.com>
In-Reply-To: <2106322c86b05486ecf34b35198a644e112aac23.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Slava,

I just put the details in the bug 
report https://tracker.ceph.com/issues/75609 .  The kernels I was able 
to reproduce the issue on were the proxmox supplied 6.17.13-1-pve, and 
6.14.11-5-pve, and the Pop!_OS kernel version 6.18.7-76061807-generic.  
The problem didn't happen on a different machine running CachyOS kernel 
6.19.6-2-cachyos.

All I needed to do to reproduce the problem was go to the cephfs 
mountpoint (/mnt/ceph) and run find -maxdepth 3 -type d -exec ls 
"{}/.snap/" \; which should have listed snapshots from about 1015 
directories.  This wasn't the smartest way to find snapshots, it was 
just the first one I thought of.

Each time the effect is a little different.  Sometimes it immediately 
panics, sometimes the machine just gets slow for a few minutes with lots 
of errors being logged before it panics.


Thanks,

Alain


On 2026-03-18 13:07, Viacheslav Dubeyko wrote:
> Hi Alain,
>
> The ceph-devel@vger.kernel.org is the email list for sharing issues in CephFS
> kernel client.
>
> I remember that we had the fix for likewise issue recently. Could you please
> share which kernel version you have? Which particular call trace do you have for
> this kernel panic? How anybody can reproduce the issue?
>
> Thanks,
> Slava.
>
> On Wed, 2026-03-18 at 15:17 +0530, Venky Shankar wrote:
>> cc Alex/Slava (cephfs kernel driver maintainers)
>>
>> On Wed, Mar 18, 2026 at 3:35 AM Alain Bertrand via ceph-users
>> <ceph-users@ceph.io> wrote:
>>> Hi.
>>>
>>> I'm new here.  I have been playing with ceph for a few years (nothing
>>> dramatic, just using it in my proxmox cluster to store VM images and
>>> host a cephfs with a lot of shared files).  I think I found a bug in the
>>> cephfs client in the Linux kernel.  Listing snapshots (ls .snap) in a
>>> lot of directories quickly causes a kernel panic.  I tried to create an
>>> account on the bug tracker at tracker.ceph.com a week ago, but still
>>> can't log in there.  Do I put details here, or report somewhere else?
>>> What's the next step I should take?
>>>
>>>
>>> Thanks,
>>>
>>> Alain
>>> _______________________________________________
>>> ceph-users mailing list -- ceph-users@ceph.io
>>> To unsubscribe send an email to ceph-users-leave@ceph.io
>>
