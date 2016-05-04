From: Gaurav Bafna <bafnag@gmail.com>
Subject: Re: Bug in remapping of PG or config issue
Date: Wed, 4 May 2016 11:21:26 +0530
Message-ID: <CAPg135Ybb1peDCiFPzxZYzehOev-tYViWLC=Mh6QP=3re5yXOA@mail.gmail.com>
References: <CAPg135bi-XBdxQD64p0C6wNbXVXNuynvJYDPNMgTX4feF0xd5g@mail.gmail.com>
	<FA1EC2C4-2537-4031-88E9-6CABE1DD05B4@sandisk.com>
	<CAPg135aqLNmWM5CAzcN3=uhw3s6xstWt6qD-ikbmqfosnbhLTQ@mail.gmail.com>
	<BL2PR02MB21154E9D51C851F9EE6620BEF47A0@BL2PR02MB2115.namprd02.prod.outlook.com>
	<CAPg135Z2U1pg2x-ULyhK4Ro9b6ocUobbrq=Vm_go63uhGHFA9A@mail.gmail.com>
	<BL2PR02MB211516505ED45FC16295D83AF47A0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35781 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756951AbcEDFv2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 May 2016 01:51:28 -0400
Received: by mail-oi0-f53.google.com with SMTP id x19so53386039oix.2
        for <ceph-devel@vger.kernel.org>; Tue, 03 May 2016 22:51:27 -0700 (PDT)
In-Reply-To: <BL2PR02MB211516505ED45FC16295D83AF47A0@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I have changed it to 512 but still no effect on those 9 PG

    cluster fac04d85-db48-4564-b821-deebda046261
     health HEALTH_WARN
            9 pgs degraded
            9 pgs stuck degraded
            9 pgs stuck unclean
            9 pgs stuck undersized
            9 pgs undersized
            recovery 3327/195171 objects degraded (1.705%)
     monmap e2: 2 mons at
{dssmon2=10.140.13.13:6789/0,dssmonleader1=10.140.13.11:6789/0}
            election epoch 1044, quorum 0,1 dssmonleader1,dssmon2
     osdmap e874: 69 osds: 68 up, 68 in
      pgmap v109588: 896 pgs, 9 pools, 435 MB data, 65058 objects
            279 GB used, 247 TB / 247 TB avail
            3327/195171 objects degraded (1.705%)
                 887 active+clean
                   9 active+undersized+degraded

Thanks
Gaurav

