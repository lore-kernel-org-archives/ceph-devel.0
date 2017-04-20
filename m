From: Sage Weil <sage@newdream.net>
Subject: Re: another scrub bug? blocked for > 10240.948831 secs
Date: Thu, 20 Apr 2017 14:23:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1704201421120.6575@piezo.novalocal>
References: <94127293-3ba3-8bb8-db43-604b6a54eb55@brockmann-consult.de> <alpine.DEB.2.11.1704171316150.10661@piezo.novalocal> <456cafe7-ecaa-5c62-ca82-6c09a2b06ae7@brockmann-consult.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33675 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946228AbdDTOXQ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Apr 2017 10:23:16 -0400
In-Reply-To: <456cafe7-ecaa-5c62-ca82-6c09a2b06ae7@brockmann-consult.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Peter Maloney <peter.maloney@brockmann-consult.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 20 Apr 2017, Peter Maloney wrote:
> On 04/17/17 15:18, Sage Weil wrote:
> > On Sat, 15 Apr 2017, Peter Maloney wrote:
> >> Is this another scrub bug? Something just like this (1 or 2 requests
> >> blocked forever until osd restart) happened about 5 times so far, each
> >> time during recovery or some other thing I did myself to trigger it,
> >> probably involving snapshots. This time I noticed that it says scrub in
> >> the log. One other time it made a client block, but didn't seem to this
> >> time. I didn't have the same issue in 10.2.3, but I don't know if I
> >> generated the same load or whatever causes it back then.
> >>
> >> ceph version 10.2.5 (c461ee19ecbc0c5c330aca20f7392c9a00730367)
> >>
> >> If you want me to try 10.2.6 or 7 instead, I can do that, but no
> >> guarantee I can reproduce it any time soon.
> > There have been lots of scrub-related patches since 10.2.5, but I don't 
> > see one that would explain this.  I'm guessing there is a scrub waitlist 
> > bug that we aren't turning up in qa because our thrashing tests are 
> > triggering lots of other actions in sequence (peering from up/down osds 
> > and balancing) and those probably have the effect of 
> > clearing the issue.
> >
> > Next time you see it, can you capture the output of 'ceph daemon osd.NNN 
> > ops' so we can see what steps the request went through?  Also, any 
> > additional or more specific clues as to what might have triggered it would 
> > help.
> >
> > Thanks!
> > sage
> >
> 
> 
> Here, we go...
> 
> > 2017-04-20 05:03:58.522624 osd.20 10.3.0.132:6824/1088346 2078 :
> > cluster [WRN] slow request 20480.953923 seconds old, received at
> > 2017-04-19 23:22:37.568657: replica scrub(pg:
> > 4.2d,from:0'0,to:79873'5433886,epoch:79873,start:4:b46a9ab4:::rbd_data.43e4a9238e1f29.00000000000019fe:e438,end:4:b46a9ab4:::rbd_data.43e4a9238e1f29.00000000000019fe:e43a,chunky:1,deep:1,seed:4294967295,version:6)
> > currently reached_pg
> >
> >
> > root@ceph3:/var/log/ceph # ceph pg dump | grep -E "^pg_stat|^4.2d"
> > dumped all in format plain
> > pg_stat objects mip     degr    misp    unf     bytes   log    
> > disklog state   state_stamp     v       reported        up     
> > up_primary      acting  acting_primary  last_scrub      scrub_stamp 
> > last_deep_scrub deep_scrub_stamp
> > 4.2d    3494    0       0       0       0       13061467136    
> > 3012    3012    active+clean+scrubbing+deep     2017-04-19
> > 23:11:22.763008      80142'5447712   80142:3027638   [14,7,20]  
> > 14       [14,7,20]       14      76449'5396453   2017-04-18
> > 17:30:01.419498      73551'5298960   2017-04-15 03:23:48.821848
> >
> > ceph daemon osd.14 ops > longscrubbug.14.log # ceph1
> > ceph daemon osd.7 ops > longscrubbug.7.log # ceph3
> > ceph daemon osd.20 ops > longscrubbug.20.log # ceph2
> >
> >
> >
> > peter@peter:~/tmp/longscrubbug $ cat longscrubbug.14.log
> > {
> >     "ops": [],
> >     "num_ops": 0
> > }
> >
> > peter@peter:~/tmp/longscrubbug $ cat longscrubbug.7.log
> > {
> >     "ops": [],
> >     "num_ops": 0
> > }
> >
> > peter@peter:~/tmp/longscrubbug $ cat longscrubbug.20.log
> > {
> >     "ops": [
> >         {
> >             "description": "replica scrub(pg:
> > 4.2d,from:0'0,to:79873'5433886,epoch:79873,start:4:b46a9ab4:::rbd_data.43e4a9238e1f29.00000000000019fe:e438,end:4:b46a9ab4:::rbd_data.43e4a9238e1f29.00000000000019fe:e43a,chunky:1,deep:1,seed:4294967295,version:6)",
> >             "initiated_at": "2017-04-19 23:22:37.568657",
> >             "age": 30563.826540,
> >             "duration": 30563.826803,
> >             "type_data": [
> >                 "reached pg",
> >                 [
> >                     {
> >                         "time": "2017-04-19 23:22:37.568657",
> >                         "event": "initiated"
> >                     },
> >                     {
> >                         "time": "2017-04-19 23:22:37.568769",
> >                         "event": "queued_for_pg"
> >                     },
> >                     {
> >                         "time": "2017-04-19 23:22:37.568814",
> >                         "event": "reached_pg"
> >                     }
> >                 ]
> >             ]
> >         }
> >     ],
> >     "num_ops": 1
> > }
> >
> 
> to me that looks kinda non-useful... anything else you need? (I think
> I'll leave this one alone for a while in case you reply soon and want
> something)

Hmm.  Yeah, not terribly helpful.  Can you attach a 'ceph osd dump -f 
json-pretty' for epoch 79870 through 79880, as well as the latest?

My best guess is this is an interaction with snap trimming; the osdmap 
should indicate if a snap was deleted right around then.

Thanks!
sage
