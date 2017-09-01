From: Two Spirit <twospirit6905@gmail.com>
Subject: Re: ceph-mon leader election problem, should it be improved ?
Date: Fri, 1 Sep 2017 09:06:26 -0700
Message-ID: <CAKRxpusG2D-jKVgWiBJpfkJGdpqVutaSegT-2aXJy4=QfHNivw@mail.gmail.com>
References: <CAGOEmcO6L2j04NEx5U_wY0WUNnzowW1JkcqKbmtewm6f4rC1PQ@mail.gmail.com>
 <cfb3c139-7423-644f-ce4c-00d55cce5756@suse.de> <CAGOEmcNwuHGoXyAPr51P73pbZL5XOiORhL4P6w7R2yi19e71vA@mail.gmail.com>
 <52301842-ce14-1a1d-72cb-816633f2b860@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33368 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbdIAQGd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Sep 2017 12:06:33 -0400
Received: by mail-io0-f173.google.com with SMTP id b2so4252427iof.0
        for <ceph-devel@vger.kernel.org>; Fri, 01 Sep 2017 09:06:33 -0700 (PDT)
In-Reply-To: <52301842-ce14-1a1d-72cb-816633f2b860@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao@suse.de>
Cc: Z Will <zhao6305@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Ceph Users <ceph-users@lists.ceph.com>, Sage Weil <sage@newdream.net>

>This by itself is not a problem since we don't see many real-world cases where this behaviour happens, and we are a lot more interested in making sure we have a quorum - given without a quorum your cluster is effectively unusable.

Hello, I'm starting some testcases to simulate some of this. I'm not
sure I understand all of it, but it sounds very similar to some
concerns I have. If my Ceph cluster spans US, and I have two region,
Western and Central and Western campus has multiple buildings (let's
just say Mon.Western.A, Mon.Western.B, Mon.Central.A -- This could be
easily Mon.Campus1.BuildingA, Mon.Campus1.BuildingB, and
Mon.Campus2.BuildingA) and we loose connection between regions, will
Western and Central both be able to read all their data? Western would
have quorum so I assume write updates to Western would be fine.
Or would Central no longer have access to the files?

I haven't found it, but are there any docs on what the the manual
human intervention requires?<div
id="DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2"><br />
<table style="border-top: 1px solid #D3D4DE;">
	<tr>
        <td style="width: 55px; padding-top: 13px;"><a
href="http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail"
target="_blank"><img
src="https://ipmcdn.avast.com/images/icons/icon-envelope-tick-green-avg-v1.png"
alt="" width="46" height="29" style="width: 46px; height: 29px;"
/></a></td>
		<td style="width: 470px; padding-top: 12px; color: #41424e;
font-size: 13px; font-family: Arial, Helvetica, sans-serif;
line-height: 18px;">Virus-free. <a
href="http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail"
target="_blank" style="color: #4453ea;">www.avg.com</a>
		</td>
	</tr>
</table><a href="#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2" width="1"
height="1"></a></div>

