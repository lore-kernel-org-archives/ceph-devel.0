From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Infiniband 40GB
Date: Thu, 07 Jun 2012 14:44:34 +0200
Message-ID: <4FD0A232.5020400@profihost.ag>
References: <4FCB1C0A.4050504@profihost.ag> <201206061257.34525.a.ott@m-privacy.de> <4FCF38C7.8000802@profihost.ag> <201206071333.28197.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:42973 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504Ab2FGMoh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 08:44:37 -0400
In-Reply-To: <201206071333.28197.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org

Am 07.06.2012 13:33, schrieb Amon Ott:
> On Wednesday 06 June 2012 wrote Stefan Priebe - Profihost AG:
>> Am 06.06.2012 12:57, schrieb Amon Ott:
>>> On Wednesday 06 June 2012 wrote Stefan Priebe - Profihost AG:
>> /usr/include/unistd.h:
>> extern int syncfs (int __fd) __THROW;
>>
>> /usr/include/gnu/stubs-64.h:
>> #define __stub_syncfs
>
> Are you building on 32 or 64 Bit? We have 32 here.

64bit but does this make a difference?

Stefan
