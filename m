From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Very intensive I/O under mon process
Date: Wed, 2 Jan 2013 19:31:01 +0300
Message-ID: <CABYiri9bUsO4S2SKU2rmt4V0oCxL6pw4JmKhZm-dNS_bJR2OOQ@mail.gmail.com>
References: <CABYiri_tx5+sSw3mZrVmtey6P6UcaRq_n4TxukzixUVm458u4g@mail.gmail.com>
 <50E45997.9060205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:38387 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab3ABQbW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Jan 2013 11:31:22 -0500
Received: by mail-oa0-f45.google.com with SMTP id i18so13268363oag.18
        for <ceph-devel@vger.kernel.org>; Wed, 02 Jan 2013 08:31:22 -0800 (PST)
In-Reply-To: <50E45997.9060205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jan 2, 2013 at 8:00 PM, Joao Eduardo Luis <joao.luis@inktank.com> wrote:
> On 01/02/2013 03:40 PM, Andrey Korolyov wrote:
>>
>> I have just observed that ceph-mon process, at least bobtail one, has
>> an extremely high density of writes - times above _overall_ cluster
>> amount of writes, measured by qemu driver(and they are very close to
>> be fair). For example, test cluster of 32 osds have 7.5 MByte/s of
>> writes on each mon node having overall amount about 1.5 Mbyte/s and
>> dev- with only three osds has values is about 1Mbyte/s with
>> accumulated real write bandwidth of tens of kilobytes per second.
>>
>> I`m afraid if this is normal, I may hit a limit of spinning storage
>> increasing test cluster, say, twenty times up of number of osd and
>> related ``idle'' write bandwidth.
>
>
> High debugging levels (specially 'debug ms', 'debug mon' or 'debug paxos')
> should significantly increase IO on the monitors. Might that be the case?

Nope, all debug levels, including mons are set to 0/0. I also see that
the ``no-client'' cluster shows a very small amount of such writes
under mon, 10-20kByte/s, and one idle client (writing couple of bytes
without O_SYNC) raise this value times up to ~200kB/s and so on, so
may be I`m wrong before and writes correlate with amount of clients
too(six clients plus three control nodes accessing via API in the
context of previous message for both environments).
