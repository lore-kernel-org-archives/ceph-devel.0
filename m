From: =?UTF-8?Q?Pawe=c5=82_Sadowski?= <ceph@sadziu.pl>
Subject: Re: Single slow OSD can cause unfound object
Date: Tue, 11 Oct 2016 15:43:55 +0200
Message-ID: <d14161f2-1b29-92f0-6028-8ad978a3bf99@sadziu.pl>
References: <ed8ed02e-4fb7-25ad-3a5f-d462f70409e2@sadziu.pl>
 <CAC7t81ax_Ex9ht4pLm3KfvqQTaWPg+E2Tn8hZfA45WMuRMRikg@mail.gmail.com>
Reply-To: ceph@sadziu.pl
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from h82-143-163-170-static.e-wro.net.pl ([82.143.163.170]:34330
        "EHLO mail.sadziu.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752754AbcJKNoD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2016 09:44:03 -0400
In-Reply-To: <CAC7t81ax_Ex9ht4pLm3KfvqQTaWPg+E2Tn8hZfA45WMuRMRikg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexey Sheplyakov <asheplyakov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks for response, answers inline.

On 10/11/2016 01:16 PM, Alexey Sheplyakov wrote:
> Paweł,
>
> > Shouldn't Ceph stop IO if there is only one copy in this case
>
> In fact the cluster has stopped such writes:
> 2016-10-11 08:46:57.978633 osd.5 10.99.132.157:6800/204989 <http://10.99.132.157:6800/204989> 19 : cluster [WRN] slow request 30.057755 seconds old, received at 2016-10-11 08:46:27.920763: osd_op(client.657994.0:383815 0.1bc9df4d rbd_data.39232ae8944a.0000000000001ccc [set-alloc-hint object_size 4194304 write_size 4194304,write 2662400~4096] snapc 0=[] RETRY=4 ack+ondisk+retry+write+known_if_redirected e1394) currently waiting for missing object
Cluster stopped write to this object which is already unfound. I removed
only one OSD (at 08:35) so single copy went down. If there will be a
second copy after a while object would be recovered. Am I missing
something here?
> > - slow down single OSD (in my case reduce CPU time using cgroups:
> cpu.cfs_quota_us 15000) > - sleep 120 > - ceph osd out 6 > - sleep 15
> > - stop ceph-osd id=6 > - unfound objects appear
> Just because the object is unfound doesn't mean it's permanently lost.
> Instead this means the OSD which serves the corresponding PG knows the
> object should exist, but hasn't found/queried OSD(s) which might have
> a copy of that object yet. Finding/querying such OSDs might take a
> while (especially when recovery is in progress). If there are no stuck
> unclean PGs one should not worry about such transient unfound objects.  
> > throttling mechanism is blocking recovery operations/whole OSD[4]
> when there is a lot of > client requests for missing objects. I think
> it shouldn't be like that. > perf dump | grep -A 2
> 'throttle-osd_client_messages' >    "throttle-osd_client_messages": {
> >        "val": 100, >        "max": 100,
> As far as I understand this does not restrict the recovery/backfill
> traffic (those are *not* client messages).
> In order to perform the recovery faster one should allocate more
> resources (CPU/RAM/network traffic) for the recovery/backfill which
> means less resources can be spent for serving clients' requests. 
So in my test cluster recovery is not progressing at all. If I cut
client requests and restart OSDs then recovery will progress just a bit
and then hangs. unfound objects will still be there - so there is no
second copy. So probably recovery is blocked not by client but by those
unfound objects. Even 'ceph osd lost OSD_ID' doesn't change it. But
anyway, client requests can block 'ceph pg query/mark_unfound_lost' and
other 'administrative' commands. So it's not good.
> There are a number of tunables which influence "fast recovery"/"low
> additional load" balance, such as 'osd recovery max active', 'osd
> recovery threads', 'osd_max_backfills', etc. You might want to play
> with those (preferably in a test cluster). Be careful, however, to not
> run into "Oh, that recovery thing eats too much RAM, hogs the CPUs,
> saturates the network, and clients which don't need
> missing/problematic objects are also dog slow! I don't think it should
> be like that." 
All (even some undocumented) of those parameters are tuned on our clusters.
> Best regards,
>        Alexey
> On Tue, Oct 11, 2016 at 12:35 PM, Paweł Sadowski <ceph@sadziu.pl
> <mailto:ceph@sadziu.pl>> wrote:
>
>     Hi, I managed to trigger unfound objects on a pool with size 3 and
>     min_size 2 just by removing 'slow' OSD (out and then stop) which
>     is quite frightening. Shouldn't Ceph stop IO if there is only one
>     copy in this case (even during recovery/peering/etc)? I'm able to
>     reproduce this on Hammer (0.94.5, 0.94.9) and Jewel (10.2.3). So
>     far I wasn't able to trigger this behavior by just stopping such
>     OSD (still testing). Second thing: throttling mechanism is
>     blocking recovery operations/whole OSD[4] when there is a lot of
>     client requests for missing objects. I think it shouldn't be like
>     that. 1: logs from Jewel
>     https://gist.github.com/anonymous/c8618adca8984132c82f16c351222883
>     <https://gist.github.com/anonymous/c8618adca8984132c82f16c351222883>
>     2: steps to reproduce  - put some load on the cluster (run FIO
>     with high iodepth)  - slow down single OSD (in my case reduce CPU
>     time using cgroups: cpu.cfs_quota_us 15000)  - sleep 120  - ceph
>     osd out 6  - sleep 15  - stop ceph-osd id=6  - unfound objects
>     appear This is not 100% reproducible but in my test lab (9 OSDs)
>     I'm able to trigger this very easily. 3: mon-01:~ # ceph osd pool
>     get rbd size size: 3 mon-01:~ # ceph osd pool get rbd min_size
>     min_size: 2 mon-01:~ # ceph --version ceph version 10.2.3
>     (ecc23778eb545d8dd55e2e4735b53cc93f92e65b) 4: perf dump | grep -A
>     2 'throttle-osd_client_messages'    
>     "throttle-osd_client_messages": {         "val": 100,        
>     "max": 100, ops_in_flight:
>     https://gist.github.com/anonymous/643607fa3f959c91ba7a9794e5d99dea
>     <https://gist.github.com/anonymous/643607fa3f959c91ba7a9794e5d99dea>
>     -- PS -- To unsubscribe from this list: send the line "unsubscribe
>     ceph-devel" in the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org> More majordomo info at 
>     http://vger.kernel.org/majordomo-info.html
>     <http://vger.kernel.org/majordomo-info.html> 
>
