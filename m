From: Huamin Chen <hchen@redhat.com>
Subject: Re: REST API Client
Date: Wed, 17 Jan 2018 15:30:32 -0500
Message-ID: <CAD-gW==OXoa0pYVwZo6X8gOb--BYoCsSDiaYzPdNBE2-WtjFLw@mail.gmail.com>
References: <CAD-gW==8X416nALGMunjXdjxsWCE+qRDm9+YfYUZ047mT4FrQw@mail.gmail.com>
 <CA+aFP1Dd1t3oNiME0wmF4bnAHGMqEuC+1AfBWGMDe1=J34HaUg@mail.gmail.com>
 <CAD-gW==DjR1Ndu+0s+ep_jshcgtHQVf8sJuEmm1K_82CkRxGtQ@mail.gmail.com> <CALe9h7coXaYcXZyAgx0O5PVyGVJsB0=0T7OPjo-RJbSTQ8fMbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36814 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753282AbeAQUad (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jan 2018 15:30:33 -0500
Received: by mail-oi0-f68.google.com with SMTP id w135so14100959oie.3
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jan 2018 12:30:33 -0800 (PST)
In-Reply-To: <CALe9h7coXaYcXZyAgx0O5PVyGVJsB0=0T7OPjo-RJbSTQ8fMbw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Jason Dillaman <dillaman@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Dockerfile is here
https://github.com/ceph/ceph-csi/blob/master/deploy/docker/Dockerfile

Here is a breakdown:

- rbd CSI container image is 403MB
- rbd CSI binary is 35MB
- centos:7 container image is 203MB
- ceph-common and dependency is about 160MB

On Wed, Jan 17, 2018 at 12:09 PM, John Spray <jspray@redhat.com> wrote:
> On Wed, Jan 17, 2018 at 3:48 PM, Huamin Chen <hchen@redhat.com> wrote:
>> On Wed, Jan 17, 2018 at 9:17 AM, Jason Dillaman <jdillama@redhat.com> wrote:
>>> On Wed, Jan 17, 2018 at 8:47 AM, Huamin Chen <hchen@redhat.com> wrote:
>>>> Hi,
>>>>
>>>> I am thinking of using Ceph REST API tclient o remove rbd cli
>>>> dependency from Kubernetes and rbd CSI driver.
>>>>
>>>> The potential work flow is
>>>> - for rbd map, use sysfs
>>>
>>> Why re-implement the wheel? I think the rbd CLI is a good fit for this
>>> use-case. Especially when you consider that the CSI driver should
>>> eventually support not only krbd, but nbd and tcmu-based block device
>>> drivers. These are all being unified via new "rbd device map
>>> --device-type <XYZ>" / "rbd device unmap" CLI commands to provide a
>>> unified interface [1].
>>>
>>
>> The reason is to slim down the driver container. If CSI driver doesn't
>> use rbd cli, then we don't need to install ceph-common.
>
> Out of curiousity, how big is the image today with just the minimal
> dependencies of librbd?
>
> John
>
>>
>> But you are right, nbd and other drivers are still something to consider.
>>
>>
>>>> - use REST API client for rbd status, rbd create and rm
>>>>
>>>> Questions: Does current Ceph REST server support these rbd calls? Has
>>>> anybody already worked on Golang client?
>>>
>>> Not to my knowledge. Assuming you keep the rbd CLI which will bring
>>> with it the librados2 and librbd1 shared libraries, any reason to not
>>> just directly use / expand the Ceph golang API [2]?
>>>
>>>> I found some early work on python client [1] but so far no work on
>>>> golang client. If I missed it, please let me know.
>>>>
>>>>
>>>> 1. https://github.com/dmsimard/python-cephclient
>>>>
>>>> Thanks
>>>>
>>>> Huamin
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>> [1] https://github.com/ceph/ceph/pull/19711
>>> [2] https://github.com/ceph/go-ceph
>>>
>>> --
>>> Jason
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
