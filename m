From: Greg Farnum <greg@inktank.com>
Subject: Re: Error 5 when trying to mount Ceph 0.47.1
Date: Fri, 25 May 2012 10:01:48 -0700
Message-ID: <707EE401726D4C078B4B5A34AC6DB16E@inktank.com>
References: <CAHwdYF3oCSODVEjOogdX3agVFYxmsQ8N_-vshSPCNkNo4+zEkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45751 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194Ab2EYRBw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 May 2012 13:01:52 -0400
Received: by pbbrp8 with SMTP id rp8so1997694pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 25 May 2012 10:01:51 -0700 (PDT)
In-Reply-To: <CAHwdYF3oCSODVEjOogdX3agVFYxmsQ8N_-vshSPCNkNo4+zEkw@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nam Dang <namd@de.cs.titech.ac.jp>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thursday, May 24, 2012 at 10:58 PM, Nam Dang wrote:
> Hi,
> 
> I've just started working with Ceph for a couple of weeks. At the
> moment, I'm trying to setup a small cluster with 1 monitor, 1 MDS and
> 6 OSDs. However, I cannot mount ceph to the system no matter which
> node I'm executing the mounting command on.
> 
> My nodes run Ubuntu 11.10 with kernal 3.0.0-12
> Seeing some other people also faced similar problems, I attached the
> result of running ceph -s as followed:
> 
> 2012-05-25 23:52:17.802590 pg v434: 1152 pgs: 189 active+clean, 963
> stale+active+clean; 8730 bytes data, 3667 MB used, 844 GB / 893 GB
> avail
> 2012-05-25 23:52:17.806759 mds e12: 1/1/1 up {0=1=up:replay}
> 2012-05-25 23:52:17.806827 osd e30: 6 osds: 1 up, 1 in
> 2012-05-25 23:52:17.806966 log 2012-05-25 23:44:14.584879 mon.0
> 192.168.172.178:6789/0 2 : [INF] mds.? 192.168.172.179:6800/6515
> up:boot
> 2012-05-25 23:52:17.807086 mon e1: 1 mons at {0=192.168.172.178:6789/0}
> 
> I tried to use the mount -t ceph node:port:/ [destination] but I keep
> getting "mount error 5 = Input/output error"
> 
> I also check if the firewall is blocking anything with nmap -sT -p
> 6789 [monNode]
> 
> My ceph version is 0.47.1, installed with sudo apt-get on the system.
> I've spent a couple of days googling with no avails, and the
> documentation does not address this issue at all.
> 
> Thank you very much for your help,

Notice how the MDS status is "up:replay"? That means it restarted at some point and is currently replaying the journal, which is why your client can't connect.

Ordinarily journal replay happens very quickly (a couple to several seconds, depending mostly on length), so if it's been in that state for a while something has gone wrong. And indeed only 1 out of 6 of your OSDs is up, and most of your PGs are "stale" because the people responsible for them aren't running. This is preventing the MDS from retrieving objects.

So we need to figure out why your OSDs are down. Did you fail to start them? Have they crashed and left behind backtraces or core dumps?
-Greg

