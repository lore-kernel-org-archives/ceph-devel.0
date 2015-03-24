From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: keyvaluestore speed up?
Date: Tue, 24 Mar 2015 20:33:23 +1300
Message-ID: <55111343.4010504@catalyst.net.nz>
References: <CANE=7sUygGz67i-H+5v+ZmuwR4W9RuGzsWX6yhvJ=O9LKsyCSA@mail.gmail.com>	<75674D092A819E4189E91166C74CB90D0150C211@shsmsx102.ccr.corp.intel.com> <CALZt5jz=Sc1x3a4B5-aA6PdTeb7jtgTm6hJ=xR0H1jY7Tj1R4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:58636 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbbCXHd0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Mar 2015 03:33:26 -0400
In-Reply-To: <CALZt5jz=Sc1x3a4B5-aA6PdTeb7jtgTm6hJ=xR0H1jY7Tj1R4A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>, "Shu, Xinxin" <xinxin.shu@intel.com>
Cc: Xinze Chi <xmdxcxz@gmail.com>, Sage Weil <sweil@redhat.com>, "sjust@redhat.com" <sjust@redhat.com>, Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 24/03/15 19:53, Ning Yao wrote:
> 2015-03-20 10:22 GMT+08:00 Shu, Xinxin <xinxin.shu@intel.com>:
>> I think rocksdb can support this configuration.
>>
> I do not find this option in rocksdb. If you know, can you provide
> this option to redirect the WAL file?
>
>

I think you want to set:

rocksdb wal dir = path_to_fast_wal


I was playing with this a while back - pointing it to an SSD 
dramatically boosts IOPS!

Cheers

Mark


