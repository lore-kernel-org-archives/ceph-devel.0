From: Sage Weil <sage@newdream.net>
Subject: Re: High memory usage kills OSD while peering
Date: Sun, 27 Aug 2017 02:00:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708270157360.20435@piezo.novalocal>
References: <07113ad5-a799-5232-c617-81f323ce4038@gmail.com> <CAJ4mKGa6Nt1Eic9gk=SMbRufUCPnEcGijgJj-K8vHQP7A=HQKw@mail.gmail.com> <15fa2de0-27ad-cc51-6a6c-f306b9f330d2@gmail.com> <CAFehDbCzt=Ezffz+D7QQNM4PaPaDTJqU+dm1AhjmNHjw1W1FcA@mail.gmail.com>
 <alpine.DEB.2.11.1708222230080.17029@piezo.novalocal> <cf976b97-5173-cf89-010f-a3d492944304@gmail.com> <alpine.DEB.2.11.1708231343470.20435@piezo.novalocal> <e79cb096-bb5c-5e1c-5e03-5ca8b324b9e2@gmail.com> <alpine.DEB.2.11.1708240351220.20435@piezo.novalocal>
 <12a4771a-dab2-3e98-c925-119b09c2d2d0@gmail.com> <alpine.DEB.2.11.1708252243080.20435@piezo.novalocal> <18fbddea-9b94-bc9c-46d5-08076b591d13@gmail.com> <alpine.DEB.2.11.1708252306140.20435@piezo.novalocal> <d335345b-7c66-ee22-096d-31f792070397@gmail.com>
 <73dc0755-4699-8d61-d5fc-a39e629c582a@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53723 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdH0CAM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Aug 2017 22:00:12 -0400
In-Reply-To: <73dc0755-4699-8d61-d5fc-a39e629c582a@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linux Chips <linux.chips@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Mustafa Muhammad <mustafa1024m@gmail.com>

