From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Unexpected behavior by ceph 0.48.2argonaut.
Date: Wed, 07 Nov 2012 18:32:43 -0800
Message-ID: <509B19CB.7010300@inktank.com>
References: <CAGfy=6m3HPYwMRvRki0ZswpswuDVso1-W7i18jGtnoHb4a0HKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45611 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab2KHCdG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 21:33:06 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so1615951pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Nov 2012 18:33:05 -0800 (PST)
In-Reply-To: <CAGfy=6m3HPYwMRvRki0ZswpswuDVso1-W7i18jGtnoHb4a0HKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 11/07/2012 05:34 AM, hemant surale wrote:
> I am not sure about my judgments but please help me out understanding
> the result of following experiment carried out : -
>
>
> Experiment  : (3 node cluster,  all have ceph v.0.48.2agonaut( after
> building ceph from src code) + UBUNTU 12.04 + kernel 3.2.0 )
> ----------------------------------------------------------------------------------------------------------------------------------------------------------
>              VM1 ( mon.0+ osd.0 +mds.0 )  VM2 (mon.1 + osd.1 + mds.1)  VM3(mon.2)
>               - Cluster is up and HEALTH_OK
>               - Replication factor is 2. (by default all pools have
> replication factor set to 2)
>               - After mounting "mount.ceph mon_addr:port :/ ~/cephfs "
> , I created file inside mounted Dir "cephfs" .
>               - And able to see data on both OSD i.e. VM1(osd.0) and on
> VM2(osd.1)  as well as file is accessible .
>               - Then VM2 is made down & VM2 absence is verified with ceph -s  .
>               - Even after VM1(osd.0 mds.0 mon.0) + VM3 (mon.2)  was
> live , I am unable to access the file .

Was the cluster showing all pgs active+degraded after this, or did
some stay inactive?

>               - I tried to remount the data on different Dir with
> mount.ceph currently_live_mons:/ /home/hemant/xyz
>               - Even after that I was unable to access the file stored
> on cluster.
> ----------------------------------------------------------------------------------------------------------------------------------------------------------
>
> -
> Hemant Surale.

