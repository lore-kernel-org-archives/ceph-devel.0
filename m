From: Christian Brunner <chb@muc.de>
Subject: Re: FW: crashed+peering PGs
Date: Mon, 18 Jul 2011 09:51:24 +0200
Message-ID: <CAO47_-8B0bQiSVeVzig8s4R_T0XXCFu8oC6yH=7OCfdvjo9sGA@mail.gmail.com>
References: <zarafa.4e23e05b.16b9.4cfc8d952979a1be@mail.brunner-muc.de>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39941 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab1GRHvZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jul 2011 03:51:25 -0400
Received: by vws1 with SMTP id 1so1967126vws.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jul 2011 00:51:24 -0700 (PDT)
In-Reply-To: <zarafa.4e23e05b.16b9.4cfc8d952979a1be@mail.brunner-muc.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

>> >> $ ceph pg dump -o - | grep crashed
>> >> pg_stat objects mip =A0 =A0 degr =A0 =A0unf =A0 =A0 kb =A0 =A0 =A0=
bytes =A0 log
>> >> disklog state =A0 v =A0 =A0 =A0 reported =A0 =A0 =A0 =A0up =A0 =A0=
 =A0acting =A0last_scrub
>> >> 1.1ac =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0
>> >> =A0crashed+peering 0'0 =A0 =A0 5869'576 =A0 =A0 =A0 =A0[3,13] =A0=
[3,13] =A00'0
>> >> 2011-07-13 17:04:30.221618
>> >> 0.1ad =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 0 =A0 =A0 =A0 0 =A0 =A0 =A0 198 =A0 =A0 198
>> >> =A0crashed+peering 3067'1194 =A0 =A0 =A0 5869'515 =A0 =A0 =A0 =A0=
[3,13] =A0[3,13]
>> >> 3067'1194 =A0 =A0 =A0 2011-07-13 17:04:29.221726
>> >> 2.1ab =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0
>> >> =A0crashed+peering 0'0 =A0 =A0 5869'576 =A0 =A0 =A0 =A0[3,13] =A0=
[3,13] =A00'0
>> >> 2011-07-13 17:04:31.222145
>> >> 1.6c =A0 =A00 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0
>> >> =A0crashed+peering 0'0 =A0 =A0 5869'577 =A0 =A0 =A0 =A0[3,13] =A0=
[3,13] =A00'0
>> >> 2011-07-13 17:05:35.237286
>> >> 0.6d =A0 =A00 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 0 =A0 =A0 =A0 0 =A0 =A0 =A0 198 =A0 =A0 198
>> >> =A0crashed+peering 3067'636 =A0 =A0 =A0 =A05869'516 =A0 =A0 =A0 =A0=
[3,13] =A0[3,13]
>> >> 3067'636 =A0 =A0 =A0 =A02011-07-13 17:05:34.237024
>> >> 2.6b =A0 =A00 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0=
 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0 =A0 =A0 =A0 0
>> >> =A0crashed+peering 0'0 =A0 =A0 5869'577 =A0 =A0 =A0 =A0[3,13] =A0=
[3,13] =A00'0
>> >> 2011-07-13 17:05:37.238474
>
> Strange, none of these PGs show up in those logs. =A0Can you do
>
> ceph pg map 1.1ac
>
> for each PG and see where the current CRUSH map thinks they should be
> stored? =A0That would be the node to look for them on. =A0You may als=
o want to
> look for $osd_data/current/$pgid_head on all the OSDs to see where th=
e
> copies are.
>
> The location in the pg dump (from the monitors PGMap) is just the las=
t
> reported location. =A0Primaries for each PG normally send stats updat=
es
> several times a minute for each PG that is touched (and less frequent=
ly
> for those that are not). =A0So it's not necessarily bad that it doesn=
't
> match... but it is strange that no surviving copy is reporting update=
d
> information.

pg dump matches the data from pg map:

2011-07-18 09:41:02.340371 mon <- [pg,map,1.1ac]
2011-07-18 09:41:02.410063 mon0 -> 'osdmap e6517 pg 1.1ac (1.1ac) ->
up [3,13] acting [3,13]' (0)
2011-07-18 09:41:02.434859 mon <- [pg,map,0.1ad]
2011-07-18 09:41:02.435546 mon1 -> 'osdmap e6517 pg 0.1ad (0.1ad) ->
up [3,13] acting [3,13]' (0)
2011-07-18 09:41:02.442316 mon <- [pg,map,2.1ab]
2011-07-18 09:41:02.442839 mon1 -> 'osdmap e6517 pg 2.1ab (2.1ab) ->
up [3,13] acting [3,13]' (0)
2011-07-18 09:41:02.449131 mon <- [pg,map,1.6c]
2011-07-18 09:41:02.449679 mon2 -> 'osdmap e6517 pg 1.6c (1.6c) -> up
[3,13] acting [3,13]' (0)
2011-07-18 09:41:02.455090 mon <- [pg,map,0.6d]
2011-07-18 09:41:02.455429 mon0 -> 'osdmap e6517 pg 0.6d (0.6d) -> up
[3,13] acting [3,13]' (0)
2011-07-18 09:41:02.461530 mon <- [pg,map,2.6b]
2011-07-18 09:41:02.462012 mon2 -> 'osdmap e6517 pg 2.6b (2.6b) -> up
[3,13] acting [3,13]' (0)

I've also looked at the filesystem: $pgid_head directories do neither
exist on osd003 nor on osd013.

I supect that the PGs are empty because they belong to a pool that we
don't use, as we use ceph for rbd exclusive.

Regards,
Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
