From: Sage Weil <sage@newdream.net>
Subject: Re: need help in a recovering ceph
Date: Mon, 28 Nov 2011 09:44:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111280943180.11288@cobra.newdream.net>
References: <4ED10636.6070705@biodatomics.com> <4ED36701.3060107@widodh.nl>
 <4ED37271.8030504@biodatomics.com> <CAF3hT9CS9EMnuUjTJF3S9L7U21xaOiin8eaezha2QToNBgATKA@mail.gmail.com>
 <4ED3BCBE.6000906@biodatomics.com> <CAF3hT9CFYe9AeUH5GBCcaUsfdP9itoL9ByVmbPZwe3ETuAT1nQ@mail.gmail.com>
 <4ED3C64B.5060601@biodatomics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43745 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab1K1RoT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2011 12:44:19 -0500
In-Reply-To: <4ED3C64B.5060601@biodatomics.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: max@biodatomics.com
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, 28 Nov 2011, Maxim Mikheev wrote:
> root@s1-2core:~# ceph mon injectargs --mon_osd_full_ratio 96
> 2011-11-28 12:29:39.067860 mon <- [mon,injectargs]
> 2011-11-28 12:29:39.068438 mon.0 -> 'unknown command injectargs' (-22)
> root@s1-2core:~# ceph mon injectargs "mon osd full ratio = 96"
> 2011-11-28 12:29:53.431669 mon <- [mon,injectargs,mon osd full ratio = 96]
> 2011-11-28 12:29:53.432076 mon.0 -> 'unknown command injectargs' (-22)

Try

 ceph mon tell \* injectargs '--mon-osd-full-ratio 96'

and then do the rados bench thing.

sage


> 
> Max
> 
> 
> 
> On 11/28/2011 12:23 PM, Gregory Farnum wrote:
> > On Mon, Nov 28, 2011 at 8:54 AM, Maxim Mikheev<mikhmv@biodatomics.com>
> > wrote:
> > > I understand you Greg. I hope you have a good Thanksgiving.
> > > 
> > > I did:
> > > root@s2-8core:~# ceph osd reweight-by-utilization
> > > 2011-11-28 11:38:40.201428 mon<- [osd,reweight-by-utilization]
> > > 2011-11-28 11:38:40.209388 mon.0 ->  'SUCCESSFUL reweight-by-utilization:
> > > average_util: 0.386560, overload_util: 0.463872. overloaded osds: 2
> > > [1.000000 ->  0.406347], ' (0)
> > > 
> > > How can I initiate transfer data for balancing?
> > > 
> > > root@s2-8core:~# ceph -w
> > > 2011-11-28 11:40:19.634094    pg v385135: 594 pgs: 594 active+clean; 254
> > > GB
> > > data, 522 GB used, 673 GB / 1351 GB avail
> > > 2011-11-28 11:40:19.635551   mds e182: 1/1/1 up {0=a=up:active}
> > > 2011-11-28 11:40:19.635592   osd e465: 3 osds: 3 up, 3 in full
> > > 2011-11-28 11:40:19.635665   log 2011-11-28 09:22:55.618408 osd.2
> > > 192.168.2.12:6800/1097 476 : [INF] 1.1f scrub ok
> > > 2011-11-28 11:40:19.635759   mon e1: 1 mons at {a=192.168.2.11:6789/0}
> > > 
> > > Monitor didn't show any transfer activity after changing weights.
> > Hmmm. It looks like we need to rework the OSDs so they subscribe to
> > map updates when full. Try running "rados -p data bench 10 write". It
> > will fail, but let it go for a few seconds and it should cause all the
> > OSDs to update their maps and begin shuffling data.
> > 
> > > And another question:
> > > How can I change mon_osd_full_ratio?
> > > I tried this:
> > > root@s2-8core:~# ceph mon injectargs 'mon_osd_full_ratio = 96'
> > > 2011-11-28 11:53:11.070059 mon<- [mon,injectargs,mon_osd_full_ratio = 96]
> > > 2011-11-28 11:53:11.070383 mon.0 ->  'unknown command injectargs' (-22)
> > either:
> > ceph mon injectargs --mon_osd_full_ratio 96
> > or
> > ceph mon injectargs "mon osd full ratio = 96"
> > should work.
> > :)
> > -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
