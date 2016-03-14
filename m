From: Shehbaz Jaffer <shehbazjaffer007@gmail.com>
Subject: Re: [GSoC2016] BlueStore SMR Support
Date: Mon, 14 Mar 2016 12:42:22 -0400
Message-ID: <CAPLK-i_BpawhojAjWq6qCy-aEPgG-t-iT0w5tHEFrPvdvusm3A@mail.gmail.com>
References: <CAPLK-i83vpHT7CwoczKULwpvJ+-eMLdhxWUy6YwyE0wj27kiOw@mail.gmail.com>
	<alpine.DEB.2.11.1603110942520.14377@cpach.fuggernut.com>
	<CAKP7xVyMGJO-8YjkqhhFPoiY_608ByKY8+c_Y=7W-tcmDBADsg@mail.gmail.com>
	<alpine.DEB.2.11.1603140816560.14377@cpach.fuggernut.com>
	<CAKP7xVzKuwy9sP2PqJ-sHT0cygj6byuVX62=oUgnVCNpjWaE9A@mail.gmail.com>
	<56E6BB02.6030801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35957 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbcCNQmX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Mar 2016 12:42:23 -0400
Received: by mail-yw0-f175.google.com with SMTP id g3so174590995ywa.3
        for <ceph-devel@vger.kernel.org>; Mon, 14 Mar 2016 09:42:23 -0700 (PDT)
In-Reply-To: <56E6BB02.6030801@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ric Wheeler <rwheeler@redhat.com>
Cc: Giridhar Yasa <giridhar.yasa@flipkart.com>, Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

Sorry for the late reply.

>>>> Would that be https://github.com/hgst/libzbc from HGST?

Thanks Giridhar for the link.

Hi Rick,

> Just keep in mind that different vendors have different behaviors - you will
> need to tweak it I assume to make it act like the drive you are interested
> in.

There is a T10 and T13 standardization for interfaces (ZBC and ZAC
standard). libzbc also follows these standards. From libzbc README

"libzbc implemention is compliant with the latest drafts of
the ZBC and ZAC standards defined by INCITS technical committee T10 and
T13 (respectively)."

I plan to keep the scope of the project such that the allocator will
interact with the libzbc interface in emulated mode which is T10 and
T13 standard compliant. Once the allocator works on libzbc emulated
mode, it can run on disks that support ZBC/ZAC commands. Again from
README.

"In addition to supporting ZBC and ZAC disks, libzbc also implements an
emulation mode allowing emulating the behavior of a host-managed zoned
disks using a regular file or a raw standard block device as backing
storage."

 Is there any other vendor specific behaviour that I should consider?

Thanks,
Shehbaz

On Mon, Mar 14, 2016 at 9:22 AM, Ric Wheeler <rwheeler@redhat.com> wrote:
> On 03/14/2016 08:33 AM, Giridhar Yasa wrote:
>>
>> On Mon, Mar 14, 2016 at 5:47 PM, Sage Weil <sweil@redhat.com> wrote:
>>>
>>> On Sun, 13 Mar 2016, Giridhar Yasa wrote:
>>>>
>>>> On Fri, Mar 11, 2016 at 8:20 PM, Sage Weil <sweil@redhat.com> wrote:
>>>>>
>>>>> On Fri, 4 Mar 2016, Shehbaz Jaffer wrote:
>>>>>
>>>>>> 2) Will scope of project be to build an allocator on a simulator for
>>>>>> SMR Drives? Or will I get actual HDDs to work with? In case of
>>>>>> simulators, will the project involve building a simulator on disksim?
>>>>>
>>>>> I seem to remember hearing something about a dm module that simulated
>>>>> SMR,
>>>>> but I'm not sure.  We may also be able to get some SMR disks to play
>>>>> with--I'll reach out to our drive vendor friends.
>>>>
>>>> Would that be https://github.com/hgst/libzbc from HGST?
>>>
>>> Yes.
>>>
>>> I'm not sure about a disk simulator or actual drive availability,
>>> though.
>>
>> libzbc has an emulation mode that can use files or block devices to
>> emulate SMR disk zones.
>>
>> Giridhar
>>
>
> Just keep in mind that different vendors have different behaviors - you will
> need to tweak it I assume to make it act like the drive you are interested
> in.
>
> Regards,
>
> Ric
>



-- 
Shehbaz Jaffer
First Year Graduate Student
Sir Edward S Rogers Sr Department of Electrical and Computer Engineering
University of Toronto
