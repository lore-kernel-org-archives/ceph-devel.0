From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: ceph gets stopped but never started...
Date: Thu, 30 May 2013 15:01:19 +0200
Message-ID: <51A74D9F.7000206@profihost.ag>
References: <51A7383D.4060309@profihost.ag> <CAF6-1L70z8xpZVQtDXJj4h+SY7TxrN2rAz-OAR-BXkJR_4DjxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:39313 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518Ab3E3NBY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 May 2013 09:01:24 -0400
In-Reply-To: <CAF6-1L70z8xpZVQtDXJj4h+SY7TxrN2rAz-OAR-BXkJR_4DjxQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 30.05.2013 14:57, schrieb Sylvain Munaut:
> Hi
> 
>> since commit 85fb422a084785176af3b694882964841e02195d in cuttle fish
>> cherry-picked from 2f193fb931ed09d921e6fa5a985ab87aa4874589 ceph gets
>> stopped on debian while upgrading but it never gets started again??
>>
>> Does this really makes sense?
>>
>> Should the admin handle the stop / start / restart on upgrade?
> 
> Yes, personally I think so.
> 
> I mean , I usually restart osd sequentially "by hand" while the
> upgrade is usually done cluster wide by some automation but for the
> service to stay up, the restart needs to be handled manually.

Same for me.

Stefan

