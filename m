From: huang jun <hjwsm1989@gmail.com>
Subject: Re: how to recovery lost objects
Date: Sat, 4 Apr 2015 18:28:31 +0800
Message-ID: <CABAwU-aOt_hQjKp2qmCXr9vNnHiN7mwjMstFWOR3_HL+2r4+rQ@mail.gmail.com>
References: <CABAwU-YkJVV6qnixUC2t2yzKQezJgM-Jk7hTFC24LFiFN77ZHA@mail.gmail.com>
	<alpine.DEB.2.00.1504040118270.15540@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:33082 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbbDDK2c (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Apr 2015 06:28:32 -0400
Received: by layy10 with SMTP id y10so3133663lay.0
        for <ceph-devel@vger.kernel.org>; Sat, 04 Apr 2015 03:28:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1504040118270.15540@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

hi,sage

2015-04-04 16:21 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Sat, 4 Apr 2015, huang jun wrote:
>> hi,ceph
>>
>> Last week, we  add 48 OSDs to our exist cluster, the special thing is during
>> the  backfill and recovery procedure,  some osds going to 100% full(we
>> have set osd_full_ratio to 0.99).
>> In each full OSD, we find one PG  that the PG's acting and up set
>> didn't include this OSD anymore, then move the PG data to stale disk,
>
> Note: copying data like this is generally not safe!  Even if you preserve
> xattrs tehre is some metadata kept in leveldb that isn't copied.  The new
> ceph-objectstore-tool has a new export/import pg function that should be
> used instead!
>
>> and then restart the full OSDs, the backfill and recovery finally fininshed. And
>> "ceph -s" shows all PG state is "active+clean". So we didn't copy the backuped
>> data back.
>
> This sounds fine.  Removing PGs like this generally *does* work (although
> it will leave some junk behind in leveldb).
>
>> But now  we have a problem, we queried a file, find that one object of the file
>> is lost, but the PG status is ok
>>
>> root@node1:~# ceph osd  map data 10000024b56.00000001
>> osdmap e64986 pool 'data' (0) object '10000024b56.00000001' -> pg
>> 0.6b96f1d3 (0.11d3) -> up ([85,22], p85) acting ([85,22], p85)
>>
>> root@node1:/var/lib/ceph/osd/ceph-85/current/0.11d3_head# find ./
>> -name 10000024b56*
>>
>> root@node5:/var/lib/ceph/osd/ceph-22/current/0.11d3_head#  find ./
>> -name 10000024b56*
>> root@node5:/var/lib/ceph/osd/ceph-22/current/0.11d3_head# ls -R *|grep
>> 10000024b56
>>
>> As you can see, there are no object 10000024b56.00000001 found both in
>> osd.85 and osd.82.
>
> Are you sure that object should exist (or existed before)?  CephFS only
> creates the object if data was written to it; the empty parts of a
> sparse file may not have an object at all.

we find the objects by "cephfs /path map " command, the object
"10000024b56.00000001 " is showed here.

root@node2:/ceph/xxxx/18317# cephfs xxxxx16-20A0.wav  map
    FILE OFFSET                    OBJECT        OFFSET        LENGTH  OSD
              0           10000024b56.00000000             0       4194304  83
        4194304      10000024b56.00000001             0       4194304  85
        8388608      10000024b56.00000002             0       4194304  88
       12582912      10000024b56.00000003             0       4194304  106

it's possible that object from a sparse file? how can i check and verify it?
Another question, "rados -p data ls " will show the objects that not
exist like  "10000024b56.00000001 "?

>>
>> we check all backuped PG data, but with no luck.
>>
>> Does the object to PG refection changes after add OSDs? i think only
>> the PG to OSD reflection changes.
>>
>> how to recovery lost objects?
>>
>> Any tips or hints are welcome.
>
> Nothing here would have obviously made those objects get lost.  How many
> such objects are there?
>
> sage



-- 
thanks
huangjun
