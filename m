From: Mark Kampe <mark.kampe@inktank.com>
Subject: Re: ceph and efficient access of distributed resources
Date: Tue, 16 Apr 2013 07:18:27 -0700
Message-ID: <516D5DB3.4060800@inktank.com>
References: <loom.20130412T055215-88@post.gmane.org> <51683184.9010301@inktank.com> <CAJH6TXgurT4yUshaH4QOgUKOaB3DqQd1-=HPshp+eH5HB7p3Hg@mail.gmail.com> <516C7E55.1050801@inktank.com> <516C8168.40402@inktank.com> <CAJH6TXhRtWQ1ypEb5JOwzp9T3Nd7A=J_6Dn0M25vXjYMg8j7fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:38850 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933365Ab3DPOSa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Apr 2013 10:18:30 -0400
Received: by mail-pa0-f53.google.com with SMTP id bh4so368643pad.26
        for <ceph-devel@vger.kernel.org>; Tue, 16 Apr 2013 07:18:29 -0700 (PDT)
In-Reply-To: <CAJH6TXhRtWQ1ypEb5JOwzp9T3Nd7A=J_6Dn0M25vXjYMg8j7fQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Matthias Urlichs <matthias@urlichs.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 04/16/13 00:20, Gandalf Corvotempesta wrote:
> 2013/4/16 Mark Kampe <mark.kampe@inktank.com>:
>> The entire web is richly festooned with cache servers whose
>> sole raison d'etre is to solve precisely this problem.  They
>> are so good at it that back-bone providers often find it more
>> cash-efficient to buy more cache servers than to lay more
>> fiber.  Cache servers don't merely save disk I/O, they catch
>> these requests before they reach the server (or even the
>> backbone).
>
> Mine was just an example, there are many other cases where a frotnend
> cache is not possible.
> I think that ceph should spread reads across the whole clusters by
> default (like a big RAID-1), to archieve bandwidth improvement.

At my previous distributed storage start-up (Parascale) we had the
ability to distribute reads across copies for load distribution
purposes and everybody we talked to said "who cares!".  Why?

    For hot-spot situations (as in your original example)
    higher level caching is far more effective than random
    traffic distribution.

    For lower level (e.g. coincidental) reuse, sending all the
    requests to a single server will usually perform better.
    Network I/O is much faster than disk I/O, and a single
    recipient will have N * the cache hit rate that N servers
    would have.

> What happens in case of a big file (for example, 100MB) with multiple
> chunks? Is ceph smart enough to read multiple chunks from multiple
> servers simultaneously or the whole file will be served by just an OSD

RADOS is the underlying storage cluster, but the access methods (block,
object, and file) stripe their data across many RADOS objects, which
CRUSH very effectively distributes across all of the servers.  A 100MB
read or write turns into dozens of parallel operations to servers all
over the cluster.

