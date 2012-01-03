From: Wido den Hollander <wido@widodh.nl>
Subject: Re: scrubbing
Date: Tue, 03 Jan 2012 10:51:50 +0100
Message-ID: <4F02CFB6.20607@widodh.nl>
References: <4F0190B0.7070500@filoo.de> <4F01916D.2080209@widodh.nl> <4F019647.50808@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:57270 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab2ACJvw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jan 2012 04:51:52 -0500
In-Reply-To: <4F019647.50808@filoo.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Jens_Rehp=F6hler?= <jens.rehpoehler@filoo.de>
Cc: ceph-devel@vger.kernel.org

Hi,

On 01/02/2012 12:34 PM, Jens Rehp=F6hler wrote:
> Hi Wido,
>
> Am 02.01.2012 12:13, schrieb Wido den Hollander:
>> Hi,
>>
>> On 01/02/2012 12:10 PM, Jens Rehp=F6hler wrote:
>>> Happy new year  !!
>>
>> Let this be a great year for Ceph :-)
>>
> i think it will be ;)
>>>
>>> another year another question:
>>>
>>> I got the following from ceph -w :
>>>
>>> 2012-01-02 12:05:17.294350    pg v830384: 1254 pgs: 18 creating, 12=
35
>>> active+clean, 1 active+clean+scrubbing; 586 GB data, 1378 GB used, =
12763
>>> GB / 14887 GB avail
>>> 2012-01-02 12:05:23.763982    pg v830385: 1254 pgs: 18 creating, 12=
35
>>> active+clean, 1 active+clean+scrubbing; 586 GB data, 1378 GB used, =
12763
>>> GB / 14887 GB avail
>>> 2012-01-02 12:05:27.295568    pg v830386: 1254 pgs: 18 creating, 12=
35
>>> active+clean, 1 active+clean+scrubbing; 586 GB data, 1378 GB used, =
12763
>>> GB / 14887 GB avail
>>> 2012-01-02 12:05:28.765457    pg v830387: 1254 pgs: 18 creating, 12=
35
>>> active+clean, 1 active+clean+scrubbing; 586 GB data, 1378 GB used, =
12763
>>> GB / 14887 GB avail
>>
>> Which version are you running?
>>
>> This was a known bug but should be fixed about two weeks ago in the
>> master branch.
>>
>> I also encountered this one, but it's resolved for me right now.
>>
> I use:
>
> ceph version 0.39-15-ge93961c
> (commit:e93961c11119942eae3a4cd14a79f779a5a4d277)
>
> from the "stable" branch.
>
> OS is Debian 6.0.3
>
> So i will wait until it is patched into the stable branch too.

I think it won't be to long until v0.40 comes out. But in the meantime=20
you can always try to grab the latest code from the master branch.

Wido

>
> Thank you for the very quick answer.
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
