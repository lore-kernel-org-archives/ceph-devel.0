From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Ideal hardware spec?
Date: Sun, 26 Aug 2012 13:15:58 +0200
Message-ID: <503A056E.2020804@widodh.nl>
References: <20120822135530.GB10015@csail.mit.edu> <5034E9F3.10001@widodh.nl> <20120822154615.GF10015@csail.mit.edu> <5035FF18.3030209@widodh.nl> <CABYiri_-73UyTKHcHWDZdjqb=rozjraVzxd166NZV2ir53tduA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:47194 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505Ab2HZLPy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Aug 2012 07:15:54 -0400
In-Reply-To: <CABYiri_-73UyTKHcHWDZdjqb=rozjraVzxd166NZV2ir53tduA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

CC'ing this one back to the list.

On 08/25/2012 09:58 PM, Andrey Korolyov wrote:
>>
>> They should be much more reliable than regular USB sticks due to their SLC
>> memory.
>>
>> You could also take a look at these:
>> http://www.transcend-info.com/industry/products_details.asp?CatNo=2&SerNo=14&ModNo=28&Func1No=1
>>
>>
>
> Did you tried yet those or simular sticks for CEPH journal? Right now
> I am using Intel 313`s, which is very fast and have durability/price
> ratio a far higher than any imaginable MLC, but they occupying one HDD
> slot which is a quite impractical.
>

No, I haven't tried, but I think it won't work.

These kind of SLC chips don't do random writes that great, you'll 
probably get something like 4MB/sec in random writes.

Bigger SSDs have more cells to spread the writes over, those small 
sticks don't.

The Intel 3XX or 5XX serie should work just fine for journaling, I'd 
however recommend you change the Host Protected Area to ~50% of the 
available capacity to prevent write-degradation over time.

Wido