On Sun, 27 Aug 2017, Linux Chips wrote:
> Hi again,
> now every thing almost sorted out. we had a few inconsistent shards that were
> killing the OSDs when recovering, we fixed some of them by removing the bad
> shards, and some by starting other OSDs with good shards.
> what is stopping us now, is that one OSD had a corrupted leveldb and refuses
> to start.
> not sure how that hapened, but i asume is due to the many times the node/osd
> died from lack of memory.
> I am also not sure if we should continue the discussion here, or start a new
> thread.
> 
> the osd (262) is showing those logs upon start:
> 
> 2017-08-26 17:07:17.915861 7fbd8e4cbd00  0 set uid:gid to 0:0 (:)
> 2017-08-26 17:07:17.915875 7fbd8e4cbd00  0 ceph version 12.1.4
> (a5f84b37668fc8e03165aaf5cbb380c78e4deba4) luminous (rc), process (unknown),
> pid 26713
> 2017-08-26 17:07:17.927085 7fbd8e4cbd00  0 pidfile_write: ignore empty
> --pid-file
> 2017-08-26 17:07:17.951358 7fbd8e4cbd00  0 load: jerasure load: lrc load: isa
> 2017-08-26 17:07:17.951602 7fbd8e4cbd00  0
> filestore(/var/lib/ceph/osd/ceph-262) backend xfs (magic 0x58465342)
> 2017-08-26 17:07:17.952164 7fbd8e4cbd00  0
> filestore(/var/lib/ceph/osd/ceph-262) backend xfs (magic 0x58465342)
> 2017-08-26 17:07:17.952977 7fbd8e4cbd00  0
> genericfilestorebackend(/var/lib/ceph/osd/ceph-262) detect_features: FIEMAP
> ioctl is disabled via 'filestore fiemap' config option
> 2017-08-26 17:07:17.952983 7fbd8e4cbd00  0
> genericfilestorebackend(/var/lib/ceph/osd/ceph-262) detect_features:
> SEEK_DATA/SEEK_HOLE is disabled via 'filestore seek data hole' config option
> 2017-08-26 17:07:17.952985 7fbd8e4cbd00  0
> genericfilestorebackend(/var/lib/ceph/osd/ceph-262) detect_features: splice()
> is disabled via 'filestore splice' config option
> 2017-08-26 17:07:17.953309 7fbd8e4cbd00  0
> genericfilestorebackend(/var/lib/ceph/osd/ceph-262) detect_features: syncfs(2)
> syscall fully supported (by glibc and kernel)
> 2017-08-26 17:07:17.953797 7fbd8e4cbd00  0
> xfsfilestorebackend(/var/lib/ceph/osd/ceph-262) detect_feature: extsize is
> disabled by conf
> 2017-08-26 17:07:17.954628 7fbd8e4cbd00  0
> filestore(/var/lib/ceph/osd/ceph-262) start omap initiation
> 2017-08-26 17:07:17.957166 7fbd8e4cbd00 -1
> filestore(/var/lib/ceph/osd/ceph-262) mount(1724): Error initializing leveldb
> : Corruption: error in middle of record
> 
> 2017-08-26 17:07:17.957179 7fbd8e4cbd00 -1 osd.262 0 OSD:init: unable to mount
> object store
> 2017-08-26 17:07:17.957183 7fbd8e4cbd00 -1  ** ERROR: osd init failed: (1)
> Operation not permitted
> 
> ceph-objectstore-tool shows similar errors.
> 
> so, we figured it is only one OSD and we can go without it. we marked it lost,
> pgs started to peer and got active. but 5 remain in the incomplete state. and
> te pg query shows:
> 
> ...
>     "recovery_state": [
>         {
>             "name": "Started/Primary/Peering/Incomplete",
>             "enter_time": "2017-08-26 22:59:03.044623",
>             "comment": "not enough complete instances of this PG"
>         },
>         {
>             "name": "Started/Primary/Peering",
>             "enter_time": "2017-08-26 22:59:02.540748",
>             "past_intervals": [
>                 {
>                     "first": "959669",
>                     "last": "1090812",
>                     "all_participants": [
>                         {
>                             "osd": 258
>                         },
>                         {
>                             "osd": 262
>                         },
>                         {
>                             "osd": 338
>                         },
>                         {
>                             "osd": 545
>                         },
>                         {
>                             "osd": 549
>                         }
>                     ],
>                     "intervals": [
>                         {
>                             "first": "964880",
>                             "last": "964924",
>                             "acting": "262"
>                         },
>                         {
>                             "first": "978855",
>                             "last": "978956",
>                             "acting": "545"
>                         },
>                         {
>                             "first": "989628",
>                             "last": "989808",
>                             "acting": "258"
>                         },
>                         {
>                             "first": "992614",
>                             "last": "992975",
>                             "acting": "549"
>                         },
>                         {
>                             "first": "1085148",
>                             "last": "1090812",
>                             "acting": "338"
>                         }
>                     ]
>                 }
>             ],
>             "probing_osds": [
>                 "258",
>                 "338",
>                 "545",
>                 "549"
>             ],
>             "down_osds_we_would_probe": [
>                 262
>             ],
>             "peering_blocked_by": [],
>             "peering_blocked_by_detail": [
>                 {
>                     "detail": "peering_blocked_by_history_les_bound"
>                 }
>             ]
>         },
> ...
> 
> not sure wat that detail "peering_blocked_by_history_les_bound" is, and not
> sure how to proceed. i googled it, came up with nothing useful.
> all the incomplete pgs have the same detail as the above and similar recovery
> state.

It means that the pg metadata suggests that the PG may have gone active 
elsewhere, but we don't actually have any evidence that there were newer 
updates.  Since that OSD won't start and you can't extract the needed PGs 
from it with ceph-objectstore-tool export (or maybe you can get it from 
elsewhere?) there isn't much to lose by bypassing the check.  The config 
option has to be set to true on the primary OSD for the PG and peering 
retriggered (e.g., by marking the primary down with 'ceph osd down NN').

I'd test it on the 0 object PGs first :)

sage


> > ceph pg ls | grep incomplete
> 18.54b         0                  0        0         0       0  0
> 2739                 2739                              incomplete 2017-08-26
> 23:15:46.705071   46889'4277      1091150:314001                  [332,253]
> 332                                         [332,253]            332
> 46889'4277 2017-08-04 03:15:58.381025        46889'4277 2017-07-29
> 06:47:30.337673 
> 
> 19.54a      5950                  0        0         0       0 26108435266
> 3019                 3019                                      incomplete
> 2017-08-26 23:15:46.705156     961411'873129    1091150:58116482
> [332,253]        332
> [332,253]          332     960118'872495 2017-08-04 03:12:33.647414
> 952850'868978 2017-07-02 15:53:08.565948
> 19.608         0                  0        0         0       0  0
> 0                    0                              incomplete 2017-08-26
> 22:59:03.044649          0'0         1091150:428                  [258,338]
> 258                                         [258,338]            258
> 960118'862299 2017-08-04 03:01:57.011411     958900'861456 2017-07-28
> 02:33:29.476119
> 19.8bb         0                  0        0         0       0  0
> 0                    0                              incomplete 2017-08-26
> 22:59:02.946453          0'0         1091150:339                  [260,331]
> 260                                         [260,331]            260
> 960114'866811 2017-08-03 04:51:42.117840     952850'864443 2017-07-08
> 02:48:37.958357
> 19.dd3      5864                  0        0         0       0 25600089555
> 3094                 3094                                      incomplete
> 2017-08-26 17:20:07.948285     961411'865657    1091150:72381143
> [263,142]        263
> [263,142]          263     960118'865078 2017-08-25 17:32:06.181006
> 960118'865078 2017-08-25 17:32:06.181006
> 
> 
> I also noticed that some of those have 0 objects in them despite the dir in
> one of the osds have objects in it.
> these pools are replica 2
> 
> 
> thanks
> ali
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