On Wed, Jul 5, 2017 at 3:26 AM, Joao Eduardo Luis <joao@suse.de> wrote:
> On 07/05/2017 08:01 AM, Z Will wrote:
>>
>> Hi Joao:
>>     I think this is all because we choose the monitor with the
>> smallest rank number to be leader. For this kind of network error, no
>> matter which mon has lost connection with the  mon who has the
>> smallest rank num , will be constantly calling an election, that say
>> ,will constantly affact the cluster until it is stopped by human . So
>> do you think it make sense if I try to figure out a way to choose the
>> monitor who can see the most monitors ,  or with  the smallest rank
>> num if the view num is same , to be leader ?
>>     In probing phase:
>>        they will know there own view, so can set a view num.
>>     In election phase:
>>        they send the view num , rank num .
>>        when receiving the election message, it compare the view num (
>> higher is leader ) and rank num ( lower is leader).
>
>
> As I understand it, our elector trades-off reliability in case of network
> failure for expediency in forming a quorum. This by itself is not a problem
> since we don't see many real-world cases where this behaviour happens, and
> we are a lot more interested in making sure we have a quorum - given without
> a quorum your cluster is effectively unusable.
>
> Currently, we form a quorum with a minimal number of messages passed.
> From my poor recollection, I think the Elector works something like
>
> - 1 probe message to each monitor in the monmap
> - receives defer from a monitor, or defers to a monitor
> - declares victory if number of defers is an absolute majority (including
> one's defer).
>
> An election cycle takes about 4-5 messages to complete, with roughly two
> round-trips (in the best case scenario).
>
> Figuring out which monitor is able to contact the highest number of
> monitors, and having said monitor being elected the leader, will necessarily
> increase the number of messages transferred.
>
> A rough idea would be
>
> - all monitors will send probes to all other monitors in the monmap;
> - all monitors need to ack the other's probes;
> - each monitor will count the number of monitors it can reach, and then send
> a message proposing itself as the leader to the other monitors, with the
> list of monitors they see;
> - each monitor will propose itself as the leader, or defer to some other
> monitor.
>
> This is closer to 3 round-trips.
>
> Additionally, we'd have to account for the fact that some monitors may be
> able to reach all other monitors, while some may only be able to reach a
> portion. How do we handle this scenario?
>
> - What do we do with monitors that do not reach all other monitors?
> - Do we ignore them for electoral purposes?
> - Are they part of the final quorum?
> - What if we need those monitors to form a quorum?
>
> Personally, I think the easiest solution to this problem would be
> blacklisting a problematic monitor (for a given amount a time, or until a
> new election is needed due to loss of quorum, or by human intervention).
>
> For example, if a monitor believes it should be the leader, and if all other
> monitors are deferring to someone else that is not reachable, the monitor
> could then enter a special case branch:
>
> - send a probe to all monitors
> - receive acks
> - share that with other monitors
> - if that list is missing monitors, then blacklist the monitor for a period,
> and send a message to that monitor with that decision
> - the monitor would blacklist itself and retry in a given amount of time.
>
> Basically, this would be something similar to heartbeats. If a monitor can't
> reach all monitors in an existing quorum, then just don't do anything.
>
> In any case, you are more than welcome to propose a solution. Let us know
> what you come up with and if you want to discuss this a bit more ;)
>
>   -Joao
>
>
>>
>> On Tue, Jul 4, 2017 at 9:25 PM, Joao Eduardo Luis <joao@suse.de> wrote:
>>>
>>> On 07/04/2017 06:57 AM, Z Will wrote:
>>>>
>>>>
>>>> Hi:
>>>>    I am testing ceph-mon brain split . I have read the code . If I
>>>> understand it right , I know it won't be brain split. But I think
>>>> there is still another problem. My ceph version is 0.94.10. And here
>>>> is my test detail :
>>>>
>>>> 3 ceph-mons , there ranks are 0, 1, 2 respectively.I stop the rank 1
>>>> mon , and use iptables to block the communication between mon 0 and
>>>> mon 1. When the cluster is stable, start mon.1 .  I found the 3
>>>> monitors will all can not work well. They are all trying to call  new
>>>> leader  election . This means the cluster can't work anymore.
>>>>
>>>> Here is my analysis. Because mon will always respond to leader
>>>> election message, so , in my test, communication between  mon.0 and
>>>> mon.1 is blocked , so mon.1 will always try to be leader, because it
>>>> will always see mon.2, and it should win over mon.2. Mon.0 should
>>>> always win over mon.2. But mon.2 will always responsd to the election
>>>> message issued by mon.1, so this loop will never end. Am I right ?
>>>>
>>>> This should be a problem? Or is it  was just designed like this , and
>>>> should be handled by human ?
>>>
>>>
>>>
>>> This is a known behaviour, quite annoying, but easily identifiable by
>>> having
>>> the same monitor constantly calling an election and usually timing out
>>> because the peon did not defer to it.
>>>
>>> In a way, the elector algorithm does what it is intended to. Solving this
>>> corner case would be nice, but I don't think there's a good way to solve
>>> it.
>>> We may be able to presume a monitor is in trouble during the probe phase,
>>> to
>>> disqualify a given monitor from the election, but in the end this is a
>>> network issue that may be transient or unpredictable and there's only so
>>> much we can account for.
>>>
>>> Dealing with it automatically would be nice, but I think, thus far, the
>>> easiest way to address this particular issue is human intervention.
>>>
>>>   -Joao
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
