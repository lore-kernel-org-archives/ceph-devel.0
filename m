From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Very intensive I/O under mon process
Date: Wed, 02 Jan 2013 16:00:23 +0000
Message-ID: <50E45997.9060205@inktank.com>
References: <CABYiri_tx5+sSw3mZrVmtey6P6UcaRq_n4TxukzixUVm458u4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:64906 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788Ab3ABQAu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jan 2013 11:00:50 -0500
Received: by mail-la0-f54.google.com with SMTP id fp12so6338747lab.13
        for <ceph-devel@vger.kernel.org>; Wed, 02 Jan 2013 08:00:48 -0800 (PST)
In-Reply-To: <CABYiri_tx5+sSw3mZrVmtey6P6UcaRq_n4TxukzixUVm458u4g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 01/02/2013 03:40 PM, Andrey Korolyov wrote:
> I have just observed that ceph-mon process, at least bobtail one, has
> an extremely high density of writes - times above _overall_ cluster
> amount of writes, measured by qemu driver(and they are very close to
> be fair). For example, test cluster of 32 osds have 7.5 MByte/s of
> writes on each mon node having overall amount about 1.5 Mbyte/s and
> dev- with only three osds has values is about 1Mbyte/s with
> accumulated real write bandwidth of tens of kilobytes per second.
>
> I`m afraid if this is normal, I may hit a limit of spinning storage
> increasing test cluster, say, twenty times up of number of osd and
> related ``idle'' write bandwidth.

High debugging levels (specially 'debug ms', 'debug mon' or 'debug 
paxos') should significantly increase IO on the monitors. Might that be 
the case?

   -Joao

