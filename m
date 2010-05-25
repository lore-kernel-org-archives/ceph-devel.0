From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 09:02:53 -0500
Message-ID: <4BFBD88D.9090002@codemonkey.ws>
References: <20100519192222.GD61706@ncolin.muc.de>	 <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	 <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	 <4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com>	 <87wrutg4dk.wl%morita.kazutaka@lab.ntt.co.jp>	 <4BFA5D96.3030603@redhat.com>	 <lpvdad4jcf.wl%morita.kazutaka@lab.ntt.co.jp>	 <4BFA696D.2060606@redhat.com>	 <lphblxiele.wl%morita.kazutaka@lab.ntt.co.jp> <AANLkTilHGvaCDjeRSG3al2GOC7ts9uXGZ9DOGwBU5MEy@mail.gmail.com> <4BFAD59E.2010706@codemonkey.ws> <4BFB94D9.5080904@redhat.com> <4BFBCDD9.4070104@codemonkey.ws> <4BFBCFB9.6020104@redhat.com> <4BFBD0C6.9000105@codemonkey.ws> <4BFBD261.9040908@redhat.com> <4BFBD693.2030108@codemonkey.ws> <4BFBD759.40601@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49339 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932653Ab0EYOC5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 May 2010 10:02:57 -0400
In-Reply-To: <4BFBD759.40601@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Christian Brunner <chb@muc.de>, MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>, Blue Swirl <blauwirbel@gmail.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

On 05/25/2010 08:57 AM, Avi Kivity wrote:
> On 05/25/2010 04:54 PM, Anthony Liguori wrote:
>> On 05/25/2010 08:36 AM, Avi Kivity wrote:
>>>
>>> We'd need a kernel-level generic snapshot API for this eventually.
>>>
>>>> or (2) implement BUSE to complement FUSE and CUSE to enable proper 
>>>> userspace block devices.
>>>
>>> Likely slow due do lots of copying.  Also needs a snapshot API.
>>
>> The kernel could use splice.
>
> Still can't make guest memory appear in (A)BUSE process memory without 
> either mmu tricks (vmsplice in reverse) or a copy.  May be workable 
> for an (A)BUSE driver that talks over a network, and thus can splice() 
> its way out.

splice() actually takes offset parameter so it may be possible to treat 
that offset parameter as a file offset.  That would essentially allow 
you to implement a splice() based thread pool where splice() replaces 
preadv/pwritev.

It's not quite linux-aio, but it should take you pretty far.   I think 
the main point is that the problem of allowing block plugins to qemu is 
the same as block plugins for the kernel.  The kernel doesn't provide a 
stable interface (and we probably can't for the same reasons) and it's 
generally discourage from a code quality perspective.

That said, making an external program work well as a block backend is 
identical to making userspace block devices fast.

Regards,

Anthony Liguori

