From: Samuel Just <samuelj@hq.newdream.net>
Subject: Re: FW: crashed+peering PGs
Date: Tue, 19 Jul 2011 17:57:30 -0700
Message-ID: <4E2627FA.9090101@hq.newdream.net>
References: <zarafa.4e23e05b.16b9.4cfc8d952979a1be@mail.brunner-muc.de>	<CAO47_-8B0bQiSVeVzig8s4R_T0XXCFu8oC6yH=7OCfdvjo9sGA@mail.gmail.com>	<Pine.LNX.4.64.1107181014280.22215@cobra.newdream.net> <CAO47_-_9t_0BZbK4pXk-+f-qi=L3NhzR4tjiNy7O3JCJsb3PEw@mail.gmail.com> <4E26035F.3030106@hq.newdream.net>
Reply-To: samuel.just@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:52052 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262Ab1GTA5a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2011 20:57:30 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 0DFF9C064
	for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2011 17:57:55 -0700 (PDT)
Received: from [192.168.107.170] (ip-64-111-111-107.dreamhost.com [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id F003BC062
	for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2011 17:57:54 -0700 (PDT)
In-Reply-To: <4E26035F.3030106@hq.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: ceph-devel@vger.kernel.org

I've now pushed a patch to master implementing a hack to allow a pg to 
be forced into creating.

ceph pg force_create_pg <pg>

will now reset that pg's status to creating.  This should cause the osd 
to recreate the pg.

Let us know if it helps!

019955a1f40944ed489fd613abe7ef4f3671fb4b implements the hack.

-Sam

On 07/19/2011 03:21 PM, Samuel Just wrote:
> Sage may correct me on this, but:
>
> The trouble is probably that an osd is informed about its 
> responsibilities towards a pg by the osds which previously handled 
> that pg.  If all of those have been wiped/removed, the new osd won't 
> be notified.  The monitor can send an MOSDPGCreate message, but 
> currently won't since we don't want to loose data in case the osds 
> with that pg come back.  I don't think we have a way to address this 
> at the moment.  You might be able to fix it by removing the pools and 
> recreating them if they don't have any data.  If you want to wait for 
> a bit, I'm going to add a command to the monitor to allow you  to 
> re-mark these as creating.
>
> -Sam
>
> On 07/19/2011 08:41 AM, Christian Brunner wrote:
>> 2011/7/18 Sage Weil<sage@newdream.net>:
>>> On Mon, 18 Jul 2011, Christian Brunner wrote:
>>>>>>>> $ ceph pg dump -o - | grep crashed
>>>>>>>> pg_stat objects mip     degr    unf     kb      bytes   log
>>>>>>>> disklog state   v       reported        up      acting  last_scrub
>>>>>>>> 1.1ac   0       0       0       0       0       0       0       0
>>>>>>>>   crashed+peering 0'0     5869'576        [3,13]  [3,13]  0'0
>>>>>>>> 2011-07-13 17:04:30.221618
>>>>>>>> 0.1ad   0       0       0       0       0       0       198     
>>>>>>>> 198
>>>>>>>>   crashed+peering 3067'1194       5869'515        [3,13]  [3,13]
>>>>>>>> 3067'1194       2011-07-13 17:04:29.221726
>>>>>>>> 2.1ab   0       0       0       0       0       0       0       0
>>>>>>>>   crashed+peering 0'0     5869'576        [3,13]  [3,13]  0'0
>>>>>>>> 2011-07-13 17:04:31.222145
>>>>>>>> 1.6c    0       0       0       0       0       0       0       0
>>>>>>>>   crashed+peering 0'0     5869'577        [3,13]  [3,13]  0'0
>>>>>>>> 2011-07-13 17:05:35.237286
>>>>>>>> 0.6d    0       0       0       0       0       0       198     
>>>>>>>> 198
>>>>>>>>   crashed+peering 3067'636        5869'516        [3,13]  [3,13]
>>>>>>>> 3067'636        2011-07-13 17:05:34.237024
>>>>>>>> 2.6b    0       0       0       0       0       0       0       0
>>>>>>>>   crashed+peering 0'0     5869'577        [3,13]  [3,13]  0'0
>>>>>>>> 2011-07-13 17:05:37.238474
>>>>> Strange, none of these PGs show up in those logs.  Can you do
>>>>>
>>>>> ceph pg map 1.1ac
>>>>>
>>>>> for each PG and see where the current CRUSH map thinks they should be
>>>>> stored?  That would be the node to look for them on.  You may also 
>>>>> want to
>>>>> look for $osd_data/current/$pgid_head on all the OSDs to see where 
>>>>> the
>>>>> copies are.
>>>>>
>>>>> The location in the pg dump (from the monitors PGMap) is just the 
>>>>> last
>>>>> reported location.  Primaries for each PG normally send stats updates
>>>>> several times a minute for each PG that is touched (and less 
>>>>> frequently
>>>>> for those that are not).  So it's not necessarily bad that it doesn't
>>>>> match... but it is strange that no surviving copy is reporting 
>>>>> updated
>>>>> information.
>>>> pg dump matches the data from pg map:
>>>>
>>>> 2011-07-18 09:41:02.340371 mon<- [pg,map,1.1ac]
>>>> 2011-07-18 09:41:02.410063 mon0 ->  'osdmap e6517 pg 1.1ac (1.1ac) ->
>>>> up [3,13] acting [3,13]' (0)
>>>> 2011-07-18 09:41:02.434859 mon<- [pg,map,0.1ad]
>>>> 2011-07-18 09:41:02.435546 mon1 ->  'osdmap e6517 pg 0.1ad (0.1ad) ->
>>>> up [3,13] acting [3,13]' (0)
>>>> 2011-07-18 09:41:02.442316 mon<- [pg,map,2.1ab]
>>>> 2011-07-18 09:41:02.442839 mon1 ->  'osdmap e6517 pg 2.1ab (2.1ab) ->
>>>> up [3,13] acting [3,13]' (0)
>>>> 2011-07-18 09:41:02.449131 mon<- [pg,map,1.6c]
>>>> 2011-07-18 09:41:02.449679 mon2 ->  'osdmap e6517 pg 1.6c (1.6c) 
>>>> ->  up
>>>> [3,13] acting [3,13]' (0)
>>>> 2011-07-18 09:41:02.455090 mon<- [pg,map,0.6d]
>>>> 2011-07-18 09:41:02.455429 mon0 ->  'osdmap e6517 pg 0.6d (0.6d) 
>>>> ->  up
>>>> [3,13] acting [3,13]' (0)
>>>> 2011-07-18 09:41:02.461530 mon<- [pg,map,2.6b]
>>>> 2011-07-18 09:41:02.462012 mon2 ->  'osdmap e6517 pg 2.6b (2.6b) 
>>>> ->  up
>>>> [3,13] acting [3,13]' (0)
>>>>
>>>> I've also looked at the filesystem: $pgid_head directories do neither
>>>> exist on osd003 nor on osd013.
>>> Does it exist on any other nodes?
>> No, it doesn't exist on any node.
>>
>>> Did the osd crash you mentioned happen at the end (when you started 
>>> seeing
>>> these 6 pgs misbehave), or did it recover fully after that, and only do
>>> this after a later OSD was reformatted?
>> The crash happened during the rebuild. The rebuild finished with these
>> 6 PGs in state "crashed+peering". Everything else was fine (no
>> degraded objects).
>>
>> My suspicion is, that these PGs had been skipped in the rebuild from
>> osd013 to osd003, because of the crash. After that I did a reformat on
>> osd013, which might explain, why these PGs are missing on osd013, too.
>>
>> Is there a way to create a PG manually?
>>
>> Thanks,
>> Christian
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

