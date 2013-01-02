From: Sage Weil <sage@inktank.com>
Subject: Re: Very intensive I/O under mon process
Date: Wed, 2 Jan 2013 08:35:19 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301020833180.11884@cobra.newdream.net>
References: <CABYiri_tx5+sSw3mZrVmtey6P6UcaRq_n4TxukzixUVm458u4g@mail.gmail.com> <50E45997.9060205@inktank.com> <CABYiri9bUsO4S2SKU2rmt4V0oCxL6pw4JmKhZm-dNS_bJR2OOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54226 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab3ABQfU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jan 2013 11:35:20 -0500
In-Reply-To: <CABYiri9bUsO4S2SKU2rmt4V0oCxL6pw4JmKhZm-dNS_bJR2OOQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Joao Eduardo Luis <joao.luis@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 2 Jan 2013, Andrey Korolyov wrote:
> On Wed, Jan 2, 2013 at 8:00 PM, Joao Eduardo Luis <joao.luis@inktank.com> wrote:
> > On 01/02/2013 03:40 PM, Andrey Korolyov wrote:
> >>
> >> I have just observed that ceph-mon process, at least bobtail one, has
> >> an extremely high density of writes - times above _overall_ cluster
> >> amount of writes, measured by qemu driver(and they are very close to
> >> be fair). For example, test cluster of 32 osds have 7.5 MByte/s of
> >> writes on each mon node having overall amount about 1.5 Mbyte/s and
> >> dev- with only three osds has values is about 1Mbyte/s with
> >> accumulated real write bandwidth of tens of kilobytes per second.
> >>
> >> I`m afraid if this is normal, I may hit a limit of spinning storage
> >> increasing test cluster, say, twenty times up of number of osd and
> >> related ``idle'' write bandwidth.
> >
> >
> > High debugging levels (specially 'debug ms', 'debug mon' or 'debug paxos')
> > should significantly increase IO on the monitors. Might that be the case?
> 
> Nope, all debug levels, including mons are set to 0/0. I also see that
> the ``no-client'' cluster shows a very small amount of such writes
> under mon, 10-20kByte/s, and one idle client (writing couple of bytes
> without O_SYNC) raise this value times up to ~200kB/s and so on, so
> may be I`m wrong before and writes correlate with amount of clients
> too(six clients plus three control nodes accessing via API in the
> context of previous message for both environments).

The mon is writing out state updates at regular intervals, mostly PG stat 
(object and byte counts) updates--what you see from 'ceph pg dump'.  You 
should see IO go up to some ceiling as more IO is applied to the cluster 
and then level off.  The frequency of these writes, and thus the total IO 
rate, can be controlled via the 'paxos propose interval' knob (default is 
1 or 2 seconds).

sage
