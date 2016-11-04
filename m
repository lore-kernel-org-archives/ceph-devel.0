From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: trying to get osd-scrub-repair to work on my jenkins builder
Date: Fri, 4 Nov 2016 22:13:53 +0100
Message-ID: <aaaa1503-71c8-d8e2-a1dd-c7b161c23043@digiware.nl>
References: <b09099ce-7419-f802-c84b-a425d1c445ff@digiware.nl>
 <b25d133d-8505-0ba4-c203-467b77104abb@redhat.com>
 <69f67e0d-b9bf-a0ed-0eb2-200e2aaeba69@digiware.nl>
 <015f7f90-4626-8899-cbc4-cc86813e0f55@digiware.nl>
 <alpine.DEB.2.11.1611042105140.20331@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:37968 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761175AbcKDVN6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 17:13:58 -0400
In-Reply-To: <alpine.DEB.2.11.1611042105140.20331@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: David Zafman <dzafman@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 4-11-2016 22:07, Sage Weil wrote:
> On Fri, 4 Nov 2016, Willem Jan Withagen wrote:
>> On 4-11-2016 21:09, Willem Jan Withagen wrote:
>>> On 4-11-2016 20:39, David Zafman wrote:
>>>>
>>>> I'm working a similar problem with the test-erasure-eio.sh test which
>>>> only fails on Jenkins.  I have a pg that is active+degraded and then
>>>> active+recovery_wait+degraded.  In this case the hinfo is missing after
>>>> osds are brought up and down in order to use the ceph-objectstore-tool
>>>> to implement the test cases.  On Jenkins the osd restarting causes
>>>> different pg mappings then on my build machine and recovery can't make
>>>> progress.
>>>>
>>>> See if you see these message in the osd log of the primary of the pg (in
>>>> your example below that would be osd.3:
>>>>
>>>> handle_sub_read_reply shard=1(1) error=-5
>>>>
>>>> _failed_push: canceling recovery op for obj ...
>>>
>>> I have something like 250.000 !!! lines looking like:
>>>
>>> 2016-11-04 18:09:52.769091 ba9c480 10 osd.3 pg_epoch: 117 pg[2.0s0( v
>>> 72'1 (0'0,72'1] local-les=116 n=1 ec=69 les/c/f 116/105/0 113/115/84)
>>> [3,1,9,0,6,2] r=0 lpr=115 pi=103-114/5 rops=1 crt=72'1 lcod 0'0 mlcod
>>> 0'0 active+recovering+degraded] _failed_push: canceling recovery op for
>>> obj 2:eb822e21:::SOMETHING:head
>>>
>>> And another fragment is:
>>> 2016-11-04 17:55:00.233049 ba6ad00 10 osd.3 pg_epoch: 117 pg[2.0s0( v
>>> 72'1 (0'0,72'1] local-les=116 n=1 ec=69 les/c/f 116/105/0 113/115/84)
>>> [3,1,9,0,6,2] r=0 lpr=115 pi=103-114/5 rops=1 crt=72'1 lcod 0'0 mlcod
>>> 0'0 active+recovering+degraded] handle_message:
>>> MOSDECSubOpReadReply(2.0s0 117 ECSubReadReply(tid=14, attrs_read=0)) v1
>>> 2016-11-04 17:55:00.233099 ba6ad00 10 osd.3 pg_epoch: 117 pg[2.0s0( v
>>> 72'1 (0'0,72'1] local-les=116 n=1 ec=69 les/c/f 116/105/0 113/115/84)
>>> [3,1,9,0,6,2] r=0 lpr=115 pi=103-114/5 rops=1 crt=72'1 lcod 0'0 mlcod
>>> 0'0 active+recovering+degraded] handle_sub_read_reply: reply
>>> ECSubReadReply(tid=14, attrs_read=0)
>>> 2016-11-04 17:55:00.233150 ba6ad00 20 osd.3 pg_epoch: 117 pg[2.0s0( v
>>> 72'1 (0'0,72'1] local-les=116 n=1 ec=69 les/c/f 116/105/0 113/115/84)
>>> [3,1,9,0,6,2] r=0 lpr=115 pi=103-114/5 rops=1 crt=72'1 lcod 0'0 mlcod
>>> 0'0 active+recovering+degraded] handle_sub_read_reply shard=9(2) error=-2
>>> 2016-11-04 17:55:00.233200 ba6ad00 10 osd.3 pg_epoch: 117 pg[2.0s0( v
>>> 72'1 (0'0,72'1] local-les=116 n=1 ec=69 les/c/f 116/105/0 113/115/84)
>>> [3,1,9,0,6,2] r=0 lpr=115 pi=103-114/5 rops=1 crt=72'1 lcod 0'0 mlcod
>>> 0'0 active+recovering+degraded] handle_sub_read_reply readop not
>>> complete: ReadOp(tid=14,
>>> to_read={2:eb822e21:::SOMETHING:head=read_request_t(to_read=[0,8388608,0],
>>> need=0(3),3(0),6(4),9(2), want_attrs=1)},
>>> complete={2:eb822e21:::SOMETHING:head=read_result_t(r=0,
>>> errors={9(2)=-2}, noattrs, returned=(0, 8388608, [3(0),1024]))},
>>> priority=3,
>>> obj_to_source={2:eb822e21:::SOMETHING:head=0(3),3(0),6(4),9(2)},
>>> source_to_obj={0(3)=2:eb822e21:::SOMETHING:head,3(0)=2:eb822e21:::SOMETHING:head,6(4)=2:eb822e21:::SOMETHING:head,9(2)=2:eb822e21:::SOMETHING:head},
>>> in_progress=0(3),6(4))
>>
>> And the log of osd.9 is also ful with the following sequence:
>> 2016-11-04 18:09:51.995641 bab2000 20 osd.9 117 share_map_peer 0xbb0c000
>> already has epoch 117
>> 2016-11-04 18:09:51.995848 bab2000 10 osd.9 117 dequeue_op 0xbf59180 finish
>> 2016-11-04 18:09:52.005020 b8b3200 10 osd.9 117 handle_replica_op
>> MOSDECSubOpRead(2.0s2 117 ECSubRead(tid=86489, to_read={2:eb822e21
>> :::SOMETHING:head=0,2097152,0}, attrs_to_read=)) v2 epoch 117
>> 2016-11-04 18:09:52.005149 b8b3200 20 osd.9 117 should_share_map osd.3
>> 127.0.0.1:6813/67592 117
>> 2016-11-04 18:09:52.005229 b8b3200 15 osd.9 117 enqueue_op 0xbf5ae40
>> prio 3 cost 0 latency 0.000378 MOSDECSubOpRead(2.0s2 117 ECSubR
>> ead(tid=86489, to_read={2:eb822e21:::SOMETHING:head=0,2097152,0},
>> attrs_to_read=)) v2
>> 2016-11-04 18:09:52.005408 bab2000 10 osd.9 117 dequeue_op 0xbf5ae40
>> prio 3 cost 0 latency 0.000558 MOSDECSubOpRead(2.0s2 117 ECSubR
>> ead(tid=86489, to_read={2:eb822e21:::SOMETHING:head=0,2097152,0},
>> attrs_to_read=)) v2 pg pg[2.0s2( v 72'1 (0'0,72'1] local-les=116 n
>> =1 ec=69 les/c/f 116/105/0 113/115/84) [3,1,9,0,6,2] r=2 lpr=115
>> pi=69-114/22 luod=0'0 crt=0'0 lcod 0'0 active]
>> 2016-11-04 18:09:52.005539 bab2000 10 osd.9 pg_epoch: 117 pg[2.0s2( v
>> 72'1 (0'0,72'1] local-les=116 n=1 ec=69 les/c/f 116/105/0 113/
>> 115/84) [3,1,9,0,6,2] r=2 lpr=115 pi=69-114/22 luod=0'0 crt=0'0 lcod 0'0
>> active] handle_message: MOSDECSubOpRead(2.0s2 117 ECSubRead
>> (tid=86489, to_read={2:eb822e21:::SOMETHING:head=0,2097152,0},
>> attrs_to_read=)) v2
>> 2016-11-04 18:09:52.005595 bab2000 10 osd.9 pg_epoch: 117 pg[2.0s2( v
>> 72'1 (0'0,72'1] local-les=116 n=1 ec=69 les/c/f 116/105/0 113/
>> 115/84) [3,1,9,0,6,2] r=2 lpr=115 pi=69-114/22 luod=0'0 crt=0'0 lcod 0'0
>> active] get_hash_info: Getting attr on 2:eb822e21:::SOMETHI
>> NG:head
>> 2016-11-04 18:09:52.005641 bab2000 10 osd.9 pg_epoch: 117 pg[2.0s2( v
>> 72'1 (0'0,72'1] local-les=116 n=1 ec=69 les/c/f 116/105/0 113/
>> 115/84) [3,1,9,0,6,2] r=2 lpr=115 pi=69-114/22 luod=0'0 crt=0'0 lcod 0'0
>> active] get_hash_info: not in cache 2:eb822e21:::SOMETHING:
>> head
>> 2016-11-04 18:09:52.005853 bab2000 -1 log_channel(cluster) log [ERR] :
>> handle_sub_read: Error -2 reading 2:eb822e21:::SOMETHING:head
>> 2016-11-04 18:09:52.005880 bab2000  5 osd.9 pg_epoch: 117 pg[2.0s2( v
>> 72'1 (0'0,72'1] local-les=116 n=1 ec=69 les/c/f 116/105/0 113/
>> 115/84) [3,1,9,0,6,2] r=2 lpr=115 pi=69-114/22 luod=0'0 crt=0'0 lcod 0'0
>> active] handle_sub_read: Error -2 reading 2:eb822e21:::SOME
>> THING:head
>> 2016-11-04 18:09:52.005940 bab2000 20 osd.9 117 share_map_peer 0xbb0c000
>> already has epoch 117
>>
>> And error -2 would read more or less:
>> #define ENOENT          2               /* No such file or directory */
>>
>> And these are the SOMETHING__head files in the test:
>> 1 -rw-r--r--  1 jenkins  jenkins  1024 Nov  4 17:53
>> ./0/current/2.0s3_head/SOMETHING__head_847441D7__2_ffffffffffffffff_3
>> 1 -rw-r--r--  1 jenkins  jenkins  1024 Nov  4 17:53
>> ./2/current/2.0s5_head/SOMETHING__head_847441D7__2_ffffffffffffffff_5
>> 1 -rw-r--r--  1 jenkins  jenkins  1024 Nov  4 17:54
>> ./3/current/2.0s0_head/SOMETHING__head_847441D7__2_ffffffffffffffff_0
>> 1 -rw-r--r--  1 jenkins  jenkins  1024 Nov  4 17:53
>> ./6/current/2.0s4_head/SOMETHING__head_847441D7__2_ffffffffffffffff_4
>>
>> Perhaps this 847441D7 should read EB822E21 ??
>> And is this the reason of the read error?
> 
> Could be!  Note though that the ghobject_t operator<< string you see in 
> the log (2:eb822e21:::SOMETHING:head) prints the hex in reversed bitwise 
> order, while the string in the FileStore filename is reversed nibble form.  
> You can convert between the two bit reversing the bits in each hex 
> digit/nibble, though, and those don't appear to match.

Ehhh, that would call for a proper print-operator(s) ... and add that as
extra info with this error. Makes life for comparing and debugging a lot
easier, and make them equal to what is actually stored in the FS.

> In any case, can you post the log?  ceph-post-file <filename> then send 
> the uuid.

Which logs would you like to have?
osd.3.log is 7G and osd.9.log is 600Mb. I do have the bandwidth to
upload, but especially 7G is big.

--WjW
