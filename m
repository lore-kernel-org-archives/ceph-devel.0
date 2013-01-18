From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: branches
Date: Fri, 18 Jan 2013 20:02:08 +0100
Message-ID: <50F99C30.7030205@profihost.ag>
References: <alpine.DEB.2.00.1301081038580.30467@cobra.newdream.net> <alpine.DEB.2.00.1301181031130.8622@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:55462 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880Ab3ARTCI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Jan 2013 14:02:08 -0500
In-Reply-To: <alpine.DEB.2.00.1301181031130.8622@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi,

what's bobtail-next then? bobtail itself also contains already updates 
since 056.1?

Stefan

Am 18.01.2013 19:32, schrieb Sage Weil:
> I went ahead and made this change last week.
>
> Just a remind, the new world order is:
>
>> master
>>   - active development
>> next
>>   - frozen for next release
>>   - bug fixes only
>>   - regularly merged back into master
>> last
>>   - last release (instead of 'testing')
>>   - packages at /debian-testing and /debian-last, /rpm-testing, /rpm-last
>> bobtail
>>   - bobtail backport series 0.56.x
>>   - packages at /debian-bobtail (and /debian, until cuttlefish),
>>     /rpm-bobtail, /rpm
>> argonaut
>>   - argonaut backport series 0.48.x
>>   - packages at /debian-argonaut
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
