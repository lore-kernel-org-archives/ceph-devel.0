From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: Assert in OSD::build_incremental_map_msg
Date: Fri, 16 Dec 2011 16:13:40 -0700
Message-ID: <4EEBD0A4.7000408@sandia.gov>
References: <4EEB7AE9.5080601@sandia.gov>
 <Pine.LNX.4.64.1112160955040.25421@cobra.newdream.net>
 <4EEB8D4A.5020506@sandia.gov>
 <CACLRD_0+0-NTszjVtira9Og80J-NGt+wBh3hcBp4==gHWdstLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:45471 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab1LPXOK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 18:14:10 -0500
In-Reply-To: <CACLRD_0+0-NTszjVtira9Og80J-NGt+wBh3hcBp4==gHWdstLg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@dreamhost.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 12/16/2011 03:43 PM, Samuel Just wrote:
> bfbde5b18525406fc3b678751459e989ea5d4977 in master should fix it.

Great, thanks for taking a look.

-- Jim

> -Sam
>
> On Fri, Dec 16, 2011 at 10:26 AM, Jim Schutt<jaschut@sandia.gov>  wrote:
>> On 12/16/2011 10:56 AM, Sage Weil wrote:
>>>
>>> Hi Jim,
>>>
>>> Are you able to generate an osd log leading up to this crash?
>>>
>>>         debug osd = 20
>>>         debug filestore = 10
>>>         debug ms = 1
>>
>>
>> Sent by private email.
>>
>> Thanks for taking a look.
>>
>> -- Jim
>>

