From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: SMART disk monitoring
Date: Tue, 14 Nov 2017 09:28:10 +0100
Message-ID: <096024a3-7aea-5f07-b915-ed35fc867cf9@corp.ovh.com>
References: <alpine.DEB.2.11.1711101751430.2819@piezo.novalocal>
 <207642670.33700582.1510357519950.JavaMail.zimbra@redhat.com>
 <CAP6jbrTOujE+DrsgAnne16zLaXubKUZzyn_rpF5FD1ubBTycPw@mail.gmail.com>
 <20171112171653.q7dn7bw52ijltb3q@suse.com>
 <alpine.DEB.2.11.1711122003420.23234@piezo.novalocal>
 <3ac76cc3-92f2-5180-4389-c5334506fac4@corp.ovh.com>
 <ce55d8a4-040f-e107-9d86-0b3f2456988d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 10.mo301.mail-out.ovh.net ([137.74.110.73]:37898 "EHLO
        10.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752729AbdKNI2O (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Nov 2017 03:28:14 -0500
In-Reply-To: <ce55d8a4-040f-e107-9d86-0b3f2456988d@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ric Wheeler <rwheeler@redhat.com>, Sage Weil <sage@newdream.net>, Lars Marowsky-Bree <lmb@suse.com>
Cc: ceph-devel@vger.kernel.org

On 17-11-14 05:09 AM, Ric Wheeler wrote:
> On 11/13/2017 05:23 PM, Piotr Dałek wrote:
>> On 17-11-12 09:16 PM, Sage Weil wrote:
>>> On Sun, 12 Nov 2017, Lars Marowsky-Bree wrote:
>>>> On 2017-11-10T22:36:46, Yaarit Hatuka <yaarit@gmail.com> wrote:
>>>>
>>>>> Many thanks! I'm very excited to join Ceph's outstanding community!
>>>>> I'm looking forward to working on this challenging project, and I'm
>>>>> very grateful for the opportunity to be guided by Sage.
>>>>
>>>> That's all excellent news!
>>>>
>>>> Can we discuss though if/how this belongs into ceph-osd? Given that this
>>>> can (and is) already collected via smartmon, either via prometheus or, I
>>>> assume, collectd as well? Does this really need to be added to the OSD
>>>> code?
>>>>
>>>> Would the goal be for them to report this to ceph-mgr, or expose
>>>> directly as something to be queried via, say, a prometheus exporter
>>>> binding? Or are the OSDs supposed to directly act on this information?
>>>
>>> The OSD is just a convenient channel, but needn't be the only
>>> one or only option.
>>>
>>> Part 1 of the project is to get JSON output out of smartctl so we avoid
>>> one of the many crufty projects floating around to parse its weird output;
>>> that'll be helpful all consumers, presumably.
>>
>> That means a new patch to smartctl itself, right?
>>
>>> Part 2 is to map OSDs to host:device pairs; that merged already.
>>>
>>> Part 3 is to gather the actual data.  The prototype has the OSD polling
>>> this because it (1) knows which devices it consumes and (2) is present on
>>> every node.  We're contemplating a per-host ceph-volume-agent for
>>> assisting with OSD (de)provisioning (i.e., running ceph-volume); that
>>> could be an option.  Of if some other tool is already scraping it and can
>>> be queried, that would work too.
>>>
>>> I think the OSD will end up being a necessary path (perhaps among many),
>>> though, because when we are using SPDK I don't think we'll be able to get
>>> the SMART data via smartctl (or any other tool) at all because the OSD
>>> process will be running the NVMe driver.
>>
>> This may not work anyway, because  many controllers (including JBOD 
>> controllers) don't pass-through SMART data, or the data don't make sense.
> 
> You are right that many controllers don't pass this information without 
> going through their non-open source tools. The libstoragemgmt project - 
> https://github.com/libstorage/libstoragemgmt - has added support for doing 
> some types of access for the physical back end drives. It is worth syncing 
> up with them I think to see how we might be able to extract interesting bits.

There's another problem - bcache/flashcache/<insert your favorite vendor> 
cache - osds often reside on top of some cache device, and accessing SMART 
values for that might not work, or might not return all required values.

>>> Part 4 is to archive the results.  The original thought was to dump it
>>> into RADOS.  I hadn't considered prometheus, but that might be a better
>>> fit!  I'm generally pretty cautious about introducing dependencies like
>>> this but we're already expecting prometheus to be used for other metrics
>>> for the dashboard.  I'm not sure whether prometheus' query interface lends
>>> itself to the failure models, though...
>>> Part 5 is to do some basic failure prediction!
>>
>> SMART is unreliable on spinning disks, and on SSDs it's only as reliable 
>> as firmware goes (and that is often questionable).
>> Also, many vendors give different meaning to different SMART attributes, 
>> making some of obvious choices (like power-on hours or power-cycle count) 
>> useless (see https://www.backblaze.com/blog/hard-drive-smart-stats/ for 
>> example).
> 
> SMART data has been used selectively by major storage vendors for years to 
> help flag errors. For spinning drives, one traditional red flag was the 
> number of reallocated sectors (normalized by the number a spinning drive 
> has). When you start chewing through those, that is a pretty good flag. 

This value increases when platters are worn out, get somehow demagnetized or 
disk vibrates too much. Still doesn't take motor wear into account.

> Seagate and others did a lot of work (and models) that turned smart data 
> into a good predictor for failure on spinning drives, but it is not entirely 
> trivial to do.
> 
> For example, at the USENIX Vault conference, there was this presentation 
> which showed some interesting recent work:
> 
> http://sched.co/9WQT
> 
> There is also a lot of information about drive failures (SSD and spinning) 
> at USENIX FAST over many years. Things have improved a lot over the years, 
> especially with modern SSD's and NVME where a lot of hard work has happened 
> to add improved metrics to the data.

That's my point. That's a lot of statistics to chew through and most of it 
relies on assumptions that can be already wrong or be wrong some time after. 
All it takes is a brand-new product line with different characteristics.
SSDs are different - you just measure number of erase/program cycles and 
(again) do assumptions based on that - that's easier and more reliable.
Still, I would be *very* unhappy if I'd be woken up in the middle of the 
night just to realize that cluster incorrectly predicted disk failure and my 
company (and I'm pretty sure not only my company) wouldn't be happy either 
if cluster would force it to throw away perfectly good disks, because 
reusing them would yield the same result.
On the other hand, this creates a back door for vendors to force device 
replacement even if it's perfectly fine, some SSD vendors already do this 
with their devices going into read-only mode even when there's a whole lot 
of p/e cycles left in flash cells. I don't think we need Ceph to go this way.

tl;dr - I'm fine with that feature as long as there'll be a possibility to 
disable it entirely.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
