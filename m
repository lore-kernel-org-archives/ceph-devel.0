From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: page allocation failures on osd nodes
Date: Fri, 25 Jan 2013 19:07:19 +0300
Message-ID: <CABYiri-RToE33ESDw7jmiL=de3oggE0Q9YWU9csLDSvRmVQieg@mail.gmail.com>
References: <CABYiri-9QoO1PdbyN29MrwsEg10XTD_HDpamaiNGSCuYDNnULg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:63102 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab3AYQHk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jan 2013 11:07:40 -0500
Received: by mail-oa0-f44.google.com with SMTP id n5so588122oag.17
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jan 2013 08:07:39 -0800 (PST)
In-Reply-To: <CABYiri-9QoO1PdbyN29MrwsEg10XTD_HDpamaiNGSCuYDNnULg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Sorry, I have written too less yesterday because of being sleepy.
That`s obviously a cache pressure since dropping caches resulted in
disappearance of this errors for a long period. I`m not very familiar
with kernel memory mechanisms, but shouldn`t kernel try to allocate
memory on the second node if this not prohibited by process` cpuset
first and only then report allocation failure(as can be seen only node
0 involved in the failures)? I really have no idea where
numa-awareness may be count in case of osd daemons.

On Fri, Jan 25, 2013 at 2:42 AM, Andrey Korolyov <andrey@xdel.ru> wrote:
> Hi,
>
> Those traces happens only constant high constant writes and seems to
> be very rarely. OSD processes do not consume more memory after this
> event and peaks are not distinguishable by monitoring. I have able to
> catch it having four-hour constant writes on the cluster.
>
> http://xdel.ru/downloads/ceph-log/allocation-failure/
