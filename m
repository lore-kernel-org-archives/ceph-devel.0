From: Gregory Farnum <greg@inktank.com>
Subject: Re: OSD network failure
Date: Mon, 19 Nov 2012 14:19:35 -0800
Message-ID: <CAPYLRziivWF8wYX64CO_wBmF0WZP0_FT6xHWBA6UW+b0cEs+JA@mail.gmail.com>
References: <CAJH6TXi5-SogM9=vJKcb5bEknCvRd4BZ8JvgH5tkXM6pDeLfZQ@mail.gmail.com>
	<50A4AA79.80009@inktank.com>
	<CAJH6TXixnqBgxOdk3UD2Tr4RTC5_RYnfXW9wmuHjD5ZD6G2OCQ@mail.gmail.com>
	<50A6EEB6.2020400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41426 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab2KSWTg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 17:19:36 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so7626626iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 14:19:36 -0800 (PST)
In-Reply-To: <50A6EEB6.2020400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Nov 16, 2012 at 5:56 PM, Josh Durgin <josh.durgin@inktank.com> =
wrote:
> On 11/15/2012 01:51 AM, Gandalf Corvotempesta wrote:
>>
>> 2012/11/15 Josh Durgin <josh.durgin@inktank.com>:
>>>
>>> So basically you'd only need a single nic per storage node. Multipl=
e
>>> can be useful to separate frontend and backend traffic, but ceph
>>> is designed to maintain strong consistency when failures occur.
>>
>>
>> Probably i've not exaplained well.
>> I'll have multiple nics, one for frontend, one for backend used as O=
DS
>> sync network.
>> What happens in case of backend network failure? The frontend networ=
k
>> is still ok, OSD is
>> still reachable but is not able to sync datas.
>
>
> Ah, ok. By default, the OSDs use the backend network for heartbeats,
> so if it fails, they will notice and report peers they can't reach as
> failed to the monitors, and the normal failure handling takes care
> of things.
>
> If you're worried about consistency, remember that a write won't
> complete until it's on disk on all replicas. If you're interested
> in the gory details of maintaining consistency, check out the peering
> process [1].
>
> Josh
>
> [1] http://ceph.com/docs/master/dev/peering/

Actually, right now a failed cluster and an up public network is
something the OSDs do not handle well =97 they will mark each other dow=
n
on the monitor and then tell the monitor "hey, I'm not dead!" and
start flapping pretty horrendously. We first ran across it a couple
weeks ago and have started to think about it, but I'm not sure a fix
for this is going to make it into the initial Bobtail release. :(
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
