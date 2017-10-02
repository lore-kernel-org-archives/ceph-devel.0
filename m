From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: Write to Secondary Zone?
Date: Mon, 2 Oct 2017 13:26:02 +0300
Message-ID: <CABo9giTFmZbsqNBN4AqooUh6WniDiZkqu5ZC7D=Oh61DzzbF3w@mail.gmail.com>
References: <CAKRxpuv1CtoEJHhsp3tk3Az1PrWZ3bP9kOT_fiAOmXutzPsXrw@mail.gmail.com>
 <CABo9giQt1SUNeg4PPgAthrUtAwvTGsuTeVuN_Odx9jgPHCL9Fg@mail.gmail.com>
 <CAKRxpuu9frAA-o=eRh5M5V7EVsy=n5TUd_GXL1q3gMdRcDuw7A@mail.gmail.com> <CABo9giRKrm48-dXrQ4=mkq4Ub1_Po8xTM_8LJHytBBQGjC2muA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:48390 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbdJBK0D (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Oct 2017 06:26:03 -0400
Received: by mail-qk0-f169.google.com with SMTP id d67so1267697qkg.5
        for <ceph-devel@vger.kernel.org>; Mon, 02 Oct 2017 03:26:03 -0700 (PDT)
In-Reply-To: <CABo9giRKrm48-dXrQ4=mkq4Ub1_Po8xTM_8LJHytBBQGjC2muA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Oct 2, 2017 at 1:25 PM, Orit Wasserman <owasserm@redhat.com> wrote:
> + ceph-devel
>
> On Mon, Oct 2, 2017 at 1:18 PM, Two Spirit <twospirit6905@gmail.com> wrote:
>>>Yes. This is zone to zone sync in RGW.
>>>RGW geo replication was designed speciflicly to handle slow WAN link.
>>>
>>>For more details see:
>>
>> Thanks for the links. I'll look them over.
>>
>>>Each zone is a complete and separates Ceph cluster.
>> The diagram in the documentation shows 3 monitors in a single Ceph
>> cluster when replicating zone to zone so that is what is confusing.
>> The diagram makes one think there is a single ceph cluster for US-West
>> and US-East.
>>
>> My understanding is that for each separate Ceph cluster, mons
>> determine quorum for their individual cluster, so the diagram should
>> show 2 sets of 3 mons.
>>

correct!

>> On Mon, Oct 2, 2017 at 3:09 AM, Orit Wasserman <owasserm@redhat.com> wrote:
>>> On Fri, Sep 29, 2017 at 6:41 PM, Two Spirit <twospirit6905@gmail.com> wrote:
>>>> Is it now supported to be able to write to a secondary zone without problems?
>>>>
>>>
>>> yes from Jewel.
>>>
>>>> If not supported, is there a timeframe that this (being able to write
>>>> to secondary zones) would be supported?
>>>>
>>>> It also looks like the federated solution does not scale well with
>>>> multi region all in sync.
>>>>
>>>
>>> We moved to a new implementation in Jewel (because of problems with
>>> the old federated solution).
>>> Region is  now called zonegroup to avoid confusion with AWS region.
>>> A zone in RGW is like an AWS region.
>>>
>>>> Is there support in Ceph for region-to-region syncing. Based on the
>>>> figure in the documentation, it appears that zone to zone syncing does
>>>> not happen across a slow wan link (as there are 3 MONs in the backend,
>>>> and unified Ceph cluster is not recommended across a WAN)
>>>
>>> Yes. This is zone to zone sync in RGW.
>>> RGW geo replication was designed speciflicly to handle slow WAN link.
>>> Each zone is a complete and separates Ceph cluster.
>>>
>>> For more details see:
>>> http://docs.ceph.com/docs/master/radosgw/multisite/
>>> http://events.linuxfoundation.org/sites/events/files/slides/Linuxcon_multisitev2.pdf
>>>
>>> Regards,
>>> Orit
>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
