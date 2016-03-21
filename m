From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Adding compression support for bluestore.
Date: Mon, 21 Mar 2016 21:31:19 +0300
Message-ID: <56F03DF7.7030708@mirantis.com>
References: <56C1FCF3.4030505@mirantis.com> <56C3BAA3.3070804@mirantis.com>
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
 <56F022ED.6000909@mirantis.com>
 <CY1PR0201MB18978F2B3F07A33361449E95E88F0@CY1PR0201MB1897.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:32850 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526AbcCUT3s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2016 15:29:48 -0400
Received: by mail-lb0-f179.google.com with SMTP id oe12so133424395lbc.0
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2016 12:29:47 -0700 (PDT)
In-Reply-To: <CY1PR0201MB18978F2B3F07A33361449E95E88F0@CY1PR0201MB1897.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 21.03.2016 20:14, Allen Samuels wrote:
> After reading your proposal and Sage's response, I have a hybrid prop=
osal that I think is BOBW...
>
> This proposal is based on Sage's comments about there being two diffe=
rent structures.
>
> Leveraging my proposal for a unified extent (included by reference). =
=46or our purpose each extent is fully self-contained, i.e., logical ad=
dress/size, physical address/size, checksums, flags, etc....
It seems we don't need logical addr/size in this structure any more - i=
t=20
should be within the logical block map. See below...
> The onode value (i.e., the one in the KV storage) contains only  LIST=
 of extents (yes a list, read on!). The list is ordered temporally, thi=
s provides the necessary ordering information to disambiguate between t=
wo extents that overlap/occlude the same logical address range.
And I'm not sure if we need any temporal order in this extent list If=20
logical block map is maintained properly, i.e. proper entries are=20
inserted on overwrite and overwritten ones are updated. We just need a=20
(implicit?) collection of such extents and an ability to reference its'=
=20
specific entries.
Under "implicit" collection I mean we don't need to collect them within=
=20
a single data structure ( map, list, array, whatever..) - we just need=20
some reference to the entry from logical block map and corresponding=20
reference counting mechanics.
Serializing to be considered though...

> The in-memory onode contains an auxilliary map that's ordered by logi=
cal address. Entries in the map point to the extent that provides the d=
ata for that logical address range. There can be multiple entries in th=
e map that reference the same element of the list. This map cheaply dis=
ambiguates between multiple extents that overlap in logical address spa=
ce. This is the case that Sage pointed out causes problems for the data=
 structure that you propose. In my proposal, you'll have two entries in=
 the logical map pointing to the same entry in the extent map.
>
> We reference count between the logical map and the extent list to kno=
w when an extent no longer contributes data to this object (and hence c=
an be removed from the list and potentially have it's space recovered).
Yes. And such a map ( AKA logical block map ) has to contain (logical?)=
=20
address/size ( I'd prefer to name it a pointer or descriptor for a=20
region within a physical extent ) and a reference to an extent. Exactly=
=20
as in Sage's comment.

Thus Sage proposal to be simply extended with reference counting for ra=
w=20
extents.

> Costs for this dual data structure are:
>
> Lookup, insert and delete are all O(log2 N) and are essentially equiv=
alent to the interval_set (with some extra logic for the reference coun=
ted extents).
>
> Construction of the logical map when an onode is de-serialized is jus=
t O(N) inserts of an empty list -- something like O(log N+1), but not e=
xactly. I think it's something like log(1) + log(2) + log(3) + log(4)..=
=2E.. Not really sure what that adds up to, but it's waaay less than O(=
N).
>
> There may be additional potential benefits to having the extent list =
be temporally ordered. You might be able to infer all sorts of behavior=
al information by examining that list...
>
>
>> -----Original Message-----
>> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
>> Sent: Monday, March 21, 2016 9:36 AM
>> To: Allen Samuels <Allen.Samuels@sandisk.com>; Sage Weil
>> <sage@newdream.net>
>> Cc: ceph-devel <ceph-devel@vger.kernel.org>
>> Subject: Re: Adding compression support for bluestore.
>>
>>
>>
>> On 21.03.2016 18:14, Allen Samuels wrote:
>>>> That's an interesting proposal but I can see following caveats her=
e
>>>> (I beg pardon I  misunderstood something):
>>>> 1) Potentially uncontrolled extent map growth when extensive
>>>> (over)writing takes place.
>>> Yes, a na=C3=AFve insertion policy could lead to uncontrolled growt=
h, but I don't
>> think this needs to be the case. I assume that when you add an "exte=
nt", you
>> won't increase the size of the array unnecessarily, i.e., if the new=
 extent
>> doesn't overlap an existing extent then there's no reason to increas=
e the size
>> of the map array -- actually you want to insert the new extent at th=
e
>> <smallest> array index that doesn't overlap, only increasing the arr=
ay size
>> when that's not possible. I'm not 100% certain of the worst case, bu=
t I believe
>> that it's limited to the ratio between the largest extent and the sm=
allest
>> extent. (i.e., if we assume writes are no larger than -- say -- 1MB =
and the
>> smallest are 4K, then I think the max depth of the array is 1M/4K =3D=
> 2^8, 256.
>> Which is ugly but not awful -- since this is probably a contrived ca=
se. This
>> might be a reason to limit the largest extent size to something a bi=
t smaller
>> (say 256K)...
>> It looks like I misunderstood something... It seemed to me that your=
 array
>> grows depending on the maximum amount of block versions.
>> Imagine you have 1000 writes 0~4K and 1000 writes 8K~4K I supposed t=
hat
>> this will create following array:
>> [
>> 0: <0:{...,4K}, 8K:{...4K}>,
>> ...
>> 999: <0:{...,4K}, 8K:{...4K}>,
>> ]
>>
>> what's happening in your case?
>>
>>>> 2) Read/Lookup algorithmic complexity. To find valid block (or det=
ect
>>>> overwrite) one should sequentially enumerate the full array. Given=
 1)
>>>> that might be very ineffective.
>>> Only requires one log2 lookup for each index of the array.
>> This depends on 1) thus still unclear at the moment.
>>>> 3) It's not dealing with unaligned overwrites. What happens when s=
ome
>>>> block is partially overwritten?
>>> I'm not sure I understand what cases you're referring to. Can you g=
ive an
>> example?
>> Well, as far as I understand in the proposal above you were operatin=
g the
>> entire blocks (i.e. 4K data) Thus overwriting the block is a simple =
case - you
>> just need to create a new block "version" and insert it into an arra=
y.
>> But real user writes seems to be unaligned to block size.
>> E.g.
>> write 0~2048
>> write 1024~3072
>>
>> you have to either track both blocks or merge them. The latter is a =
bit tricky
>> for the compression case.
>>
>>
>>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
