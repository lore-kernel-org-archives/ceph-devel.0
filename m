From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: Encrypted over WAN?
Date: Mon, 2 Oct 2017 16:35:44 +0100
Message-ID: <94831fcd-c9c1-c7b5-b6cf-1ddfad6da982@suse.de>
References: <CAKRxpuuFHUgoQh8MfhS=vK9f6NVRbAWyccMWWGwJM9UCnw8dtw@mail.gmail.com>
 <bc3240a6-1f91-8711-dc59-d8319825b5fb@suse.de>
 <CAKRxpuu-BKh1h4X9_Vr-pDmGFT=BmVztk1gg9de0X96Sj4-55w@mail.gmail.com>
 <26512ea7-d55e-a09f-7b36-4e271a8f2902@suse.de>
 <CAJ4mKGbBVsWS3XL_chz4Rm2n6gY7T5sz3GVJM+nSBQH-GDujPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42506 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751514AbdJBPfq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 2 Oct 2017 11:35:46 -0400
In-Reply-To: <CAJ4mKGbBVsWS3XL_chz4Rm2n6gY7T5sz3GVJM+nSBQH-GDujPA@mail.gmail.com>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, Two Spirit <twospirit6905@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 10/02/2017 04:34 PM, Gregory Farnum wrote:
> On Mon, Oct 2, 2017 at 2:48 AM, Joao Eduardo Luis <joao@suse.de> wrote:
>> On 10/02/2017 10:46 AM, Two Spirit wrote:
>>>
>>> I think that is a hard security pill to swallow sending data in
>>> plaintext over the WAN. I think there are mitm and replay attack
>>> issues. I dont think anyone would knowingly send unencrypted file
>>> server content across the WAN.
>>>
>>> I think in about 15 states or so, Sarbanes Oxley laws prevents certain
>>> personal information to be "transmitted" in the clear. You need to ask
>>> a lawyer what that means. maybe it doesn't apply here.  This is
>>> information HR and Finance depts typically hold. I could see that some
>>> HR could be clueless on what their file system is doing with their
>>> data. Also IT guys don't necessarily know corporate law. I don't know
>>> if HIPAA or Gramm-Leach-Blilely Act would have problems. I don't think
>>> Equifax will use Ceph.
>>>
>>> In a federated setup, is there a way to wrap the region to region
>>> traffic and encrypt?
>>
>>
>> Just because Ceph doesn't natively encrypt on-the-wire communication, it
>> doesn't mean you can't have an encrypted layer if that's something you need.
>>
>>    -Joao
>>
>>
>>
>>> On Mon, Oct 2, 2017 at 1:02 AM, Joao Eduardo Luis <joao@suse.de> wrote:
>>>>
>>>> On 10/02/2017 07:18 AM, Two Spirit wrote:
>>>>>>
>>>>>>
>>>>>> The Ceph Object Gateway supports server-side encryption of uploaded
>>>>>> objects, with 3 options for the management of encryption keys.
>>>>>> Server-side
>>>>>> encryption means that the data is sent over HTTP in its unencrypted
>>>>>> form,
>>>>>> and the Ceph Object Gateway stores that data in the Ceph Storage
>>>>>> Cluster in
>>>>>> encrypted form.
>>>>>
>>>>>
>>>>>
>>>>> It sounds like OSD to OSD traffic is unencrypted.
>>>>>
>>>>> 1) Does "stores data in the cluster in encrypted form" mean *only* if
>>>>> the --dmcrypt option is used?
>>>>>
>>>>> 2) Does that mean the zone  to zone copy across a WAN is also
>>>>> unencrypted?
>>>>
>>>>
>>>>
>>>> Ceph does not have on-the-wire encryption.
>>>>
>>>>     -Joao
> 
> Keep in mind there are two different protocols here. The internal Ceph
> messenger protocol for OSD replication and RADOS clients is not
> encrypted at all. But the RADOS Gateway multi-site federation all
> happens over HTTP. And I believe it's easy to configure to HTTPS since
> it provides all those encryption over-the-wire options. ;)

TIL. Thanks!

   -Joao

