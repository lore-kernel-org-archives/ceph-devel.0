From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Poor read performance in KVM
Date: Fri, 20 Jul 2012 09:42:29 -0700
Message-ID: <CADvuQRG1z0YQezCoJhCNFnC+03UDv6H3aJPUWBcbBw3-iUnA8Q@mail.gmail.com>
References: <5002C215.108@bashkirtsev.com> <5003B1CC.4060909@inktank.com>
 <50064DCD.8040904@bashkirtsev.com> <5006D5FB.8030700@inktank.com>
 <50080D9D.8010306@bashkirtsev.com> <50085518.80507@inktank.com> <500984AC.9030104@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63153 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab2GTQmu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 12:42:50 -0400
Received: by pbbrp8 with SMTP id rp8so6397322pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 20 Jul 2012 09:42:50 -0700 (PDT)
In-Reply-To: <500984AC.9030104@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jul 20, 2012 at 9:17 AM, Vladimir Bashkirtsev
<vladimir@bashkirtsev.com> wrote:
> not running. So I ended up rebooting hosts and that's where fun begin: btrfs
> has failed to umount , on boot up it spit out "btrfs: free space inode
> generation (0) did not match free space cache generation (177431)". I have
> not started ceph and made an attempt to umount and umount just froze.
> Another reboot: same stuff. I have rebooted second host and it came back
> with the same error. So in effect I was unable to mount btrfs and read it:
> no wonder that ceph was unable to run. Actually according to mons ceph was

The btrfs developers tend to be good about bug reports that severe --
I think you should email that mailing list and ask if that sounds like
known bug, and ask what information you should capture if it happens
again (assuming the workload is complex enough that you can't easily
capture/reproduce all of that).

> But it leaves me with very final question: should we rely on btrfs at this
> point given it is having such major faults? What if I will use well tested
> by time ext4?

You might want to try xfs. We hear/see problems with all three, but
xfs currently seems to have the best long-term performance and
reliability.

I'm not sure if anyone's run detailed tests with ext4 after the
xattrs-in-leveldb feature; before that, we ran into fs limitations.
