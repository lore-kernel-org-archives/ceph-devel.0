From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Statistics / Nagios
Date: Mon, 26 Nov 2012 13:17:44 -0800
Message-ID: <50B3DC78.1050400@inktank.com>
References: <50B262F2.4090205@profihost.ag> <9536A23884D44002B4C59911713210DF@inktank.com> <50B2723D.5020904@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34931 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756123Ab2KZVRs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Nov 2012 16:17:48 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so8326044pbc.19
        for <ceph-devel@vger.kernel.org>; Mon, 26 Nov 2012 13:17:48 -0800 (PST)
In-Reply-To: <50B2723D.5020904@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Right; you'd want to make separate socket paths for each daemon 
(something like admin socket = /var/run/$cluster-$name.sock should do,
although note that the default is already /var/run/ceph/$cluster-$name.asok)

On 11/25/2012 11:32 AM, Stefan Priebe wrote:
> Hi Greg,
>
> Am 25.11.2012 20:08, schrieb Gregory Farnum:
>> On Sunday, November 25, 2012 at 10:26 AM, Stefan Priebe wrote:
>>> Hello list,
>>>
>>> are there any useful statistics for ceph? ceph -s shows just the status
>>> but i would like to record something which gives me an idea about the
>>> ceph load or usage.
>>
>> Each daemon has an admin socket which you can use to extract
>> "perfcounters" (performance counters). It's not well-documented at all
>> right now, unfortunately.
>> "ceph --admin-daemon /path/to/admin/socket help"
>> "ceph --admin-daemon /path/to/admin/socket perfcounters_dump"
>>
>> "ceph --admin-daemon /path/to/admin/socket perfcounters_schema"
>>
>> should get you started.
>> http://ceph.com/docs/master/radosgw/troubleshooting has some examples
>> of troubleshooting the gateway with them.
>
> thanks! I don't use radosgw. Just ceph-mon and ceph-osd with rbd block
> devices.
>
> So i have to query each OSD on their own?
>
> Right now i have
> [global]
>    admin socket=/var/run/ceph.sock
>
> but that gives:
> # ceph --admin-daemon /var/run/ceph.sock perfcounters_schema
> {}
>
> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
