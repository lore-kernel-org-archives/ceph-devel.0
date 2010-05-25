From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 16:01:23 +0200
Message-ID: <4BFBD833.1030503@redhat.com>
References: <20100519192222.GD61706@ncolin.muc.de>		<AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>		<AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>		<4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com>		<87wrutg4dk.wl%morita.kazutaka@lab.ntt.co.jp>		<4BFA5D96.3030603@redhat.com>		<lpvdad4jcf.wl%morita.kazutaka@lab.ntt.co.jp>		<4BFA696D.2060606@redhat.com>		<lphblxiele.wl%morita.kazutaka@lab.ntt.co.jp>	<AANLkTilHGvaCDjeRSG3al2GOC7ts9uXGZ9DOGwBU5MEy@mail.gmail.com>	<4BFAD59E.2010706@codemonkey.ws> <4BFB94D9.5080904@redhat.com>	<4BFBCDD9.4070104@codemonkey.ws> <4BFBCFB9.6020104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3850 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756411Ab0EYOB4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 25 May 2010 10:01:56 -0400
In-Reply-To: <4BFBCFB9.6020104@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, qemu-devel@nongnu.org, Blue Swirl <blauwirbel@gmail.com>, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>, MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>

Am 25.05.2010 15:25, schrieb Avi Kivity:
> On 05/25/2010 04:17 PM, Anthony Liguori wrote:
>> On 05/25/2010 04:14 AM, Avi Kivity wrote:
>>> On 05/24/2010 10:38 PM, Anthony Liguori wrote:
>>>>
>>>>> - Building a plugin API seems a bit simpler to me, although I'm to
>>>>> sure if I'd get the
>>>>>    idea correctly:
>>>>>    The block layer has already some kind of api (.bdrv_file_open, 
>>>>> .bdrv_read). We
>>>>>    could simply compile the block-drivers as shared objects and 
>>>>> create a method
>>>>>    for loading the necessary modules at runtime.
>>>>
>>>> That approach would be a recipe for disaster.   We would have to 
>>>> introduce a new, reduced functionality block API that was supported 
>>>> for plugins.  Otherwise, the only way a plugin could keep up with 
>>>> our API changes would be if it was in tree which defeats the purpose 
>>>> of having plugins.
>>>
>>> We could guarantee API/ABI stability in a stable branch but not 
>>> across releases.
>>
>> We have releases every six months.  There would be tons of block 
>> plugins that didn't work for random sets of releases.  That creates a 
>> lot of user confusion and unhappiness.
> 
> The current situation is that those block format drivers only exist in 
> qemu.git or as patches.  Surely that's even more unhappiness.

The difference is that in the current situation these drivers will be
part of the next qemu release, so the patch may be obsolete, but you
don't even need it any more.

If you start keeping block drivers outside qemu and not even try
integrating them, they'll stay external.

> Confusion could be mitigated:
> 
>    $ qemu -module my-fancy-block-format-driver.so
>    my-fancy-block-format-driver.so does not support this version of qemu 
> (0.19.2).  Please contact my-fancy-block-format-driver-devel@example.org.
> 
> The question is how many such block format drivers we expect.  We now 
> have two in the pipeline (ceph, sheepdog), it's reasonable to assume 
> we'll want an lvm2 driver and btrfs driver.  This is an area with a lot 
> of activity and a relatively simply interface.

What's the reason for not having these drivers upstream? Do we gain
anything by hiding them from our users and requiring them to install the
drivers separately from somewhere else?

Kevin
