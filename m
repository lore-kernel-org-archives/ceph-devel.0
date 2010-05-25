From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Tue, 25 May 2010 08:17:13 -0500
Message-ID: <4BFBCDD9.4070104@codemonkey.ws>
References: <20100519192222.GD61706@ncolin.muc.de>	 <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>	 <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>	 <4BF5A9D2.5080609@codemonkey.ws> <4BF91937.2070801@redhat.com>	 <87wrutg4dk.wl%morita.kazutaka@lab.ntt.co.jp>	 <4BFA5D96.3030603@redhat.com>	 <lpvdad4jcf.wl%morita.kazutaka@lab.ntt.co.jp>	 <4BFA696D.2060606@redhat.com>	 <lphblxiele.wl%morita.kazutaka@lab.ntt.co.jp> <AANLkTilHGvaCDjeRSG3al2GOC7ts9uXGZ9DOGwBU5MEy@mail.gmail.com> <4BFAD59E.2010706@codemonkey.ws> <4BFB94D9.5080904@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f227.google.com ([209.85.217.227]:61700 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522Ab0EYNRS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 May 2010 09:17:18 -0400
In-Reply-To: <4BFB94D9.5080904@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
Cc: Christian Brunner <chb@muc.de>, MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>, Blue Swirl <blauwirbel@gmail.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

On 05/25/2010 04:14 AM, Avi Kivity wrote:
> On 05/24/2010 10:38 PM, Anthony Liguori wrote:
>>
>>> - Building a plugin API seems a bit simpler to me, although I'm to
>>> sure if I'd get the
>>>    idea correctly:
>>>    The block layer has already some kind of api (.bdrv_file_open, 
>>> .bdrv_read). We
>>>    could simply compile the block-drivers as shared objects and 
>>> create a method
>>>    for loading the necessary modules at runtime.
>>
>> That approach would be a recipe for disaster.   We would have to 
>> introduce a new, reduced functionality block API that was supported 
>> for plugins.  Otherwise, the only way a plugin could keep up with our 
>> API changes would be if it was in tree which defeats the purpose of 
>> having plugins.
>
> We could guarantee API/ABI stability in a stable branch but not across 
> releases.

We have releases every six months.  There would be tons of block plugins 
that didn't work for random sets of releases.  That creates a lot of 
user confusion and unhappiness.

Regards,

Anthony Liguori


