From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: unset_dumpable
Date: Thu, 20 Jul 2017 12:20:35 -0700
Message-ID: <CA+2bHPb-=nhakBXwfhxjMpBmRJJmUqUgEPnCO44Z_3RcVwUM4Q@mail.gmail.com>
References: <a7cd6c1f-93f7-e652-68ff-bdfc89ff20c1@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:38687 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753834AbdGTTVH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jul 2017 15:21:07 -0400
Received: by mail-qk0-f181.google.com with SMTP id g6so15270208qkf.5
        for <ceph-devel@vger.kernel.org>; Thu, 20 Jul 2017 12:21:06 -0700 (PDT)
In-Reply-To: <a7cd6c1f-93f7-e652-68ff-bdfc89ff20c1@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Brad Hubbard <bhubbard@redhat.com>

On Thu, Jul 20, 2017 at 7:02 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> Hi,
>
> I'm running in too many:
> /home/jenkins/workspace/ceph-master/src/test/bufferlist.cc:490:11:
> warning: unused variable 'unset_dumpable' [-Wunused-variable]
>     PrCtl unset_dumpable;
>           ^
>
> for it to be by accident??
> But why is this variable created in about a dozen functions?

AFAICT, the intent by Brad in aef2a7b6ac5d0dafdac16d0d4cef42056c07b5a6
is to prevent core dumps during the lifetime of certain objects. The
object is actually used indirectly via syscalls in its
constructo/destructor.

Is there a nice way of silencing this warning for this code?

-- 
Patrick Donnelly
