From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Is Ceph recovery able to handle massive crash
Date: Tue, 08 Jan 2013 14:36:48 +0100
Message-ID: <50EC20F0.1060502@widodh.nl>
References: <50E81A3D.5070100@ledeuns.net> <50EB0518.9050304@ledeuns.net> <E4EA8440A5CF4E519F57FE3D9C26CAE4@inktank.com> <50EBDC5E.3090207@ledeuns.net> <50EC17A6.1080707@ledeuns.net> <50EC1AC2.2060001@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:50065 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754Ab3AHNgv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 08:36:51 -0500
In-Reply-To: <50EC1AC2.2060001@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Denis Fondras <ceph@ledeuns.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/08/2013 02:10 PM, Wido den Hollander wrote:
> On 01/08/2013 01:57 PM, Denis Fondras wrote:
>> Hello,
>>
>> I'm wondering if I can get every "rb.0.8e10.3e2219d7.*" from the OSD
>> drive and cat them together and get back a usable raw volume from which
>> I could get back my data ?
>>
>
> Yes, that is doable. The problem only is that RBD is sparse. So you'd
> have to fill up the empty spaces with 4MB of zeroes.
>
> But yes, it's doable if you gather all the objects and will the rest up
> with zeroes.
>
>> Everything seems to be there but I don't know the order of the rbd
>> objects. Are the last bytes of the file name the offset of the block ?
>>
>
> There was a quick perl command for this to generate all the suffixes,
> but I can't seem to find it right now.
>

You could do something like this to generate all the blocks you should 
need, the non-existing ones you should fill them with nothing, aka 4MB 
of nothing.

perl -e 'while ($s < (SIZE_IN_MB / 4)) { printf "BLOCK_PREFIX.%012x\n", 
$s; $s++}'

Size is the block-device in MB en BLOCK_PREFIX can be something like 
"rb.0.1016.238e1f29"

Wido

> Wido
>
>> Regards,
>> Denis
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

