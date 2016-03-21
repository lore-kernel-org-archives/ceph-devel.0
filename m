From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Adding compression support for bluestore.
Date: Mon, 21 Mar 2016 17:14:29 +0000
Message-ID: <CY1PR0201MB18978F2B3F07A33361449E95E88F0@CY1PR0201MB1897.namprd02.prod.outlook.com>
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
 <56F022ED.6000909@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0056.outbound.protection.outlook.com ([207.46.100.56]:27008
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752150AbcCUROc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Mar 2016 13:14:32 -0400
In-Reply-To: <56F022ED.6000909@mirantis.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

After reading your proposal and Sage's response, I have a hybrid propos=
al that I think is BOBW...

This proposal is based on Sage's comments about there being two differe=
nt structures.

Leveraging my proposal for a unified extent (included by reference). Fo=
r our purpose each extent is fully self-contained, i.e., logical addres=
s/size, physical address/size, checksums, flags, etc....

The onode value (i.e., the one in the KV storage) contains only  LIST o=
f extents (yes a list, read on!). The list is ordered temporally, this =
provides the necessary ordering information to disambiguate between two=
 extents that overlap/occlude the same logical address range.

The in-memory onode contains an auxilliary map that's ordered by logica=
l address. Entries in the map point to the extent that provides the dat=
a for that logical address range. There can be multiple entries in the =
map that reference the same element of the list. This map cheaply disam=
biguates between multiple extents that overlap in logical address space=
=2E This is the case that Sage pointed out causes problems for the data=
 structure that you propose. In my proposal, you'll have two entries in=
 the logical map pointing to the same entry in the extent map.

We reference count between the logical map and the extent list to know =
when an extent no longer contributes data to this object (and hence can=
 be removed from the list and potentially have it's space recovered).

Costs for this dual data structure are:

Lookup, insert and delete are all O(log2 N) and are essentially equival=
ent to the interval_set (with some extra logic for the reference counte=
d extents).

Construction of the logical map when an onode is de-serialized is just =
O(N) inserts of an empty list -- something like O(log N+1), but not exa=
ctly. I think it's something like log(1) + log(2) + log(3) + log(4)....=
=2E Not really sure what that adds up to, but it's waaay less than O(N)=
=2E

There may be additional potential benefits to having the extent list be=
 temporally ordered. You might be able to infer all sorts of behavioral=
 information by examining that list...


> -----Original Message-----
> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
> Sent: Monday, March 21, 2016 9:36 AM
> To: Allen Samuels <Allen.Samuels@sandisk.com>; Sage Weil
> <sage@newdream.net>
> Cc: ceph-devel <ceph-devel@vger.kernel.org>
> Subject: Re: Adding compression support for bluestore.
>=20
>=20
>=20
> On 21.03.2016 18:14, Allen Samuels wrote:
> >>
> >> That's an interesting proposal but I can see following caveats her=
e
> >> (I beg pardon I  misunderstood something):
> >> 1) Potentially uncontrolled extent map growth when extensive
> >> (over)writing takes place.
> > Yes, a na=EFve insertion policy could lead to uncontrolled growth, =
but I don't
> think this needs to be the case. I assume that when you add an "exten=
t", you
> won't increase the size of the array unnecessarily, i.e., if the new =
extent
> doesn't overlap an existing extent then there's no reason to increase=
 the size
> of the map array -- actually you want to insert the new extent at the
> <smallest> array index that doesn't overlap, only increasing the arra=
y size
> when that's not possible. I'm not 100% certain of the worst case, but=
 I believe
> that it's limited to the ratio between the largest extent and the sma=
llest
> extent. (i.e., if we assume writes are no larger than -- say -- 1MB a=
nd the
> smallest are 4K, then I think the max depth of the array is 1M/4K =3D=
> 2^8, 256.
> Which is ugly but not awful -- since this is probably a contrived cas=
e. This
> might be a reason to limit the largest extent size to something a bit=
 smaller
> (say 256K)...
> It looks like I misunderstood something... It seemed to me that your =
array
> grows depending on the maximum amount of block versions.
> Imagine you have 1000 writes 0~4K and 1000 writes 8K~4K I supposed th=
at
> this will create following array:
> [
> 0: <0:{...,4K}, 8K:{...4K}>,
> ...
> 999: <0:{...,4K}, 8K:{...4K}>,
> ]
>=20
> what's happening in your case?
>=20
> >> 2) Read/Lookup algorithmic complexity. To find valid block (or det=
ect
> >> overwrite) one should sequentially enumerate the full array. Given=
 1)
> >> that might be very ineffective.
> > Only requires one log2 lookup for each index of the array.
> This depends on 1) thus still unclear at the moment.
> >> 3) It's not dealing with unaligned overwrites. What happens when s=
ome
> >> block is partially overwritten?
> > I'm not sure I understand what cases you're referring to. Can you g=
ive an
> example?
> >
> Well, as far as I understand in the proposal above you were operating=
 the
> entire blocks (i.e. 4K data) Thus overwriting the block is a simple c=
ase - you
> just need to create a new block "version" and insert it into an array=
=2E
> But real user writes seems to be unaligned to block size.
> E.g.
> write 0~2048
> write 1024~3072
>=20
> you have to either track both blocks or merge them. The latter is a b=
it tricky
> for the compression case.
>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
