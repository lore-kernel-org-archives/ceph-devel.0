From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Encrypted over WAN?
Date: Mon, 2 Oct 2017 08:34:44 -0700
Message-ID: <CAJ4mKGbBVsWS3XL_chz4Rm2n6gY7T5sz3GVJM+nSBQH-GDujPA@mail.gmail.com>
References: <CAKRxpuuFHUgoQh8MfhS=vK9f6NVRbAWyccMWWGwJM9UCnw8dtw@mail.gmail.com>
 <bc3240a6-1f91-8711-dc59-d8319825b5fb@suse.de> <CAKRxpuu-BKh1h4X9_Vr-pDmGFT=BmVztk1gg9de0X96Sj4-55w@mail.gmail.com>
 <26512ea7-d55e-a09f-7b36-4e271a8f2902@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:52113 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751193AbdJBPep (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Oct 2017 11:34:45 -0400
Received: by mail-it0-f46.google.com with SMTP id v82so7854548itc.0
        for <ceph-devel@vger.kernel.org>; Mon, 02 Oct 2017 08:34:45 -0700 (PDT)
In-Reply-To: <26512ea7-d55e-a09f-7b36-4e271a8f2902@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Joao Eduardo Luis <joao@suse.de>

On Mon, Oct 2, 2017 at 2:48 AM, Joao Eduardo Luis <joao@suse.de> wrote:
> On 10/02/2017 10:46 AM, Two Spirit wrote:
>>
>> I think that is a hard security pill to swallow sending data in
>> plaintext over the WAN. I think there are mitm and replay attack
>> issues. I dont think anyone would knowingly send unencrypted file
>> server content across the WAN.
>>
>> I think in about 15 states or so, Sarbanes Oxley laws prevents certain
>> personal information to be "transmitted" in the clear. You need to ask
>> a lawyer what that means. maybe it doesn't apply here.  This is
>> information HR and Finance depts typically hold. I could see that some
>> HR could be clueless on what their file system is doing with their
>> data. Also IT guys don't necessarily know corporate law. I don't know
>> if HIPAA or Gramm-Leach-Blilely Act would have problems. I don't think
>> Equifax will use Ceph.
>>
>> In a federated setup, is there a way to wrap the region to region
>> traffic and encrypt?
>
>
> Just because Ceph doesn't natively encrypt on-the-wire communication, it
> doesn't mean you can't have an encrypted layer if that's something you need.
>
>   -Joao
>
>
>
>> On Mon, Oct 2, 2017 at 1:02 AM, Joao Eduardo Luis <joao@suse.de> wrote:
>>>
>>> On 10/02/2017 07:18 AM, Two Spirit wrote:
>>>>>
>>>>>
>>>>> The Ceph Object Gateway supports server-side encryption of uploaded
>>>>> objects, with 3 options for the management of encryption keys.
>>>>> Server-side
>>>>> encryption means that the data is sent over HTTP in its unencrypted
>>>>> form,
>>>>> and the Ceph Object Gateway stores that data in the Ceph Storage
>>>>> Cluster in
>>>>> encrypted form.
>>>>
>>>>
>>>>
>>>> It sounds like OSD to OSD traffic is unencrypted.
>>>>
>>>> 1) Does "stores data in the cluster in encrypted form" mean *only* if
>>>> the --dmcrypt option is used?
>>>>
>>>> 2) Does that mean the zone  to zone copy across a WAN is also
>>>> unencrypted?
>>>
>>>
>>>
>>> Ceph does not have on-the-wire encryption.
>>>
>>>    -Joao

Keep in mind there are two different protocols here. The internal Ceph
messenger protocol for OSD replication and RADOS clients is not
encrypted at all. But the RADOS Gateway multi-site federation all
happens over HTTP. And I believe it's easy to configure to HTTPS since
it provides all those encryption over-the-wire options. ;)
