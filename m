From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Crush and Monitor questions
Date: Wed, 12 Dec 2012 19:32:54 +0000
Message-ID: <50C8DBE6.4020506@inktank.com>
References: <ka84oo$sa3$1@ger.gmane.org> <50C8C0E1.6060909@inktank.com> <kaakb9$ql5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33190 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849Ab2LLTdN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 14:33:13 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so605593bkw.19
        for <ceph-devel@vger.kernel.org>; Wed, 12 Dec 2012 11:33:12 -0800 (PST)
In-Reply-To: <kaakb9$ql5$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bryant Ng <bryantng@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 12/12/2012 07:02 PM, Bryant Ng wrote:
> I guess my question was where is the crushmap (and osdmap) persisted on
> the monitor node?
>
> If the entire cluster goes down, I assume the monitor is reading the
> crushmap from some persistent file stored on disk or a db?  Is that why
> the minimum recommended storage for monitors is 10GB?  Is the crushmap
> and osdmap stored in those 10GB?
>
> -Bryant
>

The monitor maintains a 'store'. This is why you have to 'ceph-mon 
--mkfs' before you can run the monitor.

The monitor store needs to room to grow, given that the monitor will 
store pretty much every update to the osdmap, monmap, crushmap, keyring,...

Some of this info will also be pruned regularly though, but it's advised 
to keep enough space around.

Hope this clarifies things.

   -Joao

> Joao Eduardo Luis wrote:
>> Hello Bryant,
>>
>> On 12/11/2012 08:23 PM, Bryant Ng wrote:
>>> Hi,
>>>
>>> I'm pretty new to Ceph and am just learning about it.
>>>
>>> Where are the CRUSH maps stored in Ceph? In the documentation I see you
>>> use the 'crushtool' to compile and decompile the crush map.
>>
>> The crushmap is kept alongside with the osdmap, and shared by the
>> monitors.
>>
>>> I understand that if a single monitor comes online, it can talk to the
>>> other existing monitors to get the cluster map but how does it work on
>>> initial startup?  Or if the entire Ceph clusters goes down b/c of power
>>> failure or something.
>>
>> If you add a new monitor to an existing cluster, it will synchronize
>> with the existing monitors and will obtain all their infos, including
>> the crushmap. Updates to the crushmap will also be shared among the
>> monitors in the quorum.
>>
>> If you are starting up fresh, you will have to either add your custom
>> crushmap to the monitors (using the ceph tool), or stick with the
>> default crushmap (which only defines something along the lines of a
>> 'default' root, a 'defaultrack' rack and a 'localhost' host).
>>
>> If the entire cluster goes down... well, if the monitors are not up they
>> won't be able to share the crushmap. When they are brought back up, then
>> they will pick up where they left. But I'm not sure if I understand what
>> your question is.
>>
>>    -Joao
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

