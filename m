From: Matt Weil <mweil@genome.wustl.edu>
Subject: Re: Linux large IO size.
Date: Fri, 13 Jul 2012 16:32:17 -0500
Message-ID: <500093E1.3000901@genome.wustl.edu>
References: <500071F8.7050206@genome.wustl.edu> <CADvuQRFmFX2aPMThmhc3T8j-bR8PBu9JY1cxyg9CbzAp6OUU4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from gscsmtp.wustl.edu ([128.252.233.26]:54645 "HELO
	gscsmtp.wustl.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754445Ab2GMVcS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jul 2012 17:32:18 -0400
In-Reply-To: <CADvuQRFmFX2aPMThmhc3T8j-bR8PBu9JY1cxyg9CbzAp6OUU4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 7/13/12 3:02 PM, Tommi Virtanen wrote:
> On Fri, Jul 13, 2012 at 12:07 PM, Matt Weil <mweil@genome.wustl.edu> wrote:
>> Is it possible to get IO sizes 1024k and larger?
>
> Can you be a bit more explicit in what you're asking?
>
> Are you talking about submitting IO to RBD (via the kernel module?
> inside a qemu vm?), are you talking about using the Ceph Distributed
> File System, or are you talking about the IO ceph-osd submits to the
> physical disk?
>

I think it is related. But this may not be the right list.

in 3.2 kernel with ext4 you can create file systems with a larger then 
4k block size.

When a file system is created with a 1024k block size something is 
limiting the IO size to 512k.

I was wondering if any one has stumbled on this and if so how did they 
got kernel to use a larger IO size.
