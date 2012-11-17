From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: OSD network failure
Date: Fri, 16 Nov 2012 17:56:06 -0800
Message-ID: <50A6EEB6.2020400@inktank.com>
References: <CAJH6TXi5-SogM9=vJKcb5bEknCvRd4BZ8JvgH5tkXM6pDeLfZQ@mail.gmail.com> <50A4AA79.80009@inktank.com> <CAJH6TXixnqBgxOdk3UD2Tr4RTC5_RYnfXW9wmuHjD5ZD6G2OCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56205 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880Ab2KQB4l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Nov 2012 20:56:41 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so2230180pad.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Nov 2012 17:56:40 -0800 (PST)
In-Reply-To: <CAJH6TXixnqBgxOdk3UD2Tr4RTC5_RYnfXW9wmuHjD5ZD6G2OCQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 11/15/2012 01:51 AM, Gandalf Corvotempesta wrote:
> 2012/11/15 Josh Durgin <josh.durgin@inktank.com>:
>> So basically you'd only need a single nic per storage node. Multiple
>> can be useful to separate frontend and backend traffic, but ceph
>> is designed to maintain strong consistency when failures occur.
>
> Probably i've not exaplained well.
> I'll have multiple nics, one for frontend, one for backend used as ODS
> sync network.
> What happens in case of backend network failure? The frontend network
> is still ok, OSD is
> still reachable but is not able to sync datas.

Ah, ok. By default, the OSDs use the backend network for heartbeats,
so if it fails, they will notice and report peers they can't reach as
failed to the monitors, and the normal failure handling takes care
of things.

If you're worried about consistency, remember that a write won't
complete until it's on disk on all replicas. If you're interested
in the gory details of maintaining consistency, check out the peering
process [1].

Josh

[1] http://ceph.com/docs/master/dev/peering/

