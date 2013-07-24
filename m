From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Upgrading from 0.61.5 to 0.61.6 ended in disaster
Date: Wed, 24 Jul 2013 13:54:09 +0200
Message-ID: <51EFC061.6090802@profihost.ag>
References: <51EF7CC8.9070507@profihost.ag> <51EF843D.1070107@profihost.ag> <51EFB650.6050506@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:38357 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab3GXLyR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Jul 2013 07:54:17 -0400
In-Reply-To: <51EFB650.6050506@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 24.07.2013 13:11, schrieb Joao Eduardo Luis:
> On 07/24/2013 08:37 AM, Stefan Priebe - Profihost AG wrote:
>> Hi,
>>
>> i uploaded my ceph mon store to cephdrop
>> /home/cephdrop/ceph-mon-failed-assert-0.61.6/mon.tar.gz.
>>
>> So hopefully someone can find the culprit soon.
>>
>> It fails in OSDMonitor.cc here:
>>
>>     // if we trigger this, then there's something else going with the
>> store
>>      // state, and we shouldn't want to work around it without knowing
>> what
>>      // exactly happened.
>>      assert(latest_full > 0);
>>
> 
> Wrong variable being used in a loop as part of a workaround for 5704.
> 
> Opened a bug for this on http://tracker.ceph.com/issues/5737
> 
> A fix is available on wip-5737 (next) and wip-5737-cuttlefish.
> 
> Tested the mon against your store and it worked flawlessly.  Also tested
> it against the same stores used during the original fix and also they
> worked just fine.
> 
> My question now is how the hell those stores worked fine although the
> original fix was grabbing what should have been a non-existent version,
> or how did they not trigger that assert.  Which is what I'm going to
> investigate next.

What i don't understand is WHY the hell the OSDs haven't used the 2nd or
3rd monitor which wasn't restarted?

Greets,
Stefan
