From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Hit suicide timeout after adding new osd
Date: Thu, 17 Jan 2013 16:33:12 +0100
Message-ID: <50F819B8.4070004@widodh.nl>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F80EFF.7020803@widodh.nl> <50F80FA0.5010504@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:56874 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755930Ab3AQPdP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 10:33:15 -0500
In-Reply-To: <50F80FA0.5010504@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On 01/17/2013 03:50 PM, Stefan Priebe wrote:
> Hi,
>
> Am 17.01.2013 15:47, schrieb Wido den Hollander:
>> You might want to try building from 'next' yourself or fetch some new
>> packages from the RPM repos: http://eu.ceph.com/docs/master/install/rpm/
>
> Should it be backported to bobtail branch as well?
>

Don't think it's in there. I found the commit in the next branch: 
https://github.com/ceph/ceph/commit/7e94f6f1a7b7a865433edacd6a521f6ea1170eac

Doesn't seem to be in 'bobtail'.

Wido

> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

