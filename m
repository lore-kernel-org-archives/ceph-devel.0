From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Availability question of RADOS
Date: Mon, 04 Jul 2011 19:54:10 +0200
Message-ID: <1309802050.2518.16.camel@wido-laptop.pcextreme.nl>
References: <CAHq6muEghn-efzzgQLrkdRjsi40OhmeK9iN2nwB3OR_3AAJJ0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:51207 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757386Ab1GDRyM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jul 2011 13:54:12 -0400
In-Reply-To: <CAHq6muEghn-efzzgQLrkdRjsi40OhmeK9iN2nwB3OR_3AAJJ0g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fusheng Han <fsh.han@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On Tue, 2011-07-05 at 00:25 +0800, Fusheng Han wrote:
> Hi, all
> 
> After reading the RADOS paper, I have some questions about
> availability of RADOS. Nowhere I can find to discuss, so I'm here.
> When adding new host to the cluster, some placement group will be
> mapped to the new one. After the cluster info incremental propagates
> to all the OSDs and clients, the client write operation will be
> directed to the PG whose primary is at the new host. Before the new
> host get the data migration down, it can not service these requests.
> And due to the limitation of network bandwidth, the data migration may
> take long. There is a long time that the new host can not service. I
> got confused.

Yes, during migration a PG will become unavailable for a short period of
time. In a large cluster you have a large number of PGs where each PG
doesn't contain that much data, which makes this period short.

What kind of bandwith are you talking about? Ceph/RADOS is intended to
run in datacenters where you have low latency high bandwith (1G)
networks. Migrating a PG would take that much time in such environments.

Wido

> Do I miss something important in this paper?
> 
> Thank you all
> Fusheng Han
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


