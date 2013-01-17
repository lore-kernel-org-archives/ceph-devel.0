From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Hit suicide timeout after adding new osd
Date: Thu, 17 Jan 2013 16:37:03 +0100
Message-ID: <50F81A9F.2090104@profihost.ag>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F80EFF.7020803@widodh.nl> <50F80FA0.5010504@profihost.ag> <50F819B8.4070004@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:50961 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756663Ab3AQPhE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 10:37:04 -0500
In-Reply-To: <50F819B8.4070004@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

Hi Sage,

Am 17.01.2013 16:33, schrieb Wido den Hollander:
> Hi,
> On 01/17/2013 03:50 PM, Stefan Priebe wrote:
>> Hi,
>> Am 17.01.2013 15:47, schrieb Wido den Hollander:
>>> You might want to try building from 'next' yourself or fetch some new
>>> packages from the RPM repos: http://eu.ceph.com/docs/master/install/rpm/
>>
>> Should it be backported to bobtail branch as well?
>>
>
> Don't think it's in there. I found the commit in the next branch:
> https://github.com/ceph/ceph/commit/7e94f6f1a7b7a865433edacd6a521f6ea1170eac
>
> Doesn't seem to be in 'bobtail'.
>
> Wido

Was this forgotten? I mean a lot of people have posted about git suicide 
timeout with 0.56 oder 0.56.1 so it should be also in the bobtail branch?

Greets,
Stefan
