From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 08:29:42 -0500
Message-ID: <4BFBD0C6.9000105@codemonkey.ws>
References: <20100519192222.GD61706@ncolin.muc.de>	 <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	 <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	 <4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com>	 <87wrutg4dk.wl%morita.kazutaka@lab.ntt.co.jp>	 <4BFA5D96.3030603@redhat.com>	 <lpvdad4jcf.wl%morita.kazutaka@lab.ntt.co.jp>	 <4BFA696D.2060606@redhat.com>	 <lphblxiele.wl%morita.kazutaka@lab.ntt.co.jp> <AANLkTilHGvaCDjeRSG3al2GOC7ts9uXGZ9DOGwBU5MEy@mail.gmail.com> <4BFAD59E.2010706@codemonkey.ws> <4BFB94D9.5080904@redhat.com> <4BFBCDD9.4070104@codemonkey.ws> <4BFBCFB9.6020104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44297 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756573Ab0EYN3r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 May 2010 09:29:47 -0400
In-Reply-To: <4BFBCFB9.6020104@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Christian Brunner <chb@muc.de>, MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>, Blue Swirl <blauwirbel@gmail.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

On 05/25/2010 08:25 AM, Avi Kivity wrote:
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
>>>> our API changes would be if it was in tree which defeats the 
>>>> purpose of having plugins.
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
>
> Confusion could be mitigated:
>
>   $ qemu -module my-fancy-block-format-driver.so
>   my-fancy-block-format-driver.so does not support this version of 
> qemu (0.19.2).  Please contact 
> my-fancy-block-format-driver-devel@example.org.
>
> The question is how many such block format drivers we expect.  We now 
> have two in the pipeline (ceph, sheepdog), it's reasonable to assume 
> we'll want an lvm2 driver and btrfs driver.  This is an area with a 
> lot of activity and a relatively simply interface.

If we expose a simple interface, I'm all for it.  But BlockDriver is not 
simple and things like the snapshoting API need love.

Of course, there's certainly a question of why we're solving this in 
qemu at all.  Wouldn't it be more appropriate to either (1) implement a 
kernel module for ceph/sheepdog if performance matters or (2) implement 
BUSE to complement FUSE and CUSE to enable proper userspace block devices.

If you want to use a block device within qemu, you almost certainly want 
to be able to manipulate it on the host using standard tools (like mount 
and parted) so it stands to reason that addressing this in the kernel 
makes more sense.

Regards,

Anthony Liguori

