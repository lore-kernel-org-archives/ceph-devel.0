From: Wido den Hollander <wido@42on.com>
Subject: Re: Pool creation fails: 'failed run crushtool: fork failed: (12)
 Cannot allocate memory'
Date: Thu, 21 Jul 2016 20:41:42 +0200 (CEST)
Message-ID: <1117268583.1343.1469126502597@ox.pcextreme.nl>
References: <976529875.1339.1469116197418@ox.pcextreme.nl>
 <CAJ4mKGaCvH9uj49340wXqLr5fScBYjRqh7YosGH48vOoDxk2sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:34311 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbcGUSlq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jul 2016 14:41:46 -0400
In-Reply-To: <CAJ4mKGaCvH9uj49340wXqLr5fScBYjRqh7YosGH48vOoDxk2sQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


> Op 21 juli 2016 om 20:01 schreef Gregory Farnum <gfarnum@redhat.com>:
> 
> 
> On Thu, Jul 21, 2016 at 8:49 AM, Wido den Hollander <wido@42on.com> wrote:
> > Hi,
> >
> > On a CentOS 7 system with a Jewel 10.2.2 cluster I'm trying to create a pool which fails.
> >
> > Any pool I try to create, with or without a ruleset applied to it fails with this error:
> >
> > "Error ENOMEM: crushtool check failed with -12: failed run crushtool: fork failed: (12) Cannot allocate memory"
> >
> > At first I thought it was a package version mismatch, but it doesn't seem to be the case.
> >
> > There are other commands like 'radosgw-admin' I see fail with -12 error codes as well.
> >
> > Any ideas what might be going on here? The system has roughly 29GB of free memory, so that should be sufficient.
> 
> ulimits?

Good suggestion, didn't check that, but after looking at them I don't think they are:

[root@srv-zmb16-21 ~]# ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 128505
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 65536
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 4096
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited
[root@srv-zmb16-21 ~]#

Wouldn't you say?

I also checked, SELinux is disabled. 'setenforce 0'.

Wido

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
