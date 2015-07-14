From: Konstantin Danilov <kdanilov@mirantis.com>
Subject: Re: Block storage performance test tool - would like to merge into cbt
Date: Tue, 14 Jul 2015 15:54:48 +0300
Message-ID: <CACxKWawjp_fU8rwFjMFx04a-BuTodh-nsw5iW6=pRXmY3KS+7A@mail.gmail.com>
References: <CACxKWazeKFOoebysNJ4XajwEmBf2kk6Asw0WVAAKLo=hCp32sA@mail.gmail.com>
	<55A3D647.1050703@redhat.com>
	<CACxKWaw_YA=SNKuA47emK1_QVwsrehWtYaLL7no9dQEPaZ3YaA@mail.gmail.com>
	<55A4F0F7.20204@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:36161 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbbGNMyu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jul 2015 08:54:50 -0400
Received: by lbbpo10 with SMTP id po10so5532367lbb.3
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2015 05:54:49 -0700 (PDT)
In-Reply-To: <55A4F0F7.20204@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel@vger.kernel.org, Ben England <bengland@redhat.com>, Ben Turner <bturner@redhat.com>, Kyle Bader <kbader@redhat.com>, tyler Brekke <tbrekke@redhat.com>, cbt <cbt@ceph.com>

I think better to discuss after the meeting

On Tue, Jul 14, 2015 at 2:22 PM, Mark Nelson <mnelson@redhat.com> wrote:
> Probably depends how much time it will take.  I'd say if we think it might
> be more than 15 minutes of discussion we should wait until the end of the
> performance meeting and then talk about it.  If it's fairly quick though we
> could probably add it to the perf meeting itself.
>
> Mark
>
>
> On 07/14/2015 03:11 AM, Konstantin Danilov wrote:
>>
>> Mark,
>>
>> does Wednesday performance meeting is a good place for discussion, or
>> we need a separated one?
>>
>> On Mon, Jul 13, 2015 at 6:16 PM, Mark Nelson <mnelson@redhat.com> wrote:
>>>
>>> Hi Konstantin,
>>>
>>> I'm definitely interested in looking at your tools and seeing if we can
>>> merge them into cbt!  One of the things we lack right now in cbt is any
>>> kind
>>> of real openstack integration.  Right now CBT basically just assumes
>>> you've
>>> already launched VMs and specified them as clients in the yaml, so being
>>> able to spin up VMs in a standard way would be very useful.  It might be
>>> worth exploring if we can use your tool to make the cluster base class
>>> "openstack aware" so that any of the eventual cluster classes (ceph, and
>>> maybe some day gluster, swift, etc) can use it to launch VMs or do other
>>> things.  I'd really love to be able to create a cbt yaml config file and
>>> iterate through parametric configuration parameters building multiple
>>> different clusters and running tests against them with system monitoring
>>> and
>>> data post processing happening automatically.
>>>
>>> The data post processing is also something that will be very useful.  We
>>> have a couple of folks really interested in this area as well.
>>>
>>> Mark
>>>
>>>
>>>
>>>
>>> On 07/11/2015 03:02 AM, Konstantin Danilov wrote:
>>>>
>>>>
>>>> Hi all,
>>>>
>>>> We(Mirantis ceph team) have a tool for block storage performance test,
>>>> called 'wally' -
>>>> https://github.com/Mirantis/disk_perf_test_tool.
>>>>
>>>> It has some nice features, like:
>>>>
>>>> * Openstack and FUEL integration (can spawn VM for tests, gather HW
>>>> info,
>>>> etc)
>>>> * Set of tests, joined into suit, which measures different performnce
>>>> aspects and
>>>> creates joined report, as example -
>>>> http://koder-ua.github.io/6.1GA/cinder_volume_iscsi.html,
>>>> VM running on ceph drives report example -
>>>> http://koder-ua.github.io/random/ceph_example.html
>>>> * Data postrocessing - confidence intervals, etc
>>>>
>>>> We would like to merge our code into cbt. Do you interesting in it?
>>>> Can we discuss a way to merge?
>>>>
>>>> Thanks
>>>>
>>>
>>
>>
>>
>



-- 
Kostiantyn Danilov aka koder.ua
Principal software engineer, Mirantis

skype:koder.ua
http://koder-ua.blogspot.com/
http://mirantis.com
