From: Patrick Donnelly <pdonnell@redhat.com>
Subject: Re: [PATCH] ceph: add halt mount option support
Date: Wed, 19 Feb 2020 11:22:16 -0800
Message-ID: <CA+2bHPZmjvbtFBNzviR6uYsM=bF92qC-Xkgm2uucBe6KJHjJbg@mail.gmail.com>
References: <20200216064945.61726-1-xiubli@redhat.com> <78ff80dd12d497be7a6606a60973f7e2d864e910.camel@kernel.org>
 <36e1f3a9-1688-9eb0-27d7-351a12bca85a@redhat.com> <4a4cfe2a5fc1de6f73fa3f557921c1ad5802add6.camel@kernel.org>
 <CAOi1vP_yGJGqkY+QLdQoruJrS3gawEC-_NqDnpucCWfXOHL-aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56827 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726672AbgBSTWv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Feb 2020 14:22:51 -0500
Received: by mail-io1-f69.google.com with SMTP id n26so896929ioj.1
        for <ceph-devel@vger.kernel.org>; Wed, 19 Feb 2020 11:22:43 -0800 (PST)
In-Reply-To: <CAOi1vP_yGJGqkY+QLdQoruJrS3gawEC-_NqDnpucCWfXOHL-aQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Feb 18, 2020 at 6:59 AM Ilya Dryomov <idryomov@gmail.com> wrote:
> > Yeah, I've mostly done this using DROP rules when I needed to test things.
> > But, I think I was probably just guilty of speculating out loud here.
>
> I'm not sure what exactly Xiubo meant by "fulfilling" iptables rules
> in libceph, but I will say that any kind of iptables manipulation from
> within libceph is probably out of the question.

I think we're getting confused about two thoughts on iptables: (1) to
use iptables to effectively partition the mount instead of this new
halt option; (2) use iptables in concert with halt to prevent FIN
packets from being sent when the sockets are closed. I think we all
agree (2) is not going to happen.

> > I think doing this by just closing down the sockets is probably fine. I
> > wouldn't pursue anything relating to to iptables here, unless we have
> > some larger reason to go that route.
>
> IMO investing into a set of iptables and tc helpers for teuthology
> makes a _lot_ of sense.  It isn't exactly the same as a cable pull,
> but it's probably the next best thing.  First, it will be external to
> the system under test.  Second, it can be made selective -- you can
> cut a single session or all of them, simulate packet loss and latency
> issues, etc.  Third, it can be used for recovery and failover/fencing
> testing -- what happens when these packets get delivered two minutes
> later?  None of this is possible with something that just attempts to
> wedge the mount and acts as a point of no return.

This sounds attractive but it does require each mount to have its own
IP address? Or are there options? Maybe the kernel driver could mark
the connection with a mount ID we could do filtering on it? From a
quick Google, maybe [1] could be used for this purpose. I wonder
however if the kernel driver would have to do that marking of the
connection... and then we have iptables dependencies in the driver
again which we don't want to do.

From my perspective, this halt patch looks pretty simple and doesn't
appear to be a huge maintenance burden. Is it really so objectionable?

[1] https://home.regit.org/netfilter-en/netfilter-connmark/


-- 
Patrick Donnelly, Ph.D.
He / Him / His
Senior Software Engineer
Red Hat Sunnyvale, CA
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D
