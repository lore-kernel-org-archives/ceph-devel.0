From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Cmake, Clang and plugins
Date: Mon, 4 Jul 2016 15:07:45 +0200
Message-ID: <4774c940-f81f-62e6-6bbf-2cf03318b0ef@digiware.nl>
References: <dca061d8-b93d-1247-1271-91409f90ca71@digiware.nl>
 <20160704125415.GA14833@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:11064 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753414AbcGDNIS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 4 Jul 2016 09:08:18 -0400
In-Reply-To: <20160704125415.GA14833@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 4-7-2016 14:54, Mykola Golub wrote:
> On Mon, Jul 04, 2016 at 01:09:15PM +0200, Willem Jan Withagen wrote:
>> Hi,
>>
>> I'm being pestered by:
>>  dlopen(/home/wjw/Ceph/work.cmake/ceph/build/lib/libec_jerasure.so):
>> /home/wjw/Ceph/work.cmake/ceph/build/lib/libec_jerasure.so: Undefined
>> symbol "ceph_arch_neon"
>> if I try to run anything that want as plugin.
>>
>> Now the question is: what extra bui;ding/linker  options would this
>> require to actually fix this?
> 
> If I recall it right, in automake it is fixed by this:
> 
> if LINUX
> liberasure_code_la_LIBADD = -ldl
> endif # LINUX

Hi Mykola,

That is actually to get the dlopen/close/.... function linked into the
parent program. But under FreeBSD these are part of libc.
Hence the fact that they are only included explicitly on Linux.

My problem is probably more on the other side:
the child plugin module is not able to satisfy all dynamic linking items.

--WjW


