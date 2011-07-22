From: Christian Brunner <chb@muc.de>
Subject: Re: FW: crashed+peering PGs
Date: Fri, 22 Jul 2011 11:27:55 +0200
Message-ID: <CAO47_-8TbE6CrrLC6TvGZxktWqukOtM5gA-9pcBONubfKjCkFQ@mail.gmail.com>
References: <zarafa.4e23e05b.16b9.4cfc8d952979a1be@mail.brunner-muc.de>
	<CAO47_-8B0bQiSVeVzig8s4R_T0XXCFu8oC6yH=7OCfdvjo9sGA@mail.gmail.com>
	<Pine.LNX.4.64.1107181014280.22215@cobra.newdream.net>
	<CAO47_-_9t_0BZbK4pXk-+f-qi=L3NhzR4tjiNy7O3JCJsb3PEw@mail.gmail.com>
	<4E26035F.3030106@hq.newdream.net>
	<4E2627FA.9090101@hq.newdream.net>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46256 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab1GVJ14 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 05:27:56 -0400
Received: by vws1 with SMTP id 1so1472510vws.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jul 2011 02:27:55 -0700 (PDT)
In-Reply-To: <4E2627FA.9090101@hq.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: samuel.just@dreamhost.com
Cc: ceph-devel@vger.kernel.org

Hi Samuel,

I've now applied your fix and it worked. Everything is active+clean aga=
in.

Thanks,
Christian

2011/7/20 Samuel Just <samuelj@hq.newdream.net>:
> I've now pushed a patch to master implementing a hack to allow a pg t=
o be
> forced into creating.
>
> ceph pg force_create_pg <pg>
>
> will now reset that pg's status to creating. =A0This should cause the=
 osd to
> recreate the pg.
>
> Let us know if it helps!
>
> 019955a1f40944ed489fd613abe7ef4f3671fb4b implements the hack.
>
> -Sam
>
> On 07/19/2011 03:21 PM, Samuel Just wrote:
>>
>> Sage may correct me on this, but:
>>
>> The trouble is probably that an osd is informed about its responsibi=
lities
>> towards a pg by the osds which previously handled that pg. =A0If all=
 of those
>> have been wiped/removed, the new osd won't be notified. =A0The monit=
or can
>> send an MOSDPGCreate message, but currently won't since we don't wan=
t to
>> loose data in case the osds with that pg come back. =A0I don't think=
 we have a
>> way to address this at the moment. =A0You might be able to fix it by=
 removing
>> the pools and recreating them if they don't have any data. =A0If you=
 want to
>> wait for a bit, I'm going to add a command to the monitor to allow y=
ou =A0to
>> re-mark these as creating.
>>
>> -Sam
>>
>> On 07/19/2011 08:41 AM, Christian Brunner wrote:
>>>
>>> 2011/7/18 Sage Weil<sage@newdream.net>:
>>>>
>>>> On Mon, 18 Jul 2011, Christian Brunner wrote:
>>>>>>>>>
>>>>>>>>> $ ceph pg dump -o - | grep crashed
>>>>>>>>> pg_stat objects mip =A0 =A0 degr =A0 =A0unf =A0 =A0 kb =A0 =A0=
 =A0bytes =A0 log
>>>>>>>>> disklog state =A0 v =A0 =A0 =A0 reported =A0 =A0 =A0 =A0up =A0=
 =A0 =A0acting =A0last_scrub
>>>>>>>>> 1.1ac =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0
>>>>>>>>> =A0crashed+peering 0'0 =A0 =A0 5869'576 =A0 =A0 =A0 =A0[3,13]=
 =A0[3,13] =A00'0
>>>>>>>>> 2011-07-13 17:04:30.221618
>>>>>>>>> 0.1ad =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 198 =A0 =A0 198
>>>>>>>>> =A0crashed+peering 3067'1194 =A0 =A0 =A0 5869'515 =A0 =A0 =A0=
 =A0[3,13] =A0[3,13]
>>>>>>>>> 3067'1194 =A0 =A0 =A0 2011-07-13 17:04:29.221726
>>>>>>>>> 2.1ab =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0
>>>>>>>>> =A0crashed+peering 0'0 =A0 =A0 5869'576 =A0 =A0 =A0 =A0[3,13]=
 =A0[3,13] =A00'0
>>>>>>>>> 2011-07-13 17:04:31.222145
>>>>>>>>> 1.6c =A0 =A00 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0
>>>>>>>>> =A0crashed+peering 0'0 =A0 =A0 5869'577 =A0 =A0 =A0 =A0[3,13]=
 =A0[3,13] =A00'0
