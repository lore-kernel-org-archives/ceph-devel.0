From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Infiniband 40GB
Date: Mon, 04 Jun 2012 07:40:08 -0500
Message-ID: <4FCCACA8.5000005@inktank.com>
References: <4FCB1C0A.4050504@profihost.ag> <4FCB5EED.30909@inktank.com> <4FCC5431.6070002@suse.de> <4FCCA9EF.6080701@inktank.com> <CAMvP8PAkDdhhJnT+KBH4p2U+g+qLfp6O=MzPyEct-q4Yzw_LVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:43347 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367Ab2FDMkK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 08:40:10 -0400
Received: by ghrr11 with SMTP id r11so3245448ghr.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jun 2012 05:40:10 -0700 (PDT)
In-Reply-To: <CAMvP8PAkDdhhJnT+KBH4p2U+g+qLfp6O=MzPyEct-q4Yzw_LVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomasz Paszkowski <ss7pro@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, Stefan Priebe <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 6/4/12 7:34 AM, Tomasz Paszkowski wrote:
> On Mon, Jun 4, 2012 at 2:28 PM, Mark Nelson<mark.nelson@inktank.com>  wrote:
>>
>> For syncfs support, upgrade to a distro with glibc 2.13+ (ie precise). I've
>> noticed a significant improvement in our spinning disk performance going
>> from oneiric and kernel 3.3 to precise and kernel 3.4.  I think part of this
>> is related to the raid drivers for the cards we have in our test boxes
>> though.  I'm actually recording blktrace and seekwatcher results for all of
>> our tests to specifically look at syncs and disk seek behavior...
>>
>
> Correct me if I'am wrong. But AFAIR precise in running 3.2 kernel.

Sorry, I should have been more clear.  We were running oneiric with our 
own kernel 3.3 build and are now running precise with our own kernel 3.4 
build (available on gitbuilder.ceph.com).

Mark
