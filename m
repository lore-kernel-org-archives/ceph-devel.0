From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Pool creation fails: 'failed run crushtool: fork failed: (12)
 Cannot allocate memory'
Date: Fri, 22 Jul 2016 10:15:38 +1000
Message-ID: <20160722001538.GB31519@rskikr.localdomain>
References: <976529875.1339.1469116197418@ox.pcextreme.nl>
 <CAJ4mKGaCvH9uj49340wXqLr5fScBYjRqh7YosGH48vOoDxk2sQ@mail.gmail.com>
 <1117268583.1343.1469126502597@ox.pcextreme.nl>
 <20160721235726.GA31519@rskikr.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35418 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbcGVAPr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2016 20:15:47 -0400
Received: by mail-pf0-f181.google.com with SMTP id x72so35141947pfd.2
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2016 17:15:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160721235726.GA31519@rskikr.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jul 22, 2016 at 09:57:26AM +1000, Brad Hubbard wrote:
> On Thu, Jul 21, 2016 at 08:41:42PM +0200, Wido den Hollander wrote:
> > 
> > > Op 21 juli 2016 om 20:01 schreef Gregory Farnum <gfarnum@redhat.com>:
> > > 
> > > 
> > > On Thu, Jul 21, 2016 at 8:49 AM, Wido den Hollander <wido@42on.com> wrote:
> > > > Hi,
> > > >
> > > > On a CentOS 7 system with a Jewel 10.2.2 cluster I'm trying to create a pool which fails.
> > > >
> > > > Any pool I try to create, with or without a ruleset applied to it fails with this error:
> > > >
> > > > "Error ENOMEM: crushtool check failed with -12: failed run crushtool: fork failed: (12) Cannot allocate memory"
> > > >
> > > > At first I thought it was a package version mismatch, but it doesn't seem to be the case.
> > > >
> > > > There are other commands like 'radosgw-admin' I see fail with -12 error codes as well.
> > > >
> > > > Any ideas what might be going on here? The system has roughly 29GB of free memory, so that should be sufficient.
> > > 
> > > ulimits?
> > 
> > Good suggestion, didn't check that, but after looking at them I don't think they are:
> > 
> > [root@srv-zmb16-21 ~]# ulimit -a
> > core file size          (blocks, -c) 0
> > data seg size           (kbytes, -d) unlimited
> > scheduling priority             (-e) 0
> > file size               (blocks, -f) unlimited
> > pending signals                 (-i) 128505
> > max locked memory       (kbytes, -l) 64
> > max memory size         (kbytes, -m) unlimited
> > open files                      (-n) 65536
> > pipe size            (512 bytes, -p) 8
> > POSIX message queues     (bytes, -q) 819200
> > real-time priority              (-r) 0
> > stack size              (kbytes, -s) 8192
> > cpu time               (seconds, -t) unlimited
> > max user processes              (-u) 4096
> > virtual memory          (kbytes, -v) unlimited
> > file locks                      (-x) unlimited
> > [root@srv-zmb16-21 ~]#
> > 
> > Wouldn't you say?
> 
> 
> As a test try doubling vm.max_map_count. We've seen the ENOMEM before in cases
> where the number of memory allocations mapped by a process exceeded this value.
> Note that if this is the issue it likely indicates somewhere in excess of
> 32700 threads are being created so you may want to look at just how many
> threads *are* being created when this issue is seen as well as taking a look
> at the /proc/<PID>/maps file for the process to verify the number of
> allocations. If you are seeing > 32700 threads created we should look at
> whether that number makes sense in your environment.

Sorry, I looked back at the actual issue I recalled and the error in that case
was "Resource temporarily unavailable" or EAGAIN/EWOULDBLOCK.

Might still be worth looking at the number of threads we are dealing with here
and the number, and type, of memory allocations since it's fork that's failing
after all.

> 
> HTH,
> Brad
> 
> > 
> > I also checked, SELinux is disabled. 'setenforce 0'.
> > 
> > Wido
> > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Cheers,
Brad
