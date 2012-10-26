From: Gregory Farnum <greg@inktank.com>
Subject: Re: Slow ceph fs performance
Date: Fri, 26 Oct 2012 13:48:50 -0700
Message-ID: <CAPYLRzh=xCNWeHyLVpcJH3Vzy1PeBCkaibXNSQO2L7_=g64Ufw@mail.gmail.com>
References: <alpine.DEB.2.00.1210040823250.23556@cobra.newdream.net>
	<201210041554.q94FsdHG021382@ayesha.phys.virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35912 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136Ab2JZUsw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Oct 2012 16:48:52 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1935188lbo.19
        for <ceph-devel@vger.kernel.org>; Fri, 26 Oct 2012 13:48:50 -0700 (PDT)
In-Reply-To: <201210041554.q94FsdHG021382@ayesha.phys.virginia.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: bryan@virginia.edu
Cc: ceph-devel@vger.kernel.org

On Thu, Oct 4, 2012 at 8:54 AM, Bryan K. Wright
<bkw1a@ayesha.phys.virginia.edu> wrote:
> Hi Sage,
>
> sage@inktank.com said:
>> Can you also include 'ceph osd tree', 'ceph osd dump', and 'ceph pg dump'
>> output?  So we can make sure CRUSH is distributing things well?
>
> Here they are:
>
> # ceph osd tree
> dumped osdmap tree epoch 24
> # id    weight  type name       up/down reweight
> -1      4       pool default
> -3      4               rack unknownrack
> -2      1                       host ceph-osd-1
> 1       1                               osd.1   up      1
> -4      1                       host ceph-osd-2
> 2       1                               osd.2   up      1
> -5      1                       host ceph-osd-3
> 3       1                               osd.3   up      1
> -6      1                       host ceph-osd-4
> 4       1                               osd.4   up      1
>
> # ceph osd dump
> dumped osdmap epoch 24
> epoch 24
> fsid 7e4e4302-4ced-439e-9786-49e6036dfda4
> created 2012-09-28 13:17:40.774580
> modifed 2012-09-28 16:56:02.864965
> flags
>
> pool 0 'data' rep size 2 crush_ruleset 0 object_hash rjenkins pg_num 320 pgp_num 320 last_change 1 owner 0 crash_replay_interval 45
> pool 1 'metadata' rep size 2 crush_ruleset 1 object_hash rjenkins pg_num 320 pgp_num 320 last_change 1 owner 0
> pool 2 'rbd' rep size 2 crush_ruleset 2 object_hash rjenkins pg_num 320 pgp_num 320 last_change 1 owner 0
>
> max_osd 5
> osd.1 up   in  weight 1 up_from 18 up_thru 21 down_at 17 last_clean_interval [10,15) 192.168.1.21:6800/3702 192.168.12.21:6800/3702 192.168.12.21:6801/3702 exists,up 4ad0b4cd-cbff-4693-b8f7-667148386cf3
> osd.2 up   in  weight 1 up_from 17 up_thru 21 down_at 16 last_clean_interval [8,15) 192.168.1.22:6800/3428 192.168.12.22:6800/3428 192.168.12.22:6801/3428 exists,up 6a829cc6-fc60-450a-ac1d-8e148b757e57
> osd.3 up   in  weight 1 up_from 21 up_thru 21 down_at 20 last_clean_interval [9,15) 192.168.1.23:6800/3436 192.168.12.23:6800/3436 192.168.12.23:6801/3436 exists,up 387cff7a-b857-434b-af66-0e08f56fd0f7
> osd.4 up   in  weight 1 up_from 18 up_thru 21 down_at 17 last_clean_interval [9,15) 192.168.1.24:6800/3486 192.168.12.24:6800/3486 192.168.12.24:6801/3486 exists,up fe8c4bf0-ff6f-41e9-91ac-d5826672f8b5
>
> # ceph pg dump
> See http://ayesha.phys.virginia.edu/~bryan/ceph-pg-dump.txt

Eeek, I was going through my email backlog and came across this thread
again. Everything here does look good; the data distribution etc is
pretty reasonable.
If you're still testing, we can at least get a rough idea of the sorts
of IO the OSD is doing by looking at the perfcounters out of the admin
socket:
ceph --admin-daemon /path/to/socket perf dump
(I believe the default path is /var/run/ceph/ceph-osd.*.asok)
