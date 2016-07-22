From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Pool creation fails: 'failed run crushtool: fork failed: (12)
 Cannot allocate memory'
Date: Fri, 22 Jul 2016 20:46:49 +1000
Message-ID: <20160722104649.GA24794@rskikr.localdomain>
References: <976529875.1339.1469116197418@ox.pcextreme.nl>
 <CAJ4mKGaCvH9uj49340wXqLr5fScBYjRqh7YosGH48vOoDxk2sQ@mail.gmail.com>
 <1117268583.1343.1469126502597@ox.pcextreme.nl>
 <20160721235726.GA31519@rskikr.localdomain>
 <1891032362.1371.1469180486335@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33562 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452AbcGVKq7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2016 06:46:59 -0400
Received: by mail-pf0-f182.google.com with SMTP id y134so40503529pfg.0
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jul 2016 03:46:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1891032362.1371.1469180486335@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jul 22, 2016 at 11:41:26AM +0200, Wido den Hollander wrote:
> 
> > Op 22 juli 2016 om 1:57 schreef Brad Hubbard <bhubbard@redhat.com>:
> > 
> > 
> > On Thu, Jul 21, 2016 at 08:41:42PM +0200, Wido den Hollander wrote:
> > > 
> > > > Op 21 juli 2016 om 20:01 schreef Gregory Farnum <gfarnum@redhat.com>:
> > > > 
> > > > 
> > > > On Thu, Jul 21, 2016 at 8:49 AM, Wido den Hollander <wido@42on.com> wrote:
> > > > > Hi,
> > > > >
> > > > > On a CentOS 7 system with a Jewel 10.2.2 cluster I'm trying to create a pool which fails.
> > > > >
> > > > > Any pool I try to create, with or without a ruleset applied to it fails with this error:
> > > > >
> > > > > "Error ENOMEM: crushtool check failed with -12: failed run crushtool: fork failed: (12) Cannot allocate memory"
> > > > >
> > > > > At first I thought it was a package version mismatch, but it doesn't seem to be the case.
> > > > >
> > > > > There are other commands like 'radosgw-admin' I see fail with -12 error codes as well.
> > > > >
> > > > > Any ideas what might be going on here? The system has roughly 29GB of free memory, so that should be sufficient.
> > > > 
> > > > ulimits?
> > > 
> > > Good suggestion, didn't check that, but after looking at them I don't think they are:
> > > 
> > > [root@srv-zmb16-21 ~]# ulimit -a
> > > core file size          (blocks, -c) 0
> > > data seg size           (kbytes, -d) unlimited
> > > scheduling priority             (-e) 0
> > > file size               (blocks, -f) unlimited
> > > pending signals                 (-i) 128505
> > > max locked memory       (kbytes, -l) 64
> > > max memory size         (kbytes, -m) unlimited
> > > open files                      (-n) 65536
> > > pipe size            (512 bytes, -p) 8
> > > POSIX message queues     (bytes, -q) 819200
> > > real-time priority              (-r) 0
> > > stack size              (kbytes, -s) 8192
> > > cpu time               (seconds, -t) unlimited
> > > max user processes              (-u) 4096
> > > virtual memory          (kbytes, -v) unlimited
> > > file locks                      (-x) unlimited
> > > [root@srv-zmb16-21 ~]#
> > > 
> > > Wouldn't you say?
> > 
> > 
> > As a test try doubling vm.max_map_count. We've seen the ENOMEM before in cases
> > where the number of memory allocations mapped by a process exceeded this value.
> > Note that if this is the issue it likely indicates somewhere in excess of
> > 32700 threads are being created so you may want to look at just how many
> > threads *are* being created when this issue is seen as well as taking a look
> > at the /proc/<PID>/maps file for the process to verify the number of
> > allocations. If you are seeing > 32700 threads created we should look at
> > whether that number makes sense in your environment.
> > 
> 
> Thanks for the pointers. It wasn't THE solution, but you brought me to the right area to look.
> 
> I ran the Ceph command with '--debug-ms=10' and this lead me to:
> 
> 2016-07-22 10:57:25.387445 7f593657c700  1 -- [2a04:XX:XX:70d4:ec4:7aff:febc:15f0]:0/1657730817 <== mon.0 [2a04:XX:XX:70d4:ec4:7aff:febc:15f0]:6789/0 8 ==== mon_command_ack([{"prefix": "osd pool create", "pg_num": 512, "erasure_code_profile": "prd-zm1-hdd", "pool": ".zm1.rgw.meta", "pgp_num": 512}]=-12 crushtool check failed with -12: failed run crushtool: fork failed: (12) Cannot allocate memory v135559) v1 ==== 253+0+0 (3230086078 0 0) 0x7f59200042e0 con 0x7f593805f290
> 
> What I saw is that it was the *monitor* who was sending back the ENOMEM, not my local system.
> 
> It was running into some limits. Keep in mind, this is a 1800 OSD cluster with 5 Monitors.
> 
> So I upped a few limits:
> 
> - vm.max_map_count=262144
> - kernel.pid_max=4194303
> 
> Didn't work, so I looked at the systemd service definition:
> 
> In ceph-mon@.service I updated these lines:
> 
> LimitNOFILE=1048576
> LimitNPROC=1048576
> 
> to:
> 
> LimitNOFILE=-1
> LimitNPROC=-1
> 
> After a systemd reload and restart of the monitors it all succeeded.
> 

Nicely done.

Seems excessive it would be using over one million file descriptors or the
same amount of processes though?

Maybe we should gather lsof and ps (probably need to use one of the options
under "THREAD DISPLAY" in the man page to capture thread IDs as well as PIDs)
and try and work out why so many of these resources are being allocated?

HTH,
Brad

> Wido
> 
> > HTH,
> > Brad
> > 
> > > 
> > > I also checked, SELinux is disabled. 'setenforce 0'.
> > > 
> > > Wido
> > > 
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