>>>>>>>>> 2011-07-13 17:05:35.237286
>>>>>>>>> 0.6d =A0 =A00 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 198 =A0 =A0 198
>>>>>>>>> =A0crashed+peering 3067'636 =A0 =A0 =A0 =A05869'516 =A0 =A0 =A0=
 =A0[3,13] =A0[3,13]
>>>>>>>>> 3067'636 =A0 =A0 =A0 =A02011-07-13 17:05:34.237024
>>>>>>>>> 2.6b =A0 =A00 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0=
 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0
>>>>>>>>> =A0crashed+peering 0'0 =A0 =A0 5869'577 =A0 =A0 =A0 =A0[3,13]=
 =A0[3,13] =A00'0
>>>>>>>>> 2011-07-13 17:05:37.238474
>>>>>>
>>>>>> Strange, none of these PGs show up in those logs. =A0Can you do
>>>>>>
>>>>>> ceph pg map 1.1ac
>>>>>>
>>>>>> for each PG and see where the current CRUSH map thinks they shou=
ld be
>>>>>> stored? =A0That would be the node to look for them on. =A0You ma=
y also
>>>>>> want to
>>>>>> look for $osd_data/current/$pgid_head on all the OSDs to see whe=
re the
>>>>>> copies are.
>>>>>>
>>>>>> The location in the pg dump (from the monitors PGMap) is just th=
e last
>>>>>> reported location. =A0Primaries for each PG normally send stats =
updates
>>>>>> several times a minute for each PG that is touched (and less
>>>>>> frequently
>>>>>> for those that are not). =A0So it's not necessarily bad that it =
doesn't
>>>>>> match... but it is strange that no surviving copy is reporting u=
pdated
>>>>>> information.
>>>>>
>>>>> pg dump matches the data from pg map:
>>>>>
>>>>> 2011-07-18 09:41:02.340371 mon<- [pg,map,1.1ac]
>>>>> 2011-07-18 09:41:02.410063 mon0 -> =A0'osdmap e6517 pg 1.1ac (1.1=
ac) ->
>>>>> up [3,13] acting [3,13]' (0)
>>>>> 2011-07-18 09:41:02.434859 mon<- [pg,map,0.1ad]
>>>>> 2011-07-18 09:41:02.435546 mon1 -> =A0'osdmap e6517 pg 0.1ad (0.1=
ad) ->
>>>>> up [3,13] acting [3,13]' (0)
>>>>> 2011-07-18 09:41:02.442316 mon<- [pg,map,2.1ab]
>>>>> 2011-07-18 09:41:02.442839 mon1 -> =A0'osdmap e6517 pg 2.1ab (2.1=
ab) ->
>>>>> up [3,13] acting [3,13]' (0)
>>>>> 2011-07-18 09:41:02.449131 mon<- [pg,map,1.6c]
>>>>> 2011-07-18 09:41:02.449679 mon2 -> =A0'osdmap e6517 pg 1.6c (1.6c=
) -> =A0up
>>>>> [3,13] acting [3,13]' (0)
>>>>> 2011-07-18 09:41:02.455090 mon<- [pg,map,0.6d]
>>>>> 2011-07-18 09:41:02.455429 mon0 -> =A0'osdmap e6517 pg 0.6d (0.6d=
) -> =A0up
>>>>> [3,13] acting [3,13]' (0)
>>>>> 2011-07-18 09:41:02.461530 mon<- [pg,map,2.6b]
>>>>> 2011-07-18 09:41:02.462012 mon2 -> =A0'osdmap e6517 pg 2.6b (2.6b=
) -> =A0up
>>>>> [3,13] acting [3,13]' (0)
>>>>>
>>>>> I've also looked at the filesystem: $pgid_head directories do nei=
ther
>>>>> exist on osd003 nor on osd013.
>>>>
>>>> Does it exist on any other nodes?
>>>
>>> No, it doesn't exist on any node.
>>>
>>>> Did the osd crash you mentioned happen at the end (when you starte=
d
>>>> seeing
>>>> these 6 pgs misbehave), or did it recover fully after that, and on=
ly do
>>>> this after a later OSD was reformatted?
>>>
>>> The crash happened during the rebuild. The rebuild finished with th=
ese
>>> 6 PGs in state "crashed+peering". Everything else was fine (no
>>> degraded objects).
>>>
>>> My suspicion is, that these PGs had been skipped in the rebuild fro=
m
>>> osd013 to osd003, because of the crash. After that I did a reformat=
 on
>>> osd013, which might explain, why these PGs are missing on osd013, t=
oo.
>>>
>>> Is there a way to create a PG manually?
>>>
>>> Thanks,
>>> Christian
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
