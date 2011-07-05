From: Fusheng Han <fsh.han@gmail.com>
Subject: Re: Availability question of RADOS
Date: Tue, 5 Jul 2011 10:10:48 +0800
Message-ID: <CAHq6muHbwob+a1KfsEeJZwGM6UVxAvEH+AJyjk+Ez4RqxfzE7w@mail.gmail.com>
References: <CAHq6muEghn-efzzgQLrkdRjsi40OhmeK9iN2nwB3OR_3AAJJ0g@mail.gmail.com>
	<1309802050.2518.16.camel@wido-laptop.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:53514 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab1GECKt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2011 22:10:49 -0400
Received: by ywe9 with SMTP id 9so2117986ywe.19
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jul 2011 19:10:48 -0700 (PDT)
In-Reply-To: <1309802050.2518.16.camel@wido-laptop.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Hello, Wido

I appreciate your answer.
And some more discussion goes below.

On Tue, Jul 5, 2011 at 1:54 AM, Wido den Hollander <wido@widodh.nl> wro=
te:
> Hi,
>
> On Tue, 2011-07-05 at 00:25 +0800, Fusheng Han wrote:
>> Hi, all
>>
>> After reading the RADOS paper, I have some questions about
>> availability of RADOS. Nowhere I can find to discuss, so I'm here.
>> When adding new host to the cluster, some placement group will be
>> mapped to the new one. After the cluster info incremental propagates
>> to all the OSDs and clients, the client write operation will be
>> directed to the PG whose primary is at the new host. Before the new
>> host get the data migration down, it can not service these requests.
>> And due to the limitation of network bandwidth, the data migration m=
ay
>> take long. There is a long time that the new host can not service. I
>> got confused.
>
> Yes, during migration a PG will become unavailable for a short period=
 of
> time. In a large cluster you have a large number of PGs where each PG
> doesn't contain that much data, which makes this period short.
>
> What kind of bandwith are you talking about? Ceph/RADOS is intended t=
o
> run in datacenters where you have low latency high bandwith (1G)
> networks. Migrating a PG would take that much time in such environmen=
ts.

What I mentioned is the network bandwidth limitation even with 1Gbps NI=
C.
Taking an imagine cluster for example:
Node: 10
Disk: 10TB per node (1TB per disk, 10 disks per node)
Utilization: 80% (i.e. totally 80TB data, 8TB data per node)

While adding a new node, 7.2TB (=3D 80TB / 11) data will be migrated to
the new one. With 1Gbps bandwidth, for best case, it will cost 7200
seconds (=3D 7.2TB / 1Gbps) to complete migration. For the last
placement group migrated to the new node, it will become unavailable
for 7200 seconds.

=46usheng Han

>
> Wido
>
>> Do I miss something important in this paper?
>>
>> Thank you all
>> Fusheng Han
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
