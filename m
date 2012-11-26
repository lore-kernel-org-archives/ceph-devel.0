From: Gregory Farnum <greg@inktank.com>
Subject: Re: tiering of storage pools in ceph in general
Date: Mon, 26 Nov 2012 10:53:56 -0800
Message-ID: <CAPYLRzgK7rikkWmjPn8QG-fRv36uk1i6zfofW_AQD=2JXfRPLw@mail.gmail.com>
References: <5DC113BE-8B3F-44C1-8585-612CDE601856@tchpc.tcd.ie>
	<sfid-H20121124-164227-+069.01-1@marduk.tchpc.tcd.ie>
	<D5EC0B0F4FD94E2BBF64CF5F2B1F2A50@inktank.com>
	<19903A22-91F4-4309-BCBC-F0F091423729@tchpc.tcd.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:45424 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655Ab2KZSx6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 13:53:58 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so6086477lag.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Nov 2012 10:53:56 -0800 (PST)
In-Reply-To: <19903A22-91F4-4309-BCBC-F0F091423729@tchpc.tcd.ie>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jimmy Tang <jtang@tchpc.tcd.ie>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Nov 26, 2012 at 3:07 AM, Jimmy Tang <jtang@tchpc.tcd.ie> wrote:
>
> On 24 Nov 2012, at 16:42, Gregory Farnum wrote:
>
>> On Thursday, November 22, 2012 at 4:33 AM, Jimmy Tang wrote:
>>> Hi All,
>>>
>>> Is it possible at this point in time to setup some form of tiering =
of storage pools in ceph by modifying the crush map? For example I want=
 to have my most recently used data on a small set of nodes that have S=
SD's and over time migrate data from the SSD's to some bulk spinning di=
sk using a LRU policy?
>> There's no way to have Ceph do this automatically at this time. Tier=
ing in this fashion traditionally requires the sort of centralized meta=
data that Ceph and RADOS are designed to avoid, and while interest in i=
t is heating up we haven't yet come up with a new solution. ;)
>>
>
> that makes sense that tiering in this fashion makes it un-ceph like.
>
>> If your system allows you to do this manually, though =97 yes. You c=
an create multiple (non-overlapping, presumably) trees within your CRUS=
H map, one of which would be an "SSD" storage group and one of which wo=
uld be a "normal" storage group. Then create a CRUSH rule which draws f=
rom the SSD group and a rule which draws from the normal group, create =
a pool using each of those, and write to whichever one at the appropria=
te time.
>> Alternatively, you could also place all the primaries on SSD storage=
 but the replicas on regular drives =97 this won't speed up your writes=
 much but will mean SSD-speed reads. :)
>> -Greg
>
> Ok, so it's possible to set pools of disks/nodes/racks as primary cop=
ies of data from which the client can read data from?

Yep. This is accomplished via the crush "take" and "choose" commands =97
"take" is the starting point for picking OSDs from, and you can have
multiple "take" commands in a single rule whose contents are "emit"ted
in order. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
