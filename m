From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Geo-replication with RBD
Date: Wed, 20 Feb 2013 17:53:08 +0100
Message-ID: <-4374240445035147123@unknownmsgid>
References: <5B735879-C53B-4C07-8F60-97889F275481@portal.onet.pl>
 <CANygib8Z=+ik3WbPNcyXTkSV3o2wC9+06fp58EnhUax3cgJBng@mail.gmail.com>
 <CAMwB3TiWKJ+e+81B4gDSkNnPMWQRzpqCT7pDJU+d_q0iTfjP5A@mail.gmail.com>
 <CAMwB3TixO3gOhP5g+47NbSwpBU7PYV8vT2Ymm0-HgDLjh0RHcQ@mail.gmail.com>
 <CAOLwVU=L2SK=uHh+9nRihsPN3gawyHnnTtyBm98oKXNMZ_U9Aw@mail.gmail.com>
 <-6440009782960940725@unknownmsgid> <alpine.DEB.2.00.1302200832180.23463@cobra.newdream.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:59249 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756173Ab3BTQxJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Feb 2013 11:53:09 -0500
Received: by mail-ie0-f171.google.com with SMTP id 10so10228576ied.30
        for <ceph-devel@vger.kernel.org>; Wed, 20 Feb 2013 08:53:09 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1302200832180.23463@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, Neil Levine <neil.levine@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Like i say, yes. Now it is only option, to migrate data from one
cluster to other, and now it must be enough, with some auto features.

But is there any timeline, or any brainstorming in ceph internal
meetings, about any possible replication in block level, or something
like that ??

On 20 lut 2013, at 17:33, Sage Weil <sage@inktank.com> wrote:

> On Wed, 20 Feb 2013, S?awomir Skowron wrote:
>> My requirement is to have full disaster recovery, buisness continuity,
>> and failover of automatet services on second Datacenter, and not on
>> same ceph cluster.
>> Datacenters have 10GE dedicated link, for communication, and there is
>> option to expand cluster into two DataCenters, but it is not what i
>> mean.
>> There are advantages of this option like fast snapshots, and fast
>> switch of services, but there are some problems.
>>
>> When we talk about disaster recovery i mean that whole storage cluster
>> have problems, not only services at top of storage. I am thinking
>> about bug, or mistake of admin, that makes cluster not accessible in
>> any copy, or a upgrade that makes data corruption, or upgrade that is
>> disruptive for services - auto failover services into another DC,
>> before upgrade cluster.
>>
>> If cluster have a solution to replicate data in rbd images to next
>> cluster, than, only data are migrated, and when disaster comes, than
>> there is no need to work on last imported snapshot (there can be
>> constantly imported snapshot with minutes, or hour, before last
>> production), but work on data from now. And when we have automated
>> solution to recover DB (one of app service on top of rbd) clusters in
>> new datacenter infrastructure, than we have a real disaster recovery
>> solution.
>>
>> That's why we made, a s3 api layer synchronization to another DC, and
>> Amazon, and only RBD is left.
>
> Have you read the thread from Jens last week, 'snapshot, clone and mount a
> VM-Image'?  Would this type of capability capture you're requirements?
>
> sage
>
>>
>> Dnia 19 lut 2013 o godz. 10:23 "S?bastien Han"
>> <han.sebastien@gmail.com> napisa?(a):
>>
>>> Hi,
>>>
>>> For of all, I have some questions about your setup:
>>>
>>> * What are your requirements?
>>> * Are the DCs far from each others?
>>>
>>> If they are reasonably close to each others, you can setup a single
>>> cluster, with replicas across both DCs and manage the RBD devices with
>>> pacemaker.
>>>
>>> Cheers.
>>>
>>> --
>>> Regards,
>>> S?bastien Han.
>>>
>>>
>>> On Mon, Feb 18, 2013 at 3:20 PM, S?awomir Skowron <szibis@gmail.com> wrote:
>>>> Hi, Sorry for very late response, but i was sick.
>>>>
>>>> Our case is to make a failover rbd instance in another cluster. We are
>>>> storing block device images, for some services like Database. We need
>>>> to have a two clusters, synchronized, for a quick failover, if first
>>>> cluster goes down, or for upgrade with restart, or many other cases.
>>>>
>>>> Volumes are in many sizes: 1-500GB
>>>> external block device for kvm vm, like EBS.
>>>>
>>>> On Mon, Feb 18, 2013 at 3:07 PM, S?awomir Skowron <szibis@gmail.com> wrote:
>>>>> Hi, Sorry for very late response, but i was sick.
>>>>>
>>>>> Our case is to make a failover rbd instance in another cluster. We are
>>>>> storing block device images, for some services like Database. We need to
>>>>> have a two clusters, synchronized, for a quick failover, if first cluster
>>>>> goes down, or for upgrade with restart, or many other cases.
>>>>>
>>>>> Volumes are in many sizes: 1-500GB
>>>>> external block device for kvm vm, like EBS.
>>>>>
>>>>>
>>>>> On Fri, Feb 1, 2013 at 12:27 AM, Neil Levine <neil.levine@inktank.com>
>>>>> wrote:
>>>>>>
>>>>>> Skowron,
>>>>>>
>>>>>> Can you go into a bit more detail on your specific use-case? What type
>>>>>> of data are you storing in rbd (type, volume)?
>>>>>>
>>>>>> Neil
>>>>>>
>>>>>> On Wed, Jan 30, 2013 at 10:42 PM, Skowron S?awomir
>>>>>> <slawomir.skowron@grupaonet.pl> wrote:
>>>>>>> I make new thread, because i think it's a diffrent case.
>>>>>>>
>>>>>>> We have managed async geo-replication of s3 service, beetwen two ceph
>>>>>>> clusters in two DC's, and to amazon s3 as third. All this via s3 API. I love
>>>>>>> to see native RGW geo-replication with described features in another thread.
>>>>>>>
>>>>>>> There is another case. What about RBD replication ?? It's much more
>>>>>>> complicated, and for disaster recovery much more important, just like in
>>>>>>> enterprise storage arrays.
>>>>>>> One cluster in two DC's, not solving problem, because we need security
>>>>>>> in data consistency, and isolation.
>>>>>>> Do you thinking about this case ??
>>>>>>>
>>>>>>> Regards
>>>>>>> Slawomir Skowron--
>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> -----
>>>>> Pozdrawiam
>>>>>
>>>>> S?awek "sZiBis" Skowron
>>>>
>>>>
>>>>
>>>> --
>>>> -----
>>>> Pozdrawiam
>>>>
>>>> S?awek "sZiBis" Skowron
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
