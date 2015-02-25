From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Tool for ceph performance analysis
Date: Wed, 25 Feb 2015 11:45:40 +1000
Message-ID: <54ED2944.60508@redhat.com>
References: <CAONhiy7Bu1aqML80D_7Xu42qS1ZTSMwa_W3mZ+t4ivXdwE1szQ@mail.gmail.com> <54EC6714.3090604@redhat.com> <54EC6BA9.3070405@redhat.com> <54EC8758.6050405@redhat.com>
Reply-To: bhubbard@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55027 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751866AbbBYBpv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 24 Feb 2015 20:45:51 -0500
In-Reply-To: <54EC8758.6050405@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, John Spray <john.spray@redhat.com>, Alyona Kiselyova <akiselyova@mirantis.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "ceph-calamari@lists.ceph.com" <ceph-calamari@lists.ceph.com>

On 02/25/2015 12:14 AM, Mark Nelson wrote:
> On 02/24/2015 06:16 AM, John Spray wrote:
>>
>> On 24/02/2015 11:57, John Spray wrote:
>>>> It would be great, if there will be internal possibility to collect
>>>> info about whole cluster from one node. May be, something like
>>>> extension for "tell" command, which can call any node directly and
>>>> replace external network connections. Or improved version of "ceph osd
>>>> perf" command, which would allow to get more info.
>>>>
>>> This pretty much already exists if someone chooses to deploy
>>> diamond+graphite.  Perhaps we need to talk about what's wrong with
>>> that solution as it stands?  I'm guessing the main problem is that
>>> it's less highly available than ceph mons, and comparatively
>>> heavyweight, especially if one is only interested in the latest values.
>> Ah, I also forgot to mention: it is not very hard to make a cut-down
>> version of calamari that doesn't require lots of heavyweight
>> dependencies.  I started building this a while back before switching
>> tasks, but there's an old branch here:
>> https://github.com/ceph/calamari/commits/wip-lite
>>
>> The key things there are that it doesn't require a postgres database,
>> and the remote-execution is abstracted into a "Remote" interface so that
>> you can implement alternatives to salt (e.g. SSH, or run locally on
>> mon).  It's all free software so borrow what you wish ;-)  The point is
>> that it isn't necessary to start from scratch in order to get something
>> lightweight.
>
> My personal vote is to try to get ourselves well integrated into a good cross section of the existing tools that already do this kind of thing (zabbix, collectd, collectl, etc)

...and PCP (Performance Co-Pilot) which I have begun work on.

> I'm slightly guilty of rolling my own too since in cbt I gather up some of our daemon socket output from all the hosts via ssh and just dump it in the output directory.  There's tons of other systems out there that do this kind of thing way better though.  I don't want to discourage anyone from making a new tool if that's their preference, but I think a lot of folks would benefit if they could just keep using their existing monitoring tools.
>
> Perhaps part of this might be to just try to get a better idea of which tools folks are using to do performance monitoring on their existing clusters (ceph or otherwise).  I've heard zabbix come up quite a bit recently.
>
> Mark
>
>>
>> Cheers,
>> John
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 


Kindest Regards,

Brad Hubbard
Senior Software Maintenance Engineer
Red Hat Global Support Services
Asia Pacific Region
