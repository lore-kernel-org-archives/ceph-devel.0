From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Slow file creating and deleting using bonnie ++ on Hammer
Date: Tue, 26 May 2015 14:55:05 +0800
Message-ID: <CAAM7YAnxOp3Yo+F=mP4AvZBM1-7xD_N8A8h_H0cVNjOZ=S=cfg@mail.gmail.com>
References: <CAMzumdYUsO2jh8Xk1bpQLrOR7NiLcR5FzL15ve9=jiQ9Bz64wQ@mail.gmail.com>
	<CAC6JEv9ZjK6nn0tK7HpQWMkMcYhn=Kbg77_+J1NxKTq0WWfJOQ@mail.gmail.com>
	<CAMzumdYw_13u2nYDohMRbtD-tcKOTmJNn-x+mEFh2__hpf8XKw@mail.gmail.com>
	<CAMzumdZgmsmBYHci2qq1qDs2nWmXq3StR9FbPT3FfHy_zi9qeA@mail.gmail.com>
	<555F4C78.7060601@redhat.com>
	<CAMzumdYaQ1sZUQPbb-42ZSLZgYxLY7CWWoyE5DsUpryd3s6mhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:35926 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbbEZGzG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 May 2015 02:55:06 -0400
Received: by lagv1 with SMTP id v1so60894571lag.3
        for <ceph-devel@vger.kernel.org>; Mon, 25 May 2015 23:55:05 -0700 (PDT)
In-Reply-To: <CAMzumdYaQ1sZUQPbb-42ZSLZgYxLY7CWWoyE5DsUpryd3s6mhQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Barclay Jameson <almightybeeij@gmail.com>
Cc: John Spray <john.spray@redhat.com>, Gregory Farnum <greg@gregs42.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, May 23, 2015 at 1:34 AM, Barclay Jameson
<almightybeeij@gmail.com> wrote:
> Here are some more info :
> rados bench -p cephfs_data 100 write --no-cleanup
>
> Total time run:         100.096473
> Total writes made:      21900
> Write size:             4194304
> Bandwidth (MB/sec):     875.156
>
> Stddev Bandwidth:       96.1234
> Max bandwidth (MB/sec): 932
> Min bandwidth (MB/sec): 0
> Average Latency:        0.0731273
> Stddev Latency:         0.0439909
> Max latency:            1.23972
> Min latency:            0.0306901
>
> (Again the numbers from bench don't match what is listed in client io.
> Ceph -s shows anywhere from 200 MB/s to 1700 MB/s even when the max
> bandwidth lists 932 as the highest)
>
> rados bench -p cephfs_data 100 seq
>
> Total time run:        29.460172
> Total reads made:     21900
> Read size:            4194304
> Bandwidth (MB/sec):    2973.506
>
> Average Latency:       0.0215173
> Max latency:           0.693831
> Min latency:           0.00519763
>
>
>
> On client:
>
> [root@blarg cephfs]# time for i in {1..100000}; do mkdir blarg"$i" ; done
>
> real    10m36.794s
> user    1m45.329s
> sys    6m29.982s
> [root@blarg cephfs]# time for i in {1..100000}; do touch yadda"$i" ; done
>
> real    13m29.155s
> user    3m55.256s
> sys    7m50.301s
>
> What variables are most important in the perf dump?
> I would like to grep out the vars (ceph daemon
> /var/run/ceph-mds.cephnautilus01.asok perf dump | jq '.') that are of
> meaning while running the bonnie++ test again with -s 0.
>
> Thanks,
> BJ
>
> On Fri, May 22, 2015 at 10:34 AM, John Spray <john.spray@redhat.com> wrote:
>>
>>
>> On 22/05/2015 16:25, Barclay Jameson wrote:
>>>
>>> The Bonnie++ job _FINALLY_ finished. If I am reading this correctly it
>>> took days to create, stat, and delete 16 files??
>>> [root@blarg cephfs]# ~/bonnie++-1.03e/bonnie++ -u root:root -s 256g -r
>>> 131072 -d /cephfs/ -m CephBench -f -b
>>> Using uid:0, gid:0.
>>> Writing intelligently...done
>>> Rewriting...done
>>> Reading intelligently...done
>>> start 'em...done...done...done...
>>> Create files in sequential order...done.
>>> Stat files in sequential order...done.
>>> Delete files in sequential order...done.
>>> Create files in random order...done.
>>> Stat files in random order...done.
>>> Delete files in random order...done.
>>> Version 1.03e       ------Sequential Output------ --Sequential Input-
>>> --Random-
>>>                      -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
>>> --Seeks--
>>> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP
>>> /sec %CP
>>> CephBench      256G           1006417  76 90114  13           137110
>>> 8 329.8   7
>>>                      ------Sequential Create------ --------Random
>>> Create--------
>>>                      -Create-- --Read--- -Delete-- -Create-- --Read---
>>> -Delete--
>>>                files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>>> /sec %CP
>>>                   16     0   0 +++++ +++     0   0     0   0  5267  19
>>> 0   0
>>>
>>> CephBench,256G,,,1006417,76,90114,13,,,137110,8,329.8,7,16,0,0,+++++,+++,0,0,0,0,5267,19,0,0
>>>
>>> Any thoughts?
>>>
>> It's 16000 files by default (not 16), but this usually takes only a few
>> minutes.
>>
>> FWIW I tried running a quick bonnie++ (with -s 0 to skip the IO phase) on a
>> development (vstart.sh) cluster with a fuse client, and it readily handles
>> several hundred client requests per second (checked with "ceph daemonperf
>> mds.<id>")
>>
>> Nothing immediately leapt out at me from a quick look at the log you posted,
>> but with issues like these it is always worth trying to narrow it down by
>> trying the fuse client instead of the kernel client, and/or different kernel
>> versions.
>>
>> You may also want to check that your underlying RADOS cluster is performing
>> reasonably by doing a rados bench too.
>>
>> Cheers,
>> John
> --

the reason for slow file creations is that bonnie++ call fsync(2)
after each creat(2). fsync() wait for safe replies of the create
requests.  MDS sends safe reply when log event for the request gets
journaled safely. MDS flush the journal every 5 seconds
(mds_tick_interval). So the speed of file creation for bonnie++ is one
file every file seconds.



> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
