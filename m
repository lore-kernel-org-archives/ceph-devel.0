From: Sam Lang <sam.lang@inktank.com>
Subject: Re: page allocation failures on osd nodes
Date: Fri, 25 Jan 2013 17:40:13 -0600
Message-ID: <CAKMAVE80tW5ewwBVxeS-ZbaRuBY-Msg5i2a_Px_F+PaS_4jpHw@mail.gmail.com>
References: <CABYiri-9QoO1PdbyN29MrwsEg10XTD_HDpamaiNGSCuYDNnULg@mail.gmail.com>
	<CABYiri-RToE33ESDw7jmiL=de3oggE0Q9YWU9csLDSvRmVQieg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:45852 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863Ab3AYXkP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jan 2013 18:40:15 -0500
Received: by mail-ob0-f182.google.com with SMTP id uo13so1094402obb.41
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jan 2013 15:40:15 -0800 (PST)
In-Reply-To: <CABYiri-RToE33ESDw7jmiL=de3oggE0Q9YWU9csLDSvRmVQieg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jan 25, 2013 at 10:07 AM, Andrey Korolyov <andrey@xdel.ru> wrote:
> Sorry, I have written too less yesterday because of being sleepy.
> That`s obviously a cache pressure since dropping caches resulted in
> disappearance of this errors for a long period. I`m not very familiar
> with kernel memory mechanisms, but shouldn`t kernel try to allocate
> memory on the second node if this not prohibited by process` cpuset
> first and only then report allocation failure(as can be seen only node
> 0 involved in the failures)? I really have no idea where
> numa-awareness may be count in case of osd daemons.

Hi Andrey,

You said that the allocation failure doesn't occur if you flush
caches, but the kernel should evict pages from the cache as needed so
that the osd can allocate more memory (unless their dirty, but it
doesn't look like you have many dirty pages in this case).  It looks
like you have plenty of reclaimable pages as well.  Does the osd
remain running after that error occurs?

I wonder if you see the same error if you do a long write intensive
workload on the local disk for the osd in question, maybe dd
if=/dev/zero of=/data/osd.0/foo

-sam


>
> On Fri, Jan 25, 2013 at 2:42 AM, Andrey Korolyov <andrey@xdel.ru> wrote:
>> Hi,
>>
>> Those traces happens only constant high constant writes and seems to
>> be very rarely. OSD processes do not consume more memory after this
>> event and peaks are not distinguishable by monitoring. I have able to
>> catch it having four-hour constant writes on the cluster.
>>
>> http://xdel.ru/downloads/ceph-log/allocation-failure/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
