From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding compression support for bluestore.
Date: Mon, 21 Mar 2016 19:35:57 +0300
Message-ID: <56F022ED.6000909@mirantis.com>
References: <56C1FCF3.4030505@mirantis.com>
 <CACJqLyb=X1i7tsYeKOEJRdJEEMBGvgW817eY5Bo9YBXDszUDmw@mail.gmail.com>
 <56C3BAA3.3070804@mirantis.com>
 <CY1PR0201MB1897E7F1DE04B5E4577B16EDE8A00@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1602220718380.13988@cpach.fuggernut.com>
 <56CDF40C.9060405@mirantis.com>
 <CY1PR0201MB1897BC7052AD6F7FB01DCAB4E8A50@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <56D08E30.20308@mirantis.com>
 <alpine.DEB.2.11.1603151243030.32086@cpach.fuggernut.com>
 <56E9A727.1030400@mirantis.com>
 <alpine.DEB.2.11.1603161515360.14377@cpach.fuggernut.com>
 <56EACAAD.90002@mirantis.com>
 <alpine.DEB.2.11.1603171123090.14377@cpach.fuggernut.com>
 <56EC248E.3060502@mirantis.com>
 <CY1PR0201MB1897035E6E09FE518ACC2DDCE88D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <56F00022.9020307@mirantis.com>
 <CY1PR0201MB189754639EB3F2E219CF0E6EE88F0@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34956 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756270AbcCUQgU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2016 12:36:20 -0400
Received: by mail-lf0-f43.google.com with SMTP id v130so84698180lfd.2
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2016 09:36:19 -0700 (PDT)
In-Reply-To: <CY1PR0201MB189754639EB3F2E219CF0E6EE88F0@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 21.03.2016 18:14, Allen Samuels wrote:
>>
>> That's an interesting proposal but I can see following caveats here =
(I beg
>> pardon I  misunderstood something):
>> 1) Potentially uncontrolled extent map growth when extensive (over)w=
riting
>> takes place.
> Yes, a na=EFve insertion policy could lead to uncontrolled growth, bu=
t I don't think this needs to be the case. I assume that when you add a=
n "extent", you won't increase the size of the array unnecessarily, i.e=
=2E, if the new extent doesn't overlap an existing extent then there's =
no reason to increase the size of the map array -- actually you want to=
 insert the new extent at the <smallest> array index that doesn't overl=
ap, only increasing the array size when that's not possible. I'm not 10=
0% certain of the worst case, but I believe that it's limited to the ra=
tio between the largest extent and the smallest extent. (i.e., if we as=
sume writes are no larger than -- say -- 1MB and the smallest are 4K, t=
hen I think the max depth of the array is 1M/4K =3D> 2^8, 256. Which is=
 ugly but not awful -- since this is probably a contrived case. This mi=
ght be a reason to limit the largest extent size to something a bit sma=
ller (say 256K)...
It looks like I misunderstood something... It seemed to me that your=20
array grows depending on the maximum amount of block versions.
Imagine you have 1000 writes 0~4K and 1000 writes 8K~4K
I supposed that this will create following array:
[
0: <0:{...,4K}, 8K:{...4K}>,
=2E..
999: <0:{...,4K}, 8K:{...4K}>,
]

what's happening in your case?

>> 2) Read/Lookup algorithmic complexity. To find valid block (or detec=
t
>> overwrite) one should sequentially enumerate the full array. Given 1=
) that
>> might be very ineffective.
> Only requires one log2 lookup for each index of the array.
This depends on 1) thus still unclear at the moment.
>> 3) It's not dealing with unaligned overwrites. What happens when som=
e
>> block is partially overwritten?
> I'm not sure I understand what cases you're referring to. Can you giv=
e an example?
>
Well, as far as I understand in the proposal above you were operating=20
the entire blocks (i.e. 4K data)
Thus overwriting the block is a simple case - you just need to create a=
=20
new block "version" and insert it into an array.
But real user writes seems to be unaligned to block size.
E.g.
write 0~2048
write 1024~3072

you have to either track both blocks or merge them. The latter is a bit=
=20
tricky for the compression case.




--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
