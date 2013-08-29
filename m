From: Joe Buck <joe.buck@inktank.com>
Subject: Re: Radosgw-agent data full sync implementation
Date: Wed, 28 Aug 2013 22:04:47 -0700
Message-ID: <521ED66F.8020705@inktank.com>
References: <CAA8043h7rzRzmNfBex6p9g5t9VGsH4Ln=VNZzxJf3OpquPHZKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:55053 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab3H2FEu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 01:04:50 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so7193583pbc.36
        for <ceph-devel@vger.kernel.org>; Wed, 28 Aug 2013 22:04:49 -0700 (PDT)
In-Reply-To: <CAA8043h7rzRzmNfBex6p9g5t9VGsH4Ln=VNZzxJf3OpquPHZKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: christophe courtaut <christophe.courtaut@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 08/28/2013 09:21 AM, christophe courtaut wrote:

> Hi Joe,
>
> I'm currently looking at the radosgw-agent, and i have seen your
> recent job on full sync of data.
>
> What will be the preferred way to list all objects to sync? Using
> admin API or standard S3 API?

It looks like we'll use the S3 API to list the objects in a bucket
(we'll actually use the boto library to do this).
It's worth noting that there's some locking that we need to do to
account for multiple agents running at the same time, so it's not quite
as easy as "list objects, sync objects, call it a day".

> Moreover, we will need to do an exact copy of the object to preserve
> attributes, as mentionned here
> http://pad.ceph.com/p/rgw-multi-region-dr  .
>
> Will this be part of the admin API? or am i missing something?

The following link on the wiki has most (all?) of the calls that are
being added for the sync work. There's an extended object GET and PUT in
there, towards the top.
http://wiki.ceph.com/index.php?title=RESTful_API_for_DR_%2F%2F_Geo-Replication
This link is also handy in terms of an overview:
http://www.spinics.net/lists/ceph-devel/msg11905.html

> Btw i recently posted an article here :http://blog.kri5.fr/?p=21, to
> setup two cluster for testing purpose of the radosgw-agent.

Cool.

> Best regards.
>
