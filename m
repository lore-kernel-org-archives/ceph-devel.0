From: Sreenath BH <bhsreenath@gmail.com>
Subject: Re: Slow OSD detection
Date: Tue, 13 Jan 2015 18:22:31 +0530
Message-ID: <CALgKBSkAMCMJC4obnHBBgB3bCAEmmMYMdpEmeD6Tcdw3b3x36A@mail.gmail.com>
References: <CALgKBSmF=Au_CPNRBRwvMrDejs2=JuqO4zf-AzQfT04uyqnTtg@mail.gmail.com>
	<CA+4uBUbxsK-TwWvWjr_ynVOjsRic5YD+Qm2CbzwPxgyTWMs7kg@mail.gmail.com>
	<546FA9A3.8090908@redhat.com>
	<CA+4uBUZtuFc=2nFcay_GWn6ksRtW=Qp7UhzChh4MqczmH4N7hQ@mail.gmail.com>
	<CALgKBSk+Zk9jAECaQcNWx_Avto85LwK-a-Njqc7wkoL5hrdP5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:42920 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbbAMMwc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jan 2015 07:52:32 -0500
Received: by mail-qg0-f46.google.com with SMTP id q107so1898038qgd.5
        for <ceph-devel@vger.kernel.org>; Tue, 13 Jan 2015 04:52:31 -0800 (PST)
In-Reply-To: <CALgKBSk+Zk9jAECaQcNWx_Avto85LwK-a-Njqc7wkoL5hrdP5w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sjust@redhat.com
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

When I run "ceph --admin-daemon perf dump" by pointing at a osd admin
socket, I get a lot of performance related data. I see a few values
that are of particular interest:

1. filestore : journal_latency - This is a long running average value
2. osd : op_w_latency - long running average
3. osd : op_w_process_latency - long running average.

Since there is a count and a sum assoicated with these type of values,
we can potentially get an average value over a very smal time period,
by reading in quick succession.

Would it be correct to say that journal write latency decides
"slowness" of a OSD, since this is a sync. operation?

Second question: It is easy to say which OSD is slow in a given
server(node). But to compare it against all servers in the cluster, we
need a mechanism to make the per-server data available at one single
point for comparing and reporting. Instead of creating another
cluster-wide process for this purpose, can we use the ceph monitor for
this purpose?

-Sreenath


On 11/24/14, Sreenath BH <bhsreenath@gmail.com> wrote:
> I think we could find five top OSDs which has the maximum average slow
> times, as well as five OSDs with absolute maximum time.
>
> Should we also be correlating this with SMART data associated with the
> disk?
> Some agency has to do the comparison in a storage node and make this
> available to other  nodes to compare with their own data.
>
> -Sreenath
>
> On 11/22/14, Samuel Just <sam.just@inktank.com> wrote:
>> The challenge I think is that "slow osd" is probably a global
>> question.  That is, I think it requires the agent to compare a given
>> osd to the other osds in the cluster (and to itself earlier in time).
>> -Sam
>>
>> On Fri, Nov 21, 2014 at 1:07 PM, Mark Nelson <mark.nelson@inktank.com>
>> wrote:
>>> It'd be nice if something like slow OSD detection could exist outside of
>>> calamari and itself by an event that we record in the logs and make
>>> available via the admin socket (so that calamari could pick it up). That
>>> way
>>> folks could get it into logstash and other system monitoring tools (say
>>> PCP/Nagios/etc).
>>>
>>> Mark
>>>
>>>
>>> On 11/21/2014 02:58 PM, Samuel Just wrote:
>>>>
>>>> It's still an open item.  #ceph-devel would be a good place to bounce
>>>> ideas.  Through the admin_socket and perf_counter machinery, the osds
>>>> already expose a bunch of information about queue length, latency,
>>>> etc.  This might actually fit well in calamari, which already gathers
>>>> a bunch of those stats.
>>>> -Sam
>>>>
>>>> On Thu, Nov 20, 2014 at 9:00 PM, Sreenath BH <bhsreenath@gmail.com>
>>>> wrote:
>>>>>
>>>>> Hi All
>>>>>
>>>>> Slow OSD detection is mentioned as one of the projects ideas in
>>>>> https://wiki.ceph.com/Development/Project_Ideas
>>>>>
>>>>> I am interested in implementing this. Is this still an open item?
>>>>>
>>>>> thanks,
>>>>> Sreenath
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>> in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>> in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>
>
