From: Henrik Korkuc <lists@kirneh.eu>
Subject: Re: Memory. 100TB OSD?
Date: Mon, 4 Sep 2017 09:06:31 +0300
Message-ID: <25ffedbc-a7d3-2aaf-cfa6-10c303ab0c9b@kirneh.eu>
References: <CAKRxpuv33KwzAjCu57OjFUVLCY2+t2iHT9mURitXbs1qJOM3DQ@mail.gmail.com>
 <CAE_BDM+kHRr1SnaLcfqYuB9rGSQAvR65aeXc9O7ny4=cJ18w7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from alpha.syseng.pro ([37.48.90.241]:41610 "EHLO alpha.syseng.pro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbdIDGGj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 4 Sep 2017 02:06:39 -0400
In-Reply-To: <CAE_BDM+kHRr1SnaLcfqYuB9rGSQAvR65aeXc9O7ny4=cJ18w7w@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Wuerdig <christian.wuerdig@gmail.com>, Two Spirit <twospirit6905@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Just to add a data point - I run Luminous in one of the clusters with 
~400 OSDs. Servers have 48GB RAM and 12 OSDs. After some use I got 
"rolling" OOMs on them.
I decreased blustore cache to 512MB, currently situation seems to be fine.

So OSD can consume up to 4GB or more of RAM per OSD. 
bluestore_cache_size_* is a way to control that, also take a look at 
this recent blog post - 
https://ceph.com/community/new-luminous-bluestore/, it has a section 
about memory consumption too.

As for RAID array - go for multiple OSDs per server. This way you'll 
avoid OSD bottleneck and also in case of one disk failure you'll need to 
resync up to 10TB, not 100TB.

On 17-09-04 02:39, Christian Wuerdig wrote:
> Generally the memory requirements are for ceph itself - the rest of
> the system will also require some RAM, so you should probably add a
> 1GB basic footprint anyway. Plus the memory recommendations are more
> general guidelines which often are more applicable to systems with
> more OSDs for averaging the need between individual OSD processes. So
> your basic footprint would probably be more like 4GB RAM for a small
> OSD node. At least on my hacked together home toy cluster all nodes
> run 4GB RAM and haven't been OOMed yet, although it's still running
> Jewel so not sure if Luminous will have a massive impact.
>
> Regarding the OSD size - more OSDs are generally better since access
> to a single OSD is generally sequential AFAIK (OPs are queued per
> OSD). Some people do run RAID backed OSDs but not of that size.
> With Luminous it's not quite clear to me if it's RAM GB/OSD or still
> GB/TB or something in between.
>
> On Thu, Aug 31, 2017 at 5:30 AM, Two Spirit <twospirit6905@gmail.com> wrote:
>> I've been seeing luminous OSD spit out error messages about out of
>> memory even tho I was within the minimum memory requirements
>> documented. 2GB with 2TB. I've also tested with 1.5TB, 1TB, and 500GB
>> configurations.
>>
>> I've got 100TB single chassis file servers in production. Does this
>> mean that to run an OSD on them I need 100GB RAM?
>>
>> And am I supose to run 1 daemon per 10T disk or since I've go the
>> disks in a RAID, can I run 1 daemon for the whole of the 100TB
>> RAID?<div id="DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2"><br />
>> <table style="border-top: 1px solid #D3D4DE;">
>>          <tr>
>>          <td style="width: 55px; padding-top: 13px;"><a
>> href="http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail"
>> target="_blank"><img
>> src="https://ipmcdn.avast.com/images/icons/icon-envelope-tick-green-avg-v1.png"
>> alt="" width="46" height="29" style="width: 46px; height: 29px;"
>> /></a></td>
>>                  <td style="width: 470px; padding-top: 12px; color: #41424e;
>> font-size: 13px; font-family: Arial, Helvetica, sans-serif;
>> line-height: 18px;">Virus-free. <a
>> href="http://www.avg.com/email-signature?utm_medium=email&utm_source=link&utm_campaign=sig-email&utm_content=webmail"
>> target="_blank" style="color: #4453ea;">www.avg.com</a>
>>                  </td>
>>          </tr>
>> </table><a href="#DAB4FAD8-2DD7-40BB-A1B8-4E2AA1F9FDF2" width="1"
>> height="1"></a></div>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


