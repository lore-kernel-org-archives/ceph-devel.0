From: Sage Weil <sage@newdream.net>
Subject: Re: Long peering - throttle at FileStore::queue_transactions
Date: Mon, 4 Jan 2016 22:21:57 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601042220510.29548@cpach.fuggernut.com>
References: <CAKtk8hdb1dTJ013Qed1D9Wu_wWNvTM9H0hjqg2PGVr9xBnt51g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51375 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884AbcAEDV6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jan 2016 22:21:58 -0500
In-Reply-To: <CAKtk8hdb1dTJ013Qed1D9Wu_wWNvTM9H0hjqg2PGVr9xBnt51g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang Yang <guangyy@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, sjust@redhat.com

On Mon, 4 Jan 2016, Guang Yang wrote:
> Hi Cephers,
> Happy New Year! I got question regards to the long PG peering..
> 
> Over the last several days I have been looking into the *long peering*
> problem when we start a OSD / OSD host, what I observed was that the
> two peering working threads were throttled (stuck) when trying to
> queue new transactions (writing pg log), thus the peering process are
> dramatically slow down.
> 
> The first question came to me was, what were the transactions in the
> queue? The major ones, as I saw, included:
> 
> - The osd_map and incremental osd_map, this happens if the OSD had
> been down for a while (in a large cluster), or when the cluster got
> upgrade, which made the osd_map epoch the down OSD had, was far behind
> the latest osd_map epoch. During the OSD booting, it would need to
> persist all those osd_maps and generate lots of filestore transactions
> (linear with the epoch gap).
> > As the PG was not involved in most of those epochs, could we only take and persist those osd_maps which matter to the PGs on the OSD?

This part should happen before the OSD sends the MOSDBoot message, before 
anyone knows it exists.  There is a tunable threshold that controls how 
recent the map has to be before the OSD tries to boot.  If you're 
seeing this in the real world, be probably just need to adjust that value 
way down to something small(er).

sage

