From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: parsing in the ceph osd subsystem
Date: Thu, 29 Nov 2012 16:49:29 +0000
Message-ID: <50B79219.8020403@inktank.com>
References: <CABYiri8PnWR=LNPuR1bqpuPGp55diHYPsAhdUtd7dNC9=UJTRQ@mail.gmail.com> <alpine.DEB.2.00.1211290833290.30450@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60092 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab2K2Qtg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Nov 2012 11:49:36 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so6381277bkw.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Nov 2012 08:49:35 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211290833290.30450@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Andrey Korolyov <andrey@xdel.ru>, ceph-devel <ceph-devel@vger.kernel.org>

On 11/29/2012 04:34 PM, Sage Weil wrote:
> On Thu, 29 Nov 2012, Andrey Korolyov wrote:
>> $ ceph osd down -
>> osd.0 is already down
>> $ ceph osd down ---
>> osd.0 is already down
>>
>> the same for ``+'', ``/'', ``%'' and so - I think that for osd subsys
>> ceph cli should explicitly work only with positive integers plus zero,
>> refusing all other input.
> 
> which branch is this?  this parsing is cleaned u pin the latest 
> next/master.

I confirm this is fixed, but while making sure noticed that 'ceph osd
create <garbage>' will create an osd nonetheless. Just added a fix for
this to wip-mon-osd-create-fix that will make sure that if the uuid
argument is specified, then -EINVAL is returned in case the uuid is invalid.

  -Joao

