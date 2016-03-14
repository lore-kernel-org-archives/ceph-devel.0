From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: [GSoC2016] BlueStore SMR Support
Date: Mon, 14 Mar 2016 13:27:39 -0400
Message-ID: <56E6F48B.8000301@redhat.com>
References: <CAPLK-i83vpHT7CwoczKULwpvJ+-eMLdhxWUy6YwyE0wj27kiOw@mail.gmail.com>
 <alpine.DEB.2.11.1603110942520.14377@cpach.fuggernut.com>
 <CAKP7xVyMGJO-8YjkqhhFPoiY_608ByKY8+c_Y=7W-tcmDBADsg@mail.gmail.com>
 <alpine.DEB.2.11.1603140816560.14377@cpach.fuggernut.com>
 <CAKP7xVzKuwy9sP2PqJ-sHT0cygj6byuVX62=oUgnVCNpjWaE9A@mail.gmail.com>
 <56E6BB02.6030801@redhat.com>
 <CAPLK-i_BpawhojAjWq6qCy-aEPgG-t-iT0w5tHEFrPvdvusm3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35337 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941AbcCNR2h (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Mar 2016 13:28:37 -0400
In-Reply-To: <CAPLK-i_BpawhojAjWq6qCy-aEPgG-t-iT0w5tHEFrPvdvusm3A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shehbaz Jaffer <shehbazjaffer007@gmail.com>
Cc: Giridhar Yasa <giridhar.yasa@flipkart.com>, Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 03/14/2016 12:42 PM, Shehbaz Jaffer wrote:
> Sorry for the late reply.
>
>>>>> Would that be https://github.com/hgst/libzbc from HGST?
> Thanks Giridhar for the link.
>
> Hi Rick,
>
>> Just keep in mind that different vendors have different behaviors - you will
>> need to tweak it I assume to make it act like the drive you are interested
>> in.
> There is a T10 and T13 standardization for interfaces (ZBC and ZAC
> standard). libzbc also follows these standards. From libzbc README
>
> "libzbc implemention is compliant with the latest drafts of
> the ZBC and ZAC standards defined by INCITS technical committee T10 and
> T13 (respectively)."
>
> I plan to keep the scope of the project such that the allocator will
> interact with the libzbc interface in emulated mode which is T10 and
> T13 standard compliant. Once the allocator works on libzbc emulated
> mode, it can run on disks that support ZBC/ZAC commands. Again from
> README.
>
> "In addition to supporting ZBC and ZAC disks, libzbc also implements an
> emulation mode allowing emulating the behavior of a host-managed zoned
> disks using a regular file or a raw standard block device as backing
> storage."
>
>   Is there any other vendor specific behaviour that I should consider?
>
> Thanks,
> Shehbaz
>
>

I think that following the spec is the right way to go. Last time we did a meet 
up with all of the various SMR vendors, they still had a lot of differences in 
how the devices actually worked though (number of zones, how to reset a zone, etc).

If the spec process works thought, this should all hopefully converge :)

Ric

