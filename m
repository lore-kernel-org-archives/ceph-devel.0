From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Pg stuck stale...why?
Date: Wed, 11 Jul 2012 15:23:04 +1200
Message-ID: <4FFCF198.7010605@catalyst.net.nz>
References: <4FFCD2AC.3040809@catalyst.net.nz> <4FFCD53F.108@inktank.com> <4FFCD7B7.5020707@catalyst.net.nz> <4FFCDD19.3010700@inktank.com> <4FFCE03F.3050602@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:50000 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932362Ab2GKDXI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Jul 2012 23:23:08 -0400
In-Reply-To: <4FFCE03F.3050602@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 11/07/12 14:09, Mark Kirkwood wrote:
> On 11/07/12 13:55, Josh Durgin wrote:
>> On 07/10/2012 06:32 PM, Mark Kirkwood wrote:
>>> On 11/07/12 13:22, Josh Durgin wrote:
>>>> On 07/10/2012 06:11 PM, Mark Kirkwood wrote:
>>>>> I am seeing this:
>>>>>
>>>>> # ceph -s
>>>>> health HEALTH_WARN 256 pgs stale; 256 pgs stuck stale
>>>>> monmap e1: 3 mons at
>>>>> {ved1=192.168.122.11:6789/0,ved2=192.168.122.12:6789/0,ved3=192.168.122.13:6789/0}, 
>>>>>
>>>>>
>>>>> election epoch 18, quorum 0,1,2 ved1,ved2,ved3
>>>>> osdmap e62: 4 osds: 4 up, 4 in
>>>>> pgmap v47148: 768 pgs: 512 active+clean, 256 stale+active+clean; 
>>>>> 2224 MB
>>>>> data, 15442 MB used, 86907 MB / 102350 MB avail
>>>>> mdsmap e1: 0/0/1
>>>>>
>>>>> In particular 256 pgs stuck stale - I've tried a) waiting a while
>>>>> (overnight), b) a rolling restart of all 4 osd's, c) restarting 
>>>>> all ceph
>>>>> services on all 4 nodes. All without changing this.
>>>>>
>>>>> As far as I understand what stuck state means, I can't see why 
>>>>> they need
>>>>> to stay that way, given all osd's and mon's are up. (I have no mds
>>>>> configured)....any ideas? Or is this just expected?
>>>>>
>>>>> Regards
>>>>>
>>>>> Mark
>>>>
>>>> What does 'ceph pg dump_stuck stale' show? Stale means that the
>>>> monitors haven't gotten updates about those pgs from the osds within
>>>> the a certain period of time (default is 300 seconds), so something 
>>>> may
>>>> be wrong with your crushmap or those pgs themselves.
>>>>
>>>> Josh
>>>
>>> I have attached the dump of stuck stale pgs, and the crushmap in use.
>>>
>>> I did wonder if it is to do with not using any mds - i.e could this 
>>> mean
>>> the meta data pgs never get touched?
>>>
>>> Mark
>>>
>>
>> It doesn't look like a problem with your crushmap - the pgs are all 
>> mapped to osds, and there's no common osd holding things up.
>>
>> Not using the mds doesn't affect the pgs. They should still be active.
>> All the stuck ones are in pool 0 though. Is there anything special 
>> about that pool? Were there any changes before the pgs became stuck?
>>
>> I don't think it should work in this case, but you might try 'ceph pg 
>> force_create_pg 0.c'.
>>
>>
>
> Hmm - good observation - pool 0 is data, and I am only using rbd at 
> the moment, and:
>
> $ ceph osd dump -o -|grep size
> pool 0 'data' rep size 4 crush_ruleset 0 object_hash rjenkins pg_num 
> 256 pgp_num 256 last_change 8 owner 0 crash_replay_interval 45
> pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins 
> pg_num 256 pgp_num 256 last_change 1 owner 0
> pool 2 'rbd' rep size 4 crush_ruleset 2 object_hash rjenkins pg_num 
> 256 pgp_num 256 last_change 11 owner 0
>
> ... pool 0 is mapped to crush ruleset 0 - and I don't have a ruleset 
> 0. Could that be the problem?
>
> Mark

...and that was it:

$ ceph osd pool set data crush_ruleset 1

$ ceph health
HEALTH_OK

Thanks for making me think about this more carefully!

Mark
