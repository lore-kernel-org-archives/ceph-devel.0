From: Two Spirit <twospirit6905@gmail.com>
Subject: Re: Encrypted over WAN?
Date: Mon, 2 Oct 2017 02:46:10 -0700
Message-ID: <CAKRxpuu-BKh1h4X9_Vr-pDmGFT=BmVztk1gg9de0X96Sj4-55w@mail.gmail.com>
References: <CAKRxpuuFHUgoQh8MfhS=vK9f6NVRbAWyccMWWGwJM9UCnw8dtw@mail.gmail.com>
 <bc3240a6-1f91-8711-dc59-d8319825b5fb@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:45323 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbdJBJqL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Oct 2017 05:46:11 -0400
Received: by mail-it0-f42.google.com with SMTP id x15so6626949itb.0
        for <ceph-devel@vger.kernel.org>; Mon, 02 Oct 2017 02:46:11 -0700 (PDT)
In-Reply-To: <bc3240a6-1f91-8711-dc59-d8319825b5fb@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao@suse.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I think that is a hard security pill to swallow sending data in
plaintext over the WAN. I think there are mitm and replay attack
issues. I dont think anyone would knowingly send unencrypted file
server content across the WAN.

I think in about 15 states or so, Sarbanes Oxley laws prevents certain
personal information to be "transmitted" in the clear. You need to ask
a lawyer what that means. maybe it doesn't apply here.  This is
information HR and Finance depts typically hold. I could see that some
HR could be clueless on what their file system is doing with their
data. Also IT guys don't necessarily know corporate law. I don't know
if HIPAA or Gramm-Leach-Blilely Act would have problems. I don't think
Equifax will use Ceph.

In a federated setup, is there a way to wrap the region to region
traffic and encrypt?

On Mon, Oct 2, 2017 at 1:02 AM, Joao Eduardo Luis <joao@suse.de> wrote:
> On 10/02/2017 07:18 AM, Two Spirit wrote:
>>>
>>> The Ceph Object Gateway supports server-side encryption of uploaded
>>> objects, with 3 options for the management of encryption keys. Server-side
>>> encryption means that the data is sent over HTTP in its unencrypted form,
>>> and the Ceph Object Gateway stores that data in the Ceph Storage Cluster in
>>> encrypted form.
>>
>>
>> It sounds like OSD to OSD traffic is unencrypted.
>>
>> 1) Does "stores data in the cluster in encrypted form" mean *only* if
>> the --dmcrypt option is used?
>>
>> 2) Does that mean the zone  to zone copy across a WAN is also unencrypted?
>
>
> Ceph does not have on-the-wire encryption.
>
>   -Joao
