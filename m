From: Sreenath BH <bhsreenath@gmail.com>
Subject: Re: Slow OSD detection
Date: Mon, 24 Nov 2014 12:48:27 +0530
Message-ID: <CALgKBSk+Zk9jAECaQcNWx_Avto85LwK-a-Njqc7wkoL5hrdP5w@mail.gmail.com>
References: <CALgKBSmF=Au_CPNRBRwvMrDejs2=JuqO4zf-AzQfT04uyqnTtg@mail.gmail.com>
	<CA+4uBUbxsK-TwWvWjr_ynVOjsRic5YD+Qm2CbzwPxgyTWMs7kg@mail.gmail.com>
	<546FA9A3.8090908@redhat.com>
	<CA+4uBUZtuFc=2nFcay_GWn6ksRtW=Qp7UhzChh4MqczmH4N7hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:61206 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbaKXHS2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Nov 2014 02:18:28 -0500
Received: by mail-vc0-f177.google.com with SMTP id ij19so3783713vcb.8
        for <ceph-devel@vger.kernel.org>; Sun, 23 Nov 2014 23:18:27 -0800 (PST)
In-Reply-To: <CA+4uBUZtuFc=2nFcay_GWn6ksRtW=Qp7UhzChh4MqczmH4N7hQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sjust@redhat.com
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I think we could find five top OSDs which has the maximum average slow
times, as well as five OSDs with absolute maximum time.

Should we also be correlating this with SMART data associated with the disk?
Some agency has to do the comparison in a storage node and make this
available to other  nodes to compare with their own data.

-Sreenath

On 11/22/14, Samuel Just <sam.just@inktank.com> wrote:
> The challenge I think is that "slow osd" is probably a global
> question.  That is, I think it requires the agent to compare a given
> osd to the other osds in the cluster (and to itself earlier in time).
> -Sam
>
> On Fri, Nov 21, 2014 at 1:07 PM, Mark Nelson <mark.nelson@inktank.com>
> wrote:
>> It'd be nice if something like slow OSD detection could exist outside of
>> calamari and itself by an event that we record in the logs and make
>> available via the admin socket (so that calamari could pick it up). That
>> way
>> folks could get it into logstash and other system monitoring tools (say
>> PCP/Nagios/etc).
>>
>> Mark
>>
>>
>> On 11/21/2014 02:58 PM, Samuel Just wrote:
>>>
>>> It's still an open item.  #ceph-devel would be a good place to bounce
>>> ideas.  Through the admin_socket and perf_counter machinery, the osds
>>> already expose a bunch of information about queue length, latency,
>>> etc.  This might actually fit well in calamari, which already gathers
>>> a bunch of those stats.
>>> -Sam
>>>
>>> On Thu, Nov 20, 2014 at 9:00 PM, Sreenath BH <bhsreenath@gmail.com>
>>> wrote:
>>>>
>>>> Hi All
>>>>
>>>> Slow OSD detection is mentioned as one of the projects ideas in
>>>> https://wiki.ceph.com/Development/Project_Ideas
>>>>
>>>> I am interested in implementing this. Is this still an open item?
>>>>
>>>> thanks,
>>>> Sreenath
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>> in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>
