From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users] large memory leak on scrubbing
Date: Sat, 17 Aug 2013 08:11:26 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308170808070.1479@cobra.newdream.net>
References: <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C75B@MXMBON06.grupa.onet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55314 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab3HQPL1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Aug 2013 11:11:27 -0400
In-Reply-To: <ADBDB4FFB0814748AF32D0A1EE6E10AF228322C75B@MXMBON06.grupa.onet>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mostowiec Dominik <Dominik.Mostowiec@grupaonet.pl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, =?ISO-8859-2?Q?Studzi=F1ski_Krzysztof?= <krzysztof.studzinski@grupaonet.pl>, Sydor Bohdan <Bohdan.Sydor@grupaonet.pl>

Hi Dominic,

There is a bug fixed a couple of months back that fixes excessive memory 
consumption during scrub.  You can upgrade to the latest 'bobtail' branch.  
See

 http://ceph.com/docs/master/install/debian/#development-testing-packages

Installing that package should clear this up.

sage


On Fri, 16 Aug 2013, Mostowiec Dominik wrote:

> Hi,
> We noticed some issues on CEPH/S3 cluster, I think it related with scrubbing: large memory leaks.
> 
> Logs 09.xx: https://www.dropbox.com/s/4z1fzg239j43igs/ceph-osd.4.log_09xx.tar.gz
> >From 09.30 to 09.44 (14 minutes) osd.4 proces grows up to 28G. 
> 
> I think this is something curious:
> 2013-08-16 09:43:48.801331 7f6570d2e700  0 log [WRN] : slow request 32.794125 seconds old, received at 2013-08-16 09:43:16.007104: osd_sub_op(unknown.0.0:0 16.113d 0//0//-1 [scrub-reserve] v 0'0 snapset=0=[]:[] snapc=0=[]) v7 currently no flag points reached
> 
> We have large rgw index and a lot of large files than on this cluster.
> ceph version 0.56.6 (95a0bda7f007a33b0dc7adf4b330778fa1e5d70c)
> Setup: 
> - 12 servers x 12 OSD 
> - 3 mons
> Default scrubbing settings.
> Journal and filestore settings:
>         journal aio = true
>         filestore flush min = 0
>         filestore flusher = false
>         filestore fiemap = false
>         filestore op threads = 4
>         filestore queue max ops = 4096
>         filestore queue max bytes = 10485760
>         filestore queue committing max bytes = 10485760
>         journal max write bytes = 10485760
>         journal queue max bytes = 10485760
>         ms dispatch throttle bytes = 10485760
>         objecter infilght op bytes = 10485760
> 
> Is this a known bug in this version?
> (Do you know some workaround to fix this?)
> 
> ---
> Regards
> Dominik
> 
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 
