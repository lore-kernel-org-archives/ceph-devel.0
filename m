From: Samuel Just <sam.just@inktank.com>
Subject: Re: osd crash in ReplicatedPG::add_object_context_to_pg_stat(ReplicatedPG::ObjectContext*,
 pg_stat_t*)
Date: Mon, 15 Oct 2012 12:57:23 -0700
Message-ID: <CA+4uBUYnu-fNPb4Dbod72yamynOGdzDMHT8ZXjn4-RcRPJ1D3Q@mail.gmail.com>
References: <5077458A.7030108@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:65375 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517Ab2JOT5Y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Oct 2012 15:57:24 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so2224486vcb.19
        for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 12:57:23 -0700 (PDT)
In-Reply-To: <5077458A.7030108@univ-nantes.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Do you have a coredump for the crash?  Can you reproduce the crash with:

debug filestore = 20
debug osd = 20

and post the logs?

As far as the incomplete pg goes, can you post the output of

ceph pg <pgid> query

where <pgid> is the pgid of the incomplete pg (e.g. 1.34)?

Thanks
-Sam

On Thu, Oct 11, 2012 at 3:17 PM, Yann Dupont <Yann.Dupont@univ-nantes.fr> wrote:
> Hello everybody.
>
> I'm currently having problem with 1 of my OSD, crashing with  this trace :
>
> ceph version 0.52 (commit:e48859474c4944d4ff201ddc9f5fd400e8898173)
>  1: /usr/bin/ceph-osd() [0x737879]
>  2: (()+0xf030) [0x7f43f0af0030]
>  3:
> (ReplicatedPG::add_object_context_to_pg_stat(ReplicatedPG::ObjectContext*,
> pg_stat_t*)+0x292) [0x555262]
>  4: (ReplicatedPG::recover_backfill(int)+0x1c1a) [0x55c93a]
>  5: (ReplicatedPG::start_recovery_ops(int, PG::RecoveryCtx*)+0x26a)
> [0x563c1a]
>  6: (OSD::do_recovery(PG*)+0x39d) [0x5d3c9d]
>  7: (OSD::RecoveryWQ::_process(PG*)+0xd) [0x6119fd]
>  8: (ThreadPool::worker()+0x82b) [0x7c176b]
>  9: (ThreadPool::WorkThread::entry()+0xd) [0x5f609d]
>  10: (()+0x6b50) [0x7f43f0ae7b50]
>  11: (clone()+0x6d) [0x7f43ef81b78d]
>
> Restarting gives the same message after some seconds.
> I've been watching the bug tracker but I don't see something related.
>
> Some informations : kernel is 3.6.1, with "standard" debian packages from
> ceph.com
>
> My ceph cluster was running well and stable on 6 osd since june (3
> datacenters, 2 with 2 nodes, 1 with 4 nodes, a replication of 2, and
> adjusted weight to try to balance data evenly). Beginned with the
> then-up-to-date version, then 0.48, 49,50,51... Data store is on XFS.
>
> I'm currently in the process of growing my ceph from 6 nodes to 12 nodes. 11
> nodes are currently in ceph, for a 130 TB total. Declaring new osd was OK,
> the data has moved "quite" ok (in fact I had some OSD crash - not
> definitive, the osd restart ok-, maybe related to an error in my new nodes
> network configuration that I discovered after. More on that later, I can
> find the traces, but I'm not sure it's related)
>
> When ceph was finally stable again, with HEALTH_OK, I decided to reweight
> the osd (that was tuesday). Operation went quite OK, but near the end of
> operation (0,085% left), 1 of my OSD crashed, and won't start again.
>
> More problematic, with this osd down, I have 1 incomplete PG :
>
> ceph -s
>    health HEALTH_WARN 86 pgs backfill; 231 pgs degraded; 4 pgs down; 15 pgs
> incomplete; 4 pgs peering; 134 pgs recovering; 19 pgs stuck inactive; 455
> pgs stuck unclean; recovery 2122878/23181946 degraded (9.157%);
> 2321/11590973 unfound (0.020%); 1 near full osd(s)
>    monmap e1: 3 mons at
> {chichibu=172.20.14.130:6789/0,glenesk=172.20.14.131:6789/0,karuizawa=172.20.14.133:6789/0},
> election epoch 20, quorum 0,1,2 chichibu,glenesk,karuizawa
>    osdmap e13184: 11 osds: 10 up, 10 in
>     pgmap v2399093: 1728 pgs: 165 active, 1270 active+clean, 8
> active+recovering+degraded, 41 active+recovering+degraded+remapped+backfill,
> 4 down+peering, 137 active+degraded, 3 active+clean+scrubbing, 15
> incomplete, 40 active+recovering, 45 active+recovering+degraded+backfill;
> 44119 GB data, 84824 GB used, 37643 GB / 119 TB avail; 2122878/23181946
> degraded (9.157%); 2321/11590973 unfound (0.020%)
>    mdsmap e321: 1/1/1 up {0=karuizawa=up:active}, 2 up:standby
>
> how is it possible as I have a replication of 2  ?
>
> Is it a known problem ?
>
> Cheers,
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
