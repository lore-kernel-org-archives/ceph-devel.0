From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: Re: tiering of storage pools in ceph in general
Date: Mon, 26 Nov 2012 11:07:46 +0000
Message-ID: <19903A22-91F4-4309-BCBC-F0F091423729@tchpc.tcd.ie>
References: <5DC113BE-8B3F-44C1-8585-612CDE601856@tchpc.tcd.ie>  <sfid-H20121124-164227-+069.01-1@marduk.tchpc.tcd.ie> <D5EC0B0F4FD94E2BBF64CF5F2B1F2A50@inktank.com>  (sfid-H20121124-164227-+069.01-1@marduk.tchpc.tcd.ie)
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:33615 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369Ab2KZLHs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 06:07:48 -0500
In-Reply-To: <D5EC0B0F4FD94E2BBF64CF5F2B1F2A50@inktank.com>  (sfid-H20121124-164227-+069.01-1@marduk.tchpc.tcd.ie)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org


On 24 Nov 2012, at 16:42, Gregory Farnum wrote:

> On Thursday, November 22, 2012 at 4:33 AM, Jimmy Tang wrote:
>> Hi All,
>>=20
>> Is it possible at this point in time to setup some form of tiering o=
f storage pools in ceph by modifying the crush map? For example I want =
to have my most recently used data on a small set of nodes that have SS=
D's and over time migrate data from the SSD's to some bulk spinning dis=
k using a LRU policy?
> There's no way to have Ceph do this automatically at this time. Tieri=
ng in this fashion traditionally requires the sort of centralized metad=
ata that Ceph and RADOS are designed to avoid, and while interest in it=
 is heating up we haven't yet come up with a new solution. ;)
>=20

that makes sense that tiering in this fashion makes it un-ceph like.

> If your system allows you to do this manually, though =97 yes. You ca=
n create multiple (non-overlapping, presumably) trees within your CRUSH=
 map, one of which would be an "SSD" storage group and one of which wou=
ld be a "normal" storage group. Then create a CRUSH rule which draws fr=
om the SSD group and a rule which draws from the normal group, create a=
 pool using each of those, and write to whichever one at the appropriat=
e time.
> Alternatively, you could also place all the primaries on SSD storage =
but the replicas on regular drives =97 this won't speed up your writes =
much but will mean SSD-speed reads. :)
> -Greg

Ok, so it's possible to set pools of disks/nodes/racks as primary copie=
s of data from which the client can read data from?

Jimmy--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