On Tue, May 3, 2016 at 10:36 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Why the following ?
>
> pool .users pg_num 512 > pgp_num 8
>
> It should also be bump up to 512. Not sure if this is causing the issue , but, worth trying. Pgp_num is been used for placement purpose.
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Gaurav Bafna [mailto:bafnag@gmail.com]
> Sent: Tuesday, May 03, 2016 8:22 AM
> To: Somnath Roy
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Bug in remapping of PG or config issue
>
> I am not able to dig any info from both
>
> ceph health detail output :
>
> HEALTH_WARN 9 pgs degraded; 9 pgs stuck degraded; 9 pgs stuck unclean;
> 9 pgs stuck undersized; 9 pgs undersized; recovery 3327/195138 objects degraded (1.705%); pool .users pg_num 512 > pgp_num 8 pg 7.a is stuck unclean for 322742.938959, current state
> active+undersized+degraded, last acting [38,2]
> pg 5.27 is stuck unclean for 322754.823455, current state
> active+undersized+degraded, last acting [26,19]
> pg 5.32 is stuck unclean for 322750.685684, current state
> active+undersized+degraded, last acting [39,19]
> pg 6.13 is stuck unclean for 322732.665345, current state
> active+undersized+degraded, last acting [30,16]
> pg 5.4e is stuck unclean for 331869.103538, current state
> active+undersized+degraded, last acting [16,38]
> pg 5.72 is stuck unclean for 331871.208948, current state
> active+undersized+degraded, last acting [16,49]
> pg 4.17 is stuck unclean for 331822.771240, current state
> active+undersized+degraded, last acting [47,20]
> pg 5.2c is stuck unclean for 323021.274535, current state
> active+undersized+degraded, last acting [47,18]
> pg 5.37 is stuck unclean for 323007.574395, current state
> active+undersized+degraded, last acting [43,1]
> pg 7.a is stuck undersized for 322487.284302, current state
> active+undersized+degraded, last acting [38,2]
> pg 5.27 is stuck undersized for 322487.287164, current state
> active+undersized+degraded, last acting [26,19]
> pg 5.32 is stuck undersized for 322487.285566, current state
> active+undersized+degraded, last acting [39,19]
> pg 6.13 is stuck undersized for 322487.287168, current state
> active+undersized+degraded, last acting [30,16]
> pg 5.4e is stuck undersized for 331351.476170, current state
> active+undersized+degraded, last acting [16,38]
> pg 5.72 is stuck undersized for 331351.475707, current state
> active+undersized+degraded, last acting [16,49]
> pg 4.17 is stuck undersized for 322487.280309, current state
> active+undersized+degraded, last acting [47,20]
> pg 5.2c is stuck undersized for 322487.286347, current state
> active+undersized+degraded, last acting [47,18]
> pg 5.37 is stuck undersized for 322487.280027, current state
> active+undersized+degraded, last acting [43,1]
> pg 7.a is stuck degraded for 322487.284340, current state
> active+undersized+degraded, last acting [38,2]
> pg 5.27 is stuck degraded for 322487.287202, current state
> active+undersized+degraded, last acting [26,19]
> pg 5.32 is stuck degraded for 322487.285604, current state
> active+undersized+degraded, last acting [39,19]
> pg 6.13 is stuck degraded for 322487.287207, current state
> active+undersized+degraded, last acting [30,16]
> pg 5.4e is stuck degraded for 331351.476209, current state
> active+undersized+degraded, last acting [16,38]
> pg 5.72 is stuck degraded for 331351.475746, current state
> active+undersized+degraded, last acting [16,49]
> pg 4.17 is stuck degraded for 322487.280348, current state
> active+undersized+degraded, last acting [47,20]
> pg 5.2c is stuck degraded for 322487.286386, current state
> active+undersized+degraded, last acting [47,18]
> pg 5.37 is stuck degraded for 322487.280066, current state
> active+undersized+degraded, last acting [43,1]
> pg 5.72 is active+undersized+degraded, acting [16,49] pg 5.4e is active+undersized+degraded, acting [16,38] pg 5.32 is active+undersized+degraded, acting [39,19] pg 5.37 is active+undersized+degraded, acting [43,1] pg 5.2c is active+undersized+degraded, acting [47,18] pg 5.27 is active+undersized+degraded, acting [26,19] pg 6.13 is active+undersized+degraded, acting [30,16] pg 4.17 is active+undersized+degraded, acting [47,20] pg 7.a is active+undersized+degraded, acting [38,2] recovery 3327/195138 objects degraded (1.705%)
>
> PG Query Output :
>
> {
>     "state": "active+undersized+degraded",
>     "snap_trimq": "[]",
>     "epoch": 857,
>     "up": [
>         38,
>         2
>     ],
>     "acting": [
>         38,
>         2
>     ],
>     "actingbackfill": [
>         "2",
>         "38"
>     ],
>     "info": {
>         "pgid": "7.a",
>         "last_update": "0'0",
>         "last_complete": "0'0",
>         "log_tail": "0'0",
>         "last_user_version": 0,
>         "last_backfill": "MAX",
>         "purged_snaps": "[]",
>         "history": {
>             "epoch_created": 13,
>             "last_epoch_started": 818,
>             "last_epoch_clean": 818,
>             "last_epoch_split": 0,
>             "same_up_since": 817,
>             "same_interval_since": 817,
>             "same_primary_since": 188,
>             "last_scrub": "0'0",
>
>
>
> Complete pq query info at : http://pastebin.com/ZHB6M4PQ
>
> On Tue, May 3, 2016 at 8:17 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
>> Ohh, ok..
>> The following commands giving any useful information out ?
>>
>> Ceph health detail
>> Ceph pg query
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Gaurav Bafna [mailto:bafnag@gmail.com]
>> Sent: Tuesday, May 03, 2016 7:35 AM
>> To: Somnath Roy
>> Cc: ceph-devel@vger.kernel.org
>> Subject: Re: Bug in remapping of PG or config issue
>>
>> Hi Somnath,
>>
>> Thanks for your reply.
>>
>> Yes , I did wait.  The condition of the cluster is same for 2 days.
>> The OSD was marked down and out. Out of many PGs (around 65)  on which that osd was on , only some (9) were not recovered .
>>
>> Thanks
>> Gaurav
>>
>> On Tue, May 3, 2016 at 7:50 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
>>> You need to wait sometime (configurable) before cluster makes the odd out to kick of recovery or you can manually make down osd out to start recovery..
>>> This should be the behavior for pool size 2 as well, not sure how it started recovery instantly there..
>>>
>>> Thanks & Regards
>>> Somnath
>>>
>>> Sent from my iPhone
>>>
>>>> On May 3, 2016, at 7:11 AM, Gaurav Bafna <bafnag@gmail.com> wrote:
>>>>
>>>> Hi Cephers,
>>>>
>>>> In my dev-test cluster, after I kill 1 osd-daemon, the cluster never
>>>> recovers fully. 9 PGs remain undersized for unknown reason. The
>>>> issue is consistent. Every time I kill an osd, same PGs remain undersized.
>>>>
>>>> After I restart that 1 osd deamon, the cluster recovers in no time .
>>>> Or if I remove the osd, then also it recovers
>>>>
>>>> Size of all pools are 3 and min_size is 2.
>>>>
>>>> When I decrease the pool size to 2, the issue does not occur
>>>>
>>>> Do you think that this might be a bug in Monitor Code or there is an
>>>> issue in my Config ?
>>>>
>>>>
>>>>
>>>>
>>>> Output of  "ceph -s"
>>>>    cluster fac04d85-db48-4564-b821-deebda046261
>>>>     health HEALTH_WARN
>>>>            9 pgs degraded
>>>>            9 pgs stuck degraded
>>>>            9 pgs stuck unclean
>>>>            9 pgs stuck undersized
>>>>            9 pgs undersized
>>>>            recovery 3327/195138 objects degraded (1.705%)
>>>>            pool .users pg_num 512 > pgp_num 8
>>>>     monmap e2: 2 mons at
>>>> {dssmon2=10.140.13.13:6789/0,dssmonleader1=10.140.13.11:6789/0}
>>>>            election epoch 1038, quorum 0,1 dssmonleader1,dssmon2
>>>>     osdmap e857: 69 osds: 68 up, 68 in
>>>>      pgmap v106601: 896 pgs, 9 pools, 435 MB data, 65047 objects
>>>>            279 GB used, 247 TB / 247 TB avail
>>>>            3327/195138 objects degraded (1.705%)
>>>>                 887 active+clean
>>>>                   9 active+undersized+degraded  client io 395 B/s
>>>> rd,
>>>> 0 B/s wr, 0 op/s
>>>>
>>>> ceph health detail output :
>>>>
>>>> HEALTH_WARN 9 pgs degraded; 9 pgs stuck degraded; 9 pgs stuck
>>>> unclean;
>>>> 9 pgs stuck undersized; 9 pgs undersized; recovery 3327/195138
>>>> objects degraded (1.705%); pool .users pg_num 512 > pgp_num 8 pg 7.a
>>>> is stuck unclean for 322742.938959, current state
>>>> active+undersized+degraded, last acting [38,2]
>>>> pg 5.27 is stuck unclean for 322754.823455, current state
>>>> active+undersized+degraded, last acting [26,19]
>>>> pg 5.32 is stuck unclean for 322750.685684, current state
>>>> active+undersized+degraded, last acting [39,19]
>>>> pg 6.13 is stuck unclean for 322732.665345, current state
>>>> active+undersized+degraded, last acting [30,16]
>>>> pg 5.4e is stuck unclean for 331869.103538, current state
>>>> active+undersized+degraded, last acting [16,38]
>>>> pg 5.72 is stuck unclean for 331871.208948, current state
>>>> active+undersized+degraded, last acting [16,49]
>>>> pg 4.17 is stuck unclean for 331822.771240, current state
>>>> active+undersized+degraded, last acting [47,20]
>>>> pg 5.2c is stuck unclean for 323021.274535, current state
>>>> active+undersized+degraded, last acting [47,18]
>>>> pg 5.37 is stuck unclean for 323007.574395, current state
>>>> active+undersized+degraded, last acting [43,1]
>>>> pg 7.a is stuck undersized for 322487.284302, current state
>>>> active+undersized+degraded, last acting [38,2]
>>>> pg 5.27 is stuck undersized for 322487.287164, current state
>>>> active+undersized+degraded, last acting [26,19]
>>>> pg 5.32 is stuck undersized for 322487.285566, current state
>>>> active+undersized+degraded, last acting [39,19]
>>>> pg 6.13 is stuck undersized for 322487.287168, current state
>>>> active+undersized+degraded, last acting [30,16]
>>>> pg 5.4e is stuck undersized for 331351.476170, current state
>>>> active+undersized+degraded, last acting [16,38]
>>>> pg 5.72 is stuck undersized for 331351.475707, current state
>>>> active+undersized+degraded, last acting [16,49]
>>>> pg 4.17 is stuck undersized for 322487.280309, current state
>>>> active+undersized+degraded, last acting [47,20]
>>>> pg 5.2c is stuck undersized for 322487.286347, current state
>>>> active+undersized+degraded, last acting [47,18]
>>>> pg 5.37 is stuck undersized for 322487.280027, current state
>>>> active+undersized+degraded, last acting [43,1]
>>>> pg 7.a is stuck degraded for 322487.284340, current state
>>>> active+undersized+degraded, last acting [38,2]
>>>> pg 5.27 is stuck degraded for 322487.287202, current state
>>>> active+undersized+degraded, last acting [26,19]
>>>> pg 5.32 is stuck degraded for 322487.285604, current state
>>>> active+undersized+degraded, last acting [39,19]
>>>> pg 6.13 is stuck degraded for 322487.287207, current state
>>>> active+undersized+degraded, last acting [30,16]
>>>> pg 5.4e is stuck degraded for 331351.476209, current state
>>>> active+undersized+degraded, last acting [16,38]
>>>> pg 5.72 is stuck degraded for 331351.475746, current state
>>>> active+undersized+degraded, last acting [16,49]
>>>> pg 4.17 is stuck degraded for 322487.280348, current state
>>>> active+undersized+degraded, last acting [47,20]
>>>> pg 5.2c is stuck degraded for 322487.286386, current state
>>>> active+undersized+degraded, last acting [47,18]
>>>> pg 5.37 is stuck degraded for 322487.280066, current state
>>>> active+undersized+degraded, last acting [43,1]
>>>> pg 5.72 is active+undersized+degraded, acting [16,49] pg 5.4e is
>>>> active+undersized+degraded, acting [16,38] pg 5.32 is degraded,
>>>> active+undersized+acting [39,19] pg 5.37 is degraded, acting [43,1]
>>>> active+undersized+pg 5.2c is degraded, acting [47,18] pg 5.27 is
>>>> active+undersized+degraded, acting [26,19] pg 6.13 is degraded,
>>>> active+undersized+acting [30,16] pg 4.17 is degraded, acting [47,20]
>>>> active+undersized+pg 7.a is degraded, acting [38,2] recovery
>>>> active+undersized+3327/195138
>>>> objects degraded (1.705%) pool .users pg_num 512 > pgp_num 8
>>>>
>>>>
>>>> My crush map is default.
>>>>
>>>> Ceph.conf is :
>>>>
>>>> [osd]
>>>> osd mkfs type=xfs
>>>> osd recovery threads=2
>>>> osd disk thread ioprio class=idle
>>>> osd disk thread ioprio priority=7
>>>> osd journal=/var/lib/ceph/osd/ceph-$id/journal
>>>> filestore flusher=False
>>>> osd op num shards=3
>>>> debug osd=5
>>>> osd disk threads=2
>>>> osd data=/var/lib/ceph/osd/ceph-$id
>>>> osd op num threads per shard=5
>>>> osd op threads=4
>>>> keyring=/var/lib/ceph/osd/ceph-$id/keyring
>>>> osd journal size=4096
>>>>
>>>>
>>>> [global]
>>>> filestore max sync interval=10
>>>> auth cluster required=cephx
>>>> osd pool default min size=3
>>>> osd pool default size=3
>>>> public network=10.140.13.0/26
>>>> objecter inflight op_bytes=1073741824 auth service required=cephx
>>>> filestore min sync interval=1
>>>> fsid=fac04d85-db48-4564-b821-deebda046261
>>>> keyring=/etc/ceph/keyring
>>>> cluster network=10.140.13.0/26
>>>> auth client required=cephx
>>>> filestore xattr use omap=True
>>>> max open files=65536
>>>> objecter inflight ops=2048
>>>> osd pool default pg num=512
>>>> log to syslog = true
>>>> #err to syslog = true
>>>>
>>>>
>>>> Complete pq query info at : http://pastebin.com/ZHB6M4PQ
>>>>
>>>>
>>>> --
>>>> Gaurav Bafna
>>>> 9540631400
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>>> info at  http://vger.kernel.org/majordomo-info.html
>>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>>
>>
>>
>> --
>> Gaurav Bafna
>> 9540631400
>
>
>
> --
> Gaurav Bafna
> 9540631400



-- 
Gaurav Bafna
9540631400
