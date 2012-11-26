From: Gregory Farnum <greg@inktank.com>
Subject: Re: Statistics / Nagios
Date: Mon, 26 Nov 2012 15:46:09 -0800
Message-ID: <CAPYLRzjYuyUQeMgNWFr12LE79jg+KMMUQuBk05kHvxzpCfjG-g@mail.gmail.com>
References: <50B262F2.4090205@profihost.ag>
	<9536A23884D44002B4C59911713210DF@inktank.com>
	<50B2723D.5020904@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40161 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842Ab2KZXqJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 18:46:09 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so7308688iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Nov 2012 15:46:09 -0800 (PST)
In-Reply-To: <50B2723D.5020904@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, Nov 25, 2012 at 11:32 AM, Stefan Priebe <s.priebe@profihost.ag>=
 wrote:
> Hi Greg,
>
> Am 25.11.2012 20:08, schrieb Gregory Farnum:
>
>> On Sunday, November 25, 2012 at 10:26 AM, Stefan Priebe wrote:
>>>
>>> Hello list,
>>>
>>> are there any useful statistics for ceph? ceph -s shows just the st=
atus
>>> but i would like to record something which gives me an idea about t=
he
>>> ceph load or usage.
>>
>>
>> Each daemon has an admin socket which you can use to extract
>> "perfcounters" (performance counters). It's not well-documented at a=
ll right
>> now, unfortunately.
>> "ceph --admin-daemon /path/to/admin/socket help"
>> "ceph --admin-daemon /path/to/admin/socket perfcounters_dump"
>>
>> "ceph --admin-daemon /path/to/admin/socket perfcounters_schema"
>>
>> should get you started.
>> http://ceph.com/docs/master/radosgw/troubleshooting has some example=
s of
>> troubleshooting the gateway with them.
>
>
> thanks! I don't use radosgw. Just ceph-mon and ceph-osd with rbd bloc=
k
> devices.
>
> So i have to query each OSD on their own?

That's how it stands at present, yep.

> Right now i have
> [global]
>   admin socket=3D/var/run/ceph.sock
>
> but that gives:
> # ceph --admin-daemon /var/run/ceph.sock perfcounters_schema
> {}

Hrm, I'm getting a full schema out of it when I test locally. I
suspect that maybe you're trying to query the admin tool's socket when
you do that =97 everybody, including the client tools, will export one
if it's set for them. Try using the $name metavariable as part of the
path.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
