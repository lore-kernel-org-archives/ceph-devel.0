From: Loic Dachary <loic@dachary.org>
Subject: Re: Throttle::wait use case clarification
Date: Mon, 21 Jan 2013 14:44:21 +0100
Message-ID: <50FD4635.9040301@dachary.org>
References: <50FBF3A4.4010200@dachary.org> <6AF9B5AC8C404CFBB78E54BA8C7FA1D2@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060906000403000506050504"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:49069 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087Ab3AUNoZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jan 2013 08:44:25 -0500
In-Reply-To: <6AF9B5AC8C404CFBB78E54BA8C7FA1D2@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, sage@inktank.com

This is a multi-part message in MIME format.
--------------060906000403000506050504
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/21/2013 12:02 AM, Gregory Farnum wrote:
> On Sunday, January 20, 2013 at 5:39 AM, Loic Dachary wrote:
>> Hi,
>>
>> While working on unit tests for Throttle.{cc,h} I tried to figure out a use case related to the Throttle::wait method but couldn't
>>
>> https://github.com/ceph/ceph/pull/34/files#L3R258
>>
>> Although it was not a blocker and I managed to reach 100% coverage anyway, it got me curious and I would very much appreciate pointers to understand the rationale.
>>
>> wait() can be called to set a new maximum before waiting for all pending threads to get get what they asked for. Since the maximum has changed, wait() wakes up the first thread : the conditions under which it decided to go to sleep have changed and the conclusion may be different.
>>
>> However, it only does so when the new maximum is less than current one. For instance
>>
>> A) decision does not change
>>
>> max = 10, current 9
>> thread 1 tries to get 5 but only 1 is available, it goes to sleep
>> wait(8)
>> max = 8, current 9
>> wakes up thread 1
>> thread 1 tries to get 5 but current is already beyond the maximum, it goes to sleep
>>
>> B) decision changes
>>
>> max = 10, current 1
>> thread 1 tries to get 10 but only 9 is available, it goes to sleep
>> wait(9)
>> max = 9, current 1
>> wakes up thread 1
>> thread 1 tries to get 10 which is above the maximum : it succeeds because current is below the new maximum
>>
>> It will not wake up a thread if the maximum increases, for instance:
>>
>> max = 10, current 9
>> thread 1 tries to get 5 but only 1 is available, it goes to sleep
>> wait(20)
>> max = 20, current 9
>> does *not* wake up thread 1
>> keeps waiting until another thread put(N) with N >= 0 although there now is 11 available and it would allow it to get 5 out of it
>>
>> Why is it not desirable for thread 1 to wake up in this case ? When debugging a real world situation, I think it would show as a thread blocked although the throttle it is waiting on has enough to satisfy its request. What am I missing ?
>>
>> Cheers
>>
>>
>> Attachments:
>> - loic.vcf
>>
>
>
> Looking through the history of that test (in _reset_max), I think it's an accident and we actually want to be waking up the front if the maximum increases (or possibly in all cases, in case the front is a very large request we're going to let through anyway). Want to submit a patch? :)
:-) Here it is. "make check" does not complain. I've not run teuthology + qa-suite though. I figured out how to run teuthology but did not yet try qa-suite.

http://marc.info/?l=ceph-devel&m=135877502606311&w=4

>
> The other possibility I was trying to investigate is that it had something to do with handling get() requests larger than the max correctly, but I can't find any evidence of that one...
I've run the Throttle unit tests after uncommenting
https://github.com/ceph/ceph/pull/34/files#L3R269
and commenting out
https://github.com/ceph/ceph/pull/34/files#L3R266
and it passes.

I'm not sure if I should have posted the proposed Throttle unit test to the list instead of proposing it as a pull request
https://github.com/ceph/ceph/pull/34

What is best ?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlD9RjUACgkQ8dLMyEl6F20boACggzHH3Dw+/kM+awkD5POxyQB4
WosAn02bfzTUnItoTlwKtU0cDlWnckGv
=SsIe
-----END PGP SIGNATURE-----


--------------060906000403000506050504
Content-Type: text/x-vcard; charset=utf-8;
 name="loic.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="loic.vcf"

YmVnaW46dmNhcmQNCmZuOkxvaWMgRGFjaGFyeQ0KbjpEYWNoYXJ5O0xvaWMNCm9yZzpBcnRp
c2FuIExvZ2ljaWVsIExpYnJlDQphZHI6OzsxMiBiZCBNYWdlbnRhO1BhcmlzOzs3NTAxMDtG
cmFuY2UNCmVtYWlsO2ludGVybmV0OmxvaWNAZGFjaGFyeS5vcmcNCnRpdGxlOlNlbmlvciBE
ZXZlbG9wZXINCnRlbDt3b3JrOiszMyA0IDg0IDI1IDA4IDA1DQp0ZWw7aG9tZTorMzMgOSA1
MSAxOCA0MyAzOA0KdGVsO2NlbGw6KzMzIDYgNjQgMDMgMjkgMDcNCm5vdGU6Qm9ybiAxMzE0
MTQ0MDQgYmVmb3JlIEVQT0NILg0KdXJsOmh0dHA6Ly9kYWNoYXJ5Lm9yZy8NCnZlcnNpb246
Mi4xDQplbmQ6dmNhcmQNCg0K
--------------060906000403000506050504--
