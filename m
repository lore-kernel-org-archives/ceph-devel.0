From: Two Spirit <twospirit6905@gmail.com>
Subject: Re: Memory. 100TB OSD?
Date: Tue, 12 Sep 2017 11:58:31 -0700
Message-ID: <CAKRxpuvwUBPvVRPdofuOS1YFfnDr11vyGbVEo7170joyUT85Kg@mail.gmail.com>
References: <CAKRxpuv33KwzAjCu57OjFUVLCY2+t2iHT9mURitXbs1qJOM3DQ@mail.gmail.com>
 <CAE_BDM+kHRr1SnaLcfqYuB9rGSQAvR65aeXc9O7ny4=cJ18w7w@mail.gmail.com> <25ffedbc-a7d3-2aaf-cfa6-10c303ab0c9b@kirneh.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:46148 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbdILS6d (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Sep 2017 14:58:33 -0400
Received: by mail-it0-f46.google.com with SMTP id 6so771098itl.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 Sep 2017 11:58:32 -0700 (PDT)
In-Reply-To: <25ffedbc-a7d3-2aaf-cfa6-10c303ab0c9b@kirneh.eu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henrik Korkuc <lists@kirneh.eu>
Cc: Christian Wuerdig <christian.wuerdig@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

>As for RAID array - go for multiple OSDs per server. This way you'll avoid OSD bottleneck and also in case of one disk failure you'll need to resync up to 10TB, not 100TB.

Good point on the resync, but I'm using a proprietary solution that
balances the resync to portions of the RAID as well as gives 3 of 12
disks for redundancy.

I started with 1 OSD per server thinking it was the optimal
configuration, but I can see now that multiple OSDs per server could
parallelize disk access (I'm assuming I need to tell CRUSH somehow  to
get those benefits). Since I've got servers with 14 disk, and the
newer servers are 24 disks, should I maximize the OSDs per server? or
is there a balance where too many is not good either? I'm assuming
multiple OSDs per disk is also bad. Since you are using 4GB per OSD. I
assume the memory is the ultimate limiting factor in how many OSDs I
should run per server?

I'm using 2GB/OSD, and I've seen OOM problems on Luminous. I do wish
the OSDs were less memory hungry.


On Sun, Sep 3, 2017 at 11:06 PM, Henrik Korkuc <lists@kirneh.eu> wrote:
> Just to add a data point - I run Luminous in one of the clusters with ~400
> OSDs. Servers have 48GB RAM and 12 OSDs. After some use I got "rolling" OOMs
> on them.
> I decreased blustore cache to 512MB, currently situation seems to be fine.
>
> So OSD can consume up to 4GB or more of RAM per OSD. bluestore_cache_size_*
> is a way to control that, also take a look at this recent blog post -
> https://ceph.com/community/new-luminous-bluestore/, it has a section about
> memory consumption too.
>
> As for RAID array - go for multiple OSDs per server. This way you'll avoid
> OSD bottleneck and also in case of one disk failure you'll need to resync up
> to 10TB, not 100TB.
>
>
> On 17-09-04 02:39, Christian Wuerdig wrote:
>>
>> Generally the memory requirements are for ceph itself - the rest of
>> the system will also require some RAM, so you should probably add a
>> 1GB basic footprint anyway. Plus the memory recommendations are more
>> general guidelines which often are more applicable to systems with
>> more OSDs for averaging the need between individual OSD processes. So
>> your basic footprint would probably be more like 4GB RAM for a small
>> OSD node. At least on my hacked together home toy cluster all nodes
>> run 4GB RAM and haven't been OOMed yet, although it's still running
>> Jewel so not sure if Luminous will have a massive impact.
>>
>> Regarding the OSD size - more OSDs are generally better since access
>> to a single OSD is generally sequential AFAIK (OPs are queued per
>> OSD). Some people do run RAID backed OSDs but not of that size.
>> With Luminous it's not quite clear to me if it's RAM GB/OSD or still
>> GB/TB or something in between.
>>
>> On Thu, Aug 31, 2017 at 5:30 AM, Two Spirit <twospirit6905@gmail.com>
>> wrote:
>>>
>>> I've been seeing luminous OSD spit out error messages about out of
>>> memory even tho I was within the minimum memory requirements
>>> documented. 2GB with 2TB. I've also tested with 1.5TB, 1TB, and 500GB
>>> configurations.
>>>
>>> I've got 100TB single chassis file servers in production. Does this
>>> mean that to run an OSD on them I need 100GB RAM?
>>>
>>> And am I supose to run 1 daemon per 10T disk or since I've go the
>>> disks in a RAID, can I run 1 daemon for the whole of the 100TB
>>> RAID?<div id="DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2"><br />
>>> <table style="border-top: 1px solid #D3D4DE;">
>>>          <tr>
>>>          <td style="width: 55px; padding-top: 13px;"><a
>>>
>>> href="http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail"
>>> target="_blank"><img
>>>
>>> src="https://ipmcdn.avast.com/images/icons/icon-envelope-tick-green-avg-v1.png"
>>> alt="" width="46" height="29" style="width: 46px; height: 29px;"
>>> /></a></td>
>>>                  <td style="width: 470px; padding-top: 12px; color:
>>> #41424e;
>>> font-size: 13px; font-family: Arial, Helvetica, sans-serif;
>>> line-height: 18px;">Virus-free. <a
>>>
>>> href="http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail"
>>> target="_blank" style="color: #4453ea;">www.avg.com</a>
>>>                  </td>
>>>          </tr>
>>> </table><a href="#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2" width="1"
>>> height="1"></a></div>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
