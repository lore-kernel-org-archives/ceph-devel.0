From: Ugis <ugis22@gmail.com>
Subject: Re: status monitoring options for ceph cluster
Date: Thu, 3 Jan 2013 11:13:50 +0200
Message-ID: <CAE63xUMhXKDk_DX+JqTn8vpvwzKjjecTNk4XUSyR+AUuX01wSQ@mail.gmail.com>
References: <CAE63xUOt5dpKPnYXN-nbJHPhPdAW2yH3ERDkwE7QO3TaVLFg4Q@mail.gmail.com>
	<50E44D79.6070809@widodh.nl>
	<50E45909.4080907@inktank.com>
	<50E4619C.6070300@conversis.de>
	<50E4BC90.4030407@inktank.com>
	<11AE4444941C6D4F9AEEADD1668595642A9F1189@MB1-COY.ad.mach.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:33867 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670Ab3ACJNv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 04:13:51 -0500
Received: by mail-ia0-f182.google.com with SMTP id x2so12662973iad.13
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 01:13:50 -0800 (PST)
In-Reply-To: <11AE4444941C6D4F9AEEADD1668595642A9F1189@MB1-COY.ad.mach.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Pettigrew <Paul.Pettigrew@mach.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Joao Eduardo Luis <joao.luis@inktank.com>, Wido den Hollander <wido@widodh.nl>, Dan Mick <dan.mick@inktank.com>, Dennis Jacobfeuerborn <dennisml@conversis.de>

Hopefully there will be some place where community can share their
ceph "how-to", hope to see what Paul offers. Wiki could be suitable
solution.

As I see at present there seems no ready solution for fine grained
ceph monitoring. Therefore I can express what I would imagine ceph
monitoring look like.
From admin perspective at least we need possibility to get "key -
value" pairs at shell level. From that point admins can use their
prefered solutions with ease - zabbix, nagios, shell scripts etc.

I would expect "ceph variables" command to return list of all
available variables and "ceph query XXXX" to return value of specified
variable.
As an example(based on excerpt from "ceph report") would be:
#ceph query overall_status
#HEALTH_OK

With such approach there would be no problems in future to add
variables not destroying previous solutions. In case of zabbix it
would be the matter of developing and sharing ceph template.
In more distant future ceph could be queryable by SNMP, but first
things first :)

Ugis


2013/1/3 Paul Pettigrew <Paul.Pettigrew@mach.com.au>:
> Happy new year all
>
> Over the past year, our company has written an extensive guide on how we monitor ceph using Zabbix.
>
> I would rather contribute it as a HOWTO or Guide into the Ceph wiki, rather than just this email thread. It is written in wiki format, and email would lose that formatting.
>
> Hopefully it will benefit others, and I can continue to maintain it and update it by incorporating advice from others as time goes by.
>
> I see this intro Blog post to monitoring:
> http://ceph.com/community/monitoring-a-ceph-cluster/
>
> That would be a good intro, and what I am proposing would be a follow-on "advanced" guide.
>
> Should it go to the Ceph Blog? Or elsewhere?
>
> If somebody can please advise how this contribution can be made, thanks!
>
> Paul
>
>
> ==
> Paul Pettigrew
> w: http://mach.com.au/
> Offices & Data Centres: Noosa | Brisbane | Cooroy | USA
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Dan Mick
> Sent: Thursday, 3 January 2013 9:03 AM
> To: Dennis Jacobfeuerborn
> Cc: Joao Eduardo Luis; Wido den Hollander; Ugis; ceph-devel@vger.kernel.org
> Subject: Re: status monitoring options for ceph cluster
>
> There are plans being discussed for RESTful interfaces for configuration and monitoring; no timetable yet but it's definitely on our radar, and we'll discuss design etc. here when it starts happening; anyone wanting to participate is of course welcome.
>
> On 01/02/2013 08:34 AM, Dennis Jacobfeuerborn wrote:
>> On 01/02/2013 04:58 PM, Joao Eduardo Luis wrote:
>>> On 01/02/2013 03:08 PM, Wido den Hollander wrote:
>>>> On 01/02/2013 04:05 PM, Ugis wrote:
>>>>> Hi all,
>>>>>
>>>>> I am planning to set up monitoring of ceph cluster relying on
>>>>> output of commands:
>>>>>
>>>>> #ceph health
>>>>> #ceph -s
>>>>>
>>>>> The need is to retrieve certain values, for example %degraded;
>>>>> proportion "X GB / Y GB avail" to calculate available space%. I
>>>>> plan to graph those values via zabbix and set up triggers for
>>>>> certain tresholds.
>>>>> May be somebody already has written shell parser for getting values
>>>>> from output of these commands?
>>>>>
>>>>> Probably this ir wider question - what is the intended approach for
>>>>> ceph cluster monitoring? What do you guys use?
>>>>
>>>> You might want to take a look at:
>>>> http://tracker.newdream.net/issues/685
>>>>
>>>> In version 0.35 a json output was added. I've never tried it before,
>>>> but you might want to look at that.
>>>
>>> Currently, the only command that will output useful json for this
>>> kind of thing is 'ceph report'. I am finishing up on a patch to add
>>> json output capabilities to 'ceph health' and 'ceph status' though,
>>> but wasn't aiming at doing it with such level of detail -- basically,
>>> just output the same info as their plain counterparts, but using json instead.
>>
>> I'm interested in this topic as well. What is also needed is a way to
>> query the state of the individual daemons on each machine in the cluster.
>>
>> Regards,
>>    Dennis
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
