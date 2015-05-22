From: John Spray <john.spray@redhat.com>
Subject: Re: Slow file creating and deleting using bonnie ++ on Hammer
Date: Fri, 22 May 2015 16:34:16 +0100
Message-ID: <555F4C78.7060601@redhat.com>
References: <CAMzumdYUsO2jh8Xk1bpQLrOR7NiLcR5FzL15ve9=jiQ9Bz64wQ@mail.gmail.com>	<CAC6JEv9ZjK6nn0tK7HpQWMkMcYhn=Kbg77_+J1NxKTq0WWfJOQ@mail.gmail.com>	<CAMzumdYw_13u2nYDohMRbtD-tcKOTmJNn-x+mEFh2__hpf8XKw@mail.gmail.com> <CAMzumdZgmsmBYHci2qq1qDs2nWmXq3StR9FbPT3FfHy_zi9qeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44304 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757204AbbEVPeW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 May 2015 11:34:22 -0400
In-Reply-To: <CAMzumdZgmsmBYHci2qq1qDs2nWmXq3StR9FbPT3FfHy_zi9qeA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Barclay Jameson <almightybeeij@gmail.com>, Gregory Farnum <greg@gregs42.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 22/05/2015 16:25, Barclay Jameson wrote:
> The Bonnie++ job _FINALLY_ finished. If I am reading this correctly it
> took days to create, stat, and delete 16 files??
> [root@blarg cephfs]# ~/bonnie++-1.03e/bonnie++ -u root:root -s 256g -r
> 131072 -d /cephfs/ -m CephBench -f -b
> Using uid:0, gid:0.
> Writing intelligently...done
> Rewriting...done
> Reading intelligently...done
> start 'em...done...done...done...
> Create files in sequential order...done.
> Stat files in sequential order...done.
> Delete files in sequential order...done.
> Create files in random order...done.
> Stat files in random order...done.
> Delete files in random order...done.
> Version 1.03e       ------Sequential Output------ --Sequential Input- --Random-
>                      -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> CephBench      256G           1006417  76 90114  13           137110
> 8 329.8   7
>                      ------Sequential Create------ --------Random Create--------
>                      -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
>                files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>                   16     0   0 +++++ +++     0   0     0   0  5267  19     0   0
> CephBench,256G,,,1006417,76,90114,13,,,137110,8,329.8,7,16,0,0,+++++,+++,0,0,0,0,5267,19,0,0
>
> Any thoughts?
>
It's 16000 files by default (not 16), but this usually takes only a few 
minutes.

FWIW I tried running a quick bonnie++ (with -s 0 to skip the IO phase) 
on a development (vstart.sh) cluster with a fuse client, and it readily 
handles several hundred client requests per second (checked with "ceph 
daemonperf mds.<id>")

Nothing immediately leapt out at me from a quick look at the log you 
posted, but with issues like these it is always worth trying to narrow 
it down by trying the fuse client instead of the kernel client, and/or 
different kernel versions.

You may also want to check that your underlying RADOS cluster is 
performing reasonably by doing a rados bench too.

Cheers,
John
