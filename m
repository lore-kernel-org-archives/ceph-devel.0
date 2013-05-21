From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: OSD memory leak when scrubbing [0.56.6]
Date: Tue, 21 May 2013 21:38:17 +0200
Message-ID: <AF1A2BCC-36FD-4D9C-9C21-C9B58DDCDB95@filoo.de>
References: <519B9196.5090402@filoo.de> <CAF6-1L6E6s_wP6012ifwTRwZA4bp5+OLmYo92Y5QbmS20uxReA@mail.gmail.com> <FB4F06C0-410B-43C0-A5CE-64AFD18B29D0@profihost.ag> <alpine.DEB.2.00.1305210841410.30656@cobra.newdream.net> <519BCB15.8070502@profihost.ag> <alpine.DEB.2.00.1305211231450.16413@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-2.de-punkt.de ([93.190.64.238]:56917 "EHLO
	mail-2.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab3EUTi0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 May 2013 15:38:26 -0400
In-Reply-To: <alpine.DEB.2.00.1305211231450.16413@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Sylvain Munaut <s.munaut@whatever-company.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Well,

Am 21.05.2013 um 21:31 schrieb Sage Weil <sage@inktank.com>:

> On Tue, 21 May 2013, Stefan Priebe wrote:
>> Am 21.05.2013 17:44, schrieb Sage Weil:
>>> On Tue, 21 May 2013, Stefan Priebe - Profihost AG wrote:
>>>> Am 21.05.2013 um 17:35 schrieb Sylvain Munaut
>>>> <s.munaut@whatever-company.com>:
>>>> 
>>>>> Hi,
>>>>> 
>>>>>> subject seems familiar, version was 0.48.3 in the last mail.
>>>>>> 
>>>>>> Not anyone else with perhaps large pg's experiencing such behaviour?
>>>>>> 
>>>>>> Any advice on how to proceed?
>>>>> 
>>>>> I had the same behavior in both argonaut and bobtail, raising sharply
>>>>> ~ 100M or so at each scrub (every 24h).
>>>>> 
>>>>> It's now resolved in cuttlefish AFAICT.
>>>>> 
>>>>> However given the mon leveldb issues I'm having with cuttlefish, I'm
>>>>> not sure I'd recommend upgrading ...
>>>> 
>>>> I thought all mon leveldb issues were solved?
>>> 
>>> Not quite.  I'm now able to reproduce the leveldb growth from Mike
>>> Dawson's trace (thanks!) but we don't have a fix yet.
>> 
>> Oh OK. Is there a tracker id?
> 
> http://tracker.ceph.com/issues/4895
> 

true for this issue, but back to topic, still not being able to safely ( deep-) scrub the whole cluster with 0.56.6.

>> 
>>> I thought the scrub memory issues were addressed by
>>> f80f64cf024bd7519d5a1fb2a5698db97a003ce8 in 0.56.4... :(
>>> 

any advice very welcome, though about 1/3 of the cluster is safe in means of "we scrubbed it deeply".

Best regards,

Oliver.

>>> sage
>>> 
>> 
>> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

