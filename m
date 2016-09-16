From: Haomai Wang <haomai@xsky.com>
Subject: Re: Suiciding and corrupted OSDs zero out Ceph cluster IO
Date: Fri, 16 Sep 2016 23:45:34 +0800
Message-ID: <CACJqLyaF_22Drc8ARrBGh=OKN6zVD0mQ=Cb8Ocbc=uY26u=fFg@mail.gmail.com>
References: <CAN3wisVcObOWrSey3xXNwuLMNidncc+NSTOFvSNKiAJ9P-oCDA@mail.gmail.com>
 <CACJqLyb5kfTvi7BAYX05krNUjEPFTG0GihD2R2purHUUOKpEnQ@mail.gmail.com> <CAN3wisXrWmVK+CeZgpq-6mLCurfTWcEsXLgfsotcbxbFC+3j7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sg2apc01on0115.outbound.protection.outlook.com ([104.47.125.115]:58676
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1760234AbcIPPpp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 16 Sep 2016 11:45:45 -0400
Received: by mail-vk0-f53.google.com with SMTP id m62so33724758vkd.3
        for <ceph-devel@vger.kernel.org>; Fri, 16 Sep 2016 08:45:40 -0700 (PDT)
In-Reply-To: <CAN3wisXrWmVK+CeZgpq-6mLCurfTWcEsXLgfsotcbxbFC+3j7Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kostis Fardelas <dante1234@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Sep 16, 2016 at 7:30 PM, Kostis Fardelas <dante1234@gmail.com> wrote:
> Sure,
> ceph-post-file: ebc211d2-5ae1-40ee-b40a-7668a21232e6

Oh, sorry, I forget how to access this post... Anyone may give a guide.....

>
> Contains the ceph logs and crashed OSD logs with default debug level.
> The flapping problem starts @2016-09-09 20:57:14.230840 and the OSDs
> crash (with suicide and corrupted leveldb logs) @2016-09-10 between
> 02:04 - 02:40. You will notice tha when we tried to start them some
> hours later, the OSDs kept crashing but with different asserts.
>
> On 16 September 2016 at 13:34, Haomai Wang <haomai@xsky.com> wrote:
>> On Fri, Sep 16, 2016 at 5:11 PM, Kostis Fardelas <dante1234@gmail.com> wrote:
>>> (sent this email to ceph-users too, but there was no feedback due to
>>> to its complex issues I guess, so I am sending this in ceph-devel too.
>>> Thanks)
>>>
>>> Hello cephers,
>>> last week we survived a 3-day outage on our ceph cluster (Hammer
>>> 0.94.7, 162 OSDs, 27 "fat" nodes, 1000s of clients) due to 6 out of
>>> 162 OSDs crash in the SAME node. The outage was caused in the
>>> following timeline:
>>> time 0:  OSDs living in the same node (rd0-19) start heavily flapping
>>> (in the logs: failed, wrongly marked me down, RESETSESSION etc). Some
>>> more OSDs on other nodes are also flapping but the OSDs of this single
>>> node seem to have played the major part in this problem
>>>
>>> time +6h: rd0-19 OSDs assert. Two of them suicide on OSD::osd_op_tp
>>> thread timeout and the other ones assert with EPERM and corrupted
>>> leveldb related errors. Something like this:
>>>
>>> 2016-09-10 02:40:47.155718 7f699b724700  0 filestore(/rados/rd0-19-01)
>>>  error (1) Operation not permitted not handled on operation 0x46db2d00
>>> (1731767079.0.0, or op 0, counting from 0)
>>> 2016-09-10 02:40:47.155731 7f699b724700  0 filestore(/rados/rd0-19-01)
>>> unexpected error code
>>> 2016-09-10 02:40:47.155732 7f699b724700  0 filestore(/rados/rd0-19-01)
>>>  transaction dump:
>>> {
>>>     "ops": [
>>>         {
>>>             "op_num": 0,
>>>             "op_name": "omap_setkeys",
>>>             "collection": "3.b30_head",
>>>             "oid": "3\/b30\/\/head",
>>>             "attr_lens": {
>>>                 "_epoch": 4,
>>>                 "_info": 734
>>>             }
>>>         }
>>>     ]
>>> }
>>>
>>>
>>> 2016-09-10 02:40:47.155778 7f699671a700 -1 os/FileStore.cc: In
>>> function 'unsigned int
>>> FileStore::_do_transaction(ObjectStore::Transaction&, uint64_t, int,
>>> ThreadPool::TPH
>>> andle*)' thread 7f699671a700 time 2016-09-10 02:40:47.153544
>>> os/FileStore.cc: 2761: FAILED assert(0 == "unexpected error")
>>>
>>> This leaves the cluster in a state like below:
>>> 2016-09-10 03:04:31.927635 mon.0 62.217.119.14:6789/0 948003 : cluster
>>> [INF] osdmap e281474: 162 osds: 156 up, 156 in
>>> 2016-09-10 03:04:32.145074 mon.0 62.217.119.14:6789/0 948004 : cluster
>>> [INF] pgmap v105867219: 28672 pgs: 1
>>> active+recovering+undersized+degraded, 26684 active+clean, 1889
>>> active+undersized+degraded, 98 down+peering; 95983 GB data, 179 TB
>>> used, 101379 GB / 278 TB avail; 12106 B/s rd, 11 op/s;
>>> 2408539/69641962 objects degraded (3.458%); 1/34820981 unfound
>>> (0.000%)
>>>
>>> From this time we have almost no IO propably due to 98 down+peering
>>> PGs, 1 unfound object and 1000s of librados clients stuck.
>>> As of now, we have not managed to pinpoint what caused the crashes (no
>>> disk errors, no network errors, no general hardware errors, nothing in
>>> dmesg) but things are still under investigation. Finally we managed to
>>> bring up enough crashed OSDs for IO to continue (using gdb, leveldb
>>> repairs, ceph-objectstore-tool), but our main questions exists:
>>>
>>> A. the 6 OSDs were on the same node. What is so special about
>>> suiciding + EPERMs that leave the cluster with down+peering and zero
>>> IO? Is this a normal behaviour after a crash like this? Notice that
>>> the cluster has marked the crashed OSDs down+out, so it seems that the
>>> cluster somehow "fenced" these OSDs but in a manner that leaves the
>>> cluster unusable. Our crushmap is the default one with the host as a
>>> failure domain
>>> B. would replication=3 help? Would we need replication=3 and min=2 to
>>> avoid such a problem in the future? Right now we are on size=2 &
>>> min_size=1
>>> C. would an increase in suicide timeouts help for future incidents like this?
>>> D. are there any known related bugs on 0.94.7? Haven't found anything so far...
>>
>> Could you please provide with ceph.log and the down osd logs at that
>> time? I don't have clue in your description so far.
>>
>>>
>>> Regards,
>>> Kostis
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
