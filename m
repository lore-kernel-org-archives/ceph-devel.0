From: Casey Bodley <cbodley@redhat.com>
Subject: Re: Messenger V2
Date: Wed, 18 Oct 2017 12:33:13 -0400
Message-ID: <e299a566-4758-d593-9489-02cf87557c1e@redhat.com>
References: <1508338218.21259.33.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:52865 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdJRQdS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Oct 2017 12:33:18 -0400
Received: by mail-qt0-f172.google.com with SMTP id 31so10983327qtz.9
        for <ceph-devel@vger.kernel.org>; Wed, 18 Oct 2017 09:33:17 -0700 (PDT)
In-Reply-To: <1508338218.21259.33.camel@suse.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ricardo Dias <rdias@suse.com>, Sage Weil <sweil@redhat.com>, Haomai Wang <haomai@xsky.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

-snip-

On 10/18/2017 10:50 AM, Ricardo Dias wrote:
> Also, since we want to support multiple Ceph daemons (multiplexing) in
> the same process, what would be the preferable API (messenger <-> Ceph
> daemon) to be user:
>
> a) Instantiate a single Messenger object and share the instance between
> the multiple "sub-daemons"
> b) Each "sub-daemon" instantiates a Messenger object, and the internal
> Messenger code will take care of the magic of re-using/sharing the
> connections to the same peers.

I would recommend a) here. I was imagining each sub-daemon having its 
own Dispatcher, with a single Messenger instance for the process that 
fed its Messages into a MultiplexingDispatcher that knew how to steer 
them to the right sub-Dispatcher.
