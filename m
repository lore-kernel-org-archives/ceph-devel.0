From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Availability question of RADOS
Date: Tue, 5 Jul 2011 08:37:35 -0700
Message-ID: <CAF3hT9BaeBdp+VdjFgj3N17N-me0+LXicvc+_5rOLMRFMcg6hw@mail.gmail.com>
References: <CAHq6muEghn-efzzgQLrkdRjsi40OhmeK9iN2nwB3OR_3AAJJ0g@mail.gmail.com>
	<1309802050.2518.16.camel@wido-laptop.pcextreme.nl>
	<CAHq6muHbwob+a1KfsEeJZwGM6UVxAvEH+AJyjk+Ez4RqxfzE7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:53824 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755391Ab1GEPhg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jul 2011 11:37:36 -0400
Received: by yia27 with SMTP id 27so2291560yia.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jul 2011 08:37:35 -0700 (PDT)
In-Reply-To: <CAHq6muHbwob+a1KfsEeJZwGM6UVxAvEH+AJyjk+Ez4RqxfzE7w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fusheng Han <fsh.han@gmail.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On Mon, Jul 4, 2011 at 7:10 PM, Fusheng Han <fsh.han@gmail.com> wrote:
> Hello, Wido
>
> I appreciate your answer.
> And some more discussion goes below.
>
> On Tue, Jul 5, 2011 at 1:54 AM, Wido den Hollander <wido@widodh.nl> wrote:
>> Hi,
>>
>> On Tue, 2011-07-05 at 00:25 +0800, Fusheng Han wrote:
>>> Hi, all
>>>
>>> After reading the RADOS paper, I have some questions about
>>> availability of RADOS. Nowhere I can find to discuss, so I'm here.
>>> When adding new host to the cluster, some placement group will be
>>> mapped to the new one. After the cluster info incremental propagates
>>> to all the OSDs and clients, the client write operation will be
>>> directed to the PG whose primary is at the new host. Before the new
>>> host get the data migration down, it can not service these requests.
>>> And due to the limitation of network bandwidth, the data migration may
>>> take long. There is a long time that the new host can not service. I
>>> got confused.
>>
>> Yes, during migration a PG will become unavailable for a short period of
>> time. In a large cluster you have a large number of PGs where each PG
>> doesn't contain that much data, which makes this period short.
>>
>> What kind of bandwith are you talking about? Ceph/RADOS is intended to
>> run in datacenters where you have low latency high bandwith (1G)
>> networks. Migrating a PG would take that much time in such environments.
>
> What I mentioned is the network bandwidth limitation even with 1Gbps NIC.
> Taking an imagine cluster for example:
> Node: 10
> Disk: 10TB per node (1TB per disk, 10 disks per node)
> Utilization: 80% (i.e. totally 80TB data, 8TB data per node)
>
> While adding a new node, 7.2TB (= 80TB / 11) data will be migrated to
> the new one. With 1Gbps bandwidth, for best case, it will cost 7200
> seconds (= 7.2TB / 1Gbps) to complete migration. For the last
> placement group migrated to the new node, it will become unavailable
> for 7200 seconds.

"Acting groups" may only be mentioned briefly, but are very important.
When the OSD that is supposed to be primary for a PG can't service it
(either because it's down, or it doesn't have the data), the monitor
cluster will create a new "acting" set for that PG. Generally it
promotes a replica that has the PG data to be the primary and makes
the proper primary a replica, then removes the acting set (letting it
go back to the properly-mapped set) once the primary can serve the
data. So PG unavailability is only a few seconds (or less) unless
there's a bug somewhere.
-Greg
