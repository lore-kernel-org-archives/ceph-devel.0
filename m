From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: problems creating new ceph cluster when using journal on block
 device
Date: Thu, 08 Nov 2012 21:24:14 +1300
Message-ID: <509B6C2E.2050708@catalyst.net.nz>
References: <CACkq2mozdJackj__AB_ZJnN5KR9mdqN_LRG8RPu0hN1qh_8e_g@mail.gmail.com> <509B6883.4010406@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:37578 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab2KHIYQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 03:24:16 -0500
In-Reply-To: <509B6883.4010406@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: Travis Rhoden <trhoden@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 08/11/12 21:08, Wido den Hollander wrote:
>
>
> On 08-11-12 08:29, Travis Rhoden wrote:
>> Hey folks,
>>
>> I'm trying to set up a brand new Ceph cluster, based on v0.53.  My
>> hardware has SSDs for journals, and I'm trying to get mkcephfs to
>> intialize everything for me. However, the command hangs forever and I
>> eventually have to kill it.
>>
>> After poking around a bit, it's clear that the problem has something
>> to do with the journal.  If I comment out the journal in ceph.conf,
>> the commands proceed just find.  This is the first time I've tried to
>> throw a journal on a block device rather than a file, so maybe I've
>> done something wrong with that.
>>
>> Here is the info from ceph.conf:
>>
>>
>> [osd]
>>          osd journal size = 4000
>
> Not sure if this is the problem, but when using a block device you don't
> have to specify the size for the journal.

Also might be useful to know make/model of ssd, plus motherboard 
make/model (in case commenting out size does not fix)!

Regards

Mark

