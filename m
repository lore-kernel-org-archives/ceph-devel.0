From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: Documentation Discrepancy - Manual Configuration
Date: Wed, 23 Apr 2014 01:23:03 +0100
Message-ID: <535707E7.3070603@inktank.com>
References: <6b1a50710afdfd0b10133934be7eac38@pl1.haspere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:40676 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbaDWAW7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Apr 2014 20:22:59 -0400
Received: by mail-wi0-f173.google.com with SMTP id z2so4111585wiv.12
        for <ceph-devel@vger.kernel.org>; Tue, 22 Apr 2014 17:22:58 -0700 (PDT)
In-Reply-To: <6b1a50710afdfd0b10133934be7eac38@pl1.haspere.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: YS3fpFE2ykfB@dyweni.com, ceph-devel@vger.kernel.org

On 04/18/2014 08:10 AM, Dyweni - Ceph-Devel wrote:
> Hi,
>
> Testing Ceph with 0.79.
>
> 1 Monitor
> 2 OSDs
>
>
> Following the instructions here
> (http://ceph.com/docs/master/install/manual-deployment/)... I arrive at
> this state:
>
> ------
>      cluster e3e1a87b-d282-41b5-b4ad-fb3f969e164f
>       health HEALTH_WARN 192 pgs degraded; 192 pgs stuck unclean
>       monmap e1: 1 mons at {a=10.208.39.100:6789/0}, election epoch 1,
> quorum 0 a
>       osdmap e16: 2 osds: 2 up, 2 in
>        pgmap v21: 192 pgs, 3 pools, 0 bytes data, 0 objects
>              2004 MB used, 59381 MB / 65536 MB avail
>                   192 active+degraded

Indeed, ceph's default pool size is 3.  However, during the manual 
deployment guide you followed, on the "Monitor Bootstrap" section, 14th 
step, you certainly configured ceph.conf.  During this step, the guide 
presents you with an example configuration file containing the option 
'osd pool default size = 2', which overrides the default pool size of 3.

Furthermore, later during the 'Adding OSDs' section, this is made 
obvious right on the first paragraph.

Could this be made more obvious to a new-comer, probably.  But the info 
is there :)

   -Joao

>
> 'ceph osd dump' shows this:
> ------
> ...
> pool 0 'data' replicated size 3 min_size 2 ...
> pool 1 'metadata' replicated size 3 min_size 2 ...
> pool 2 'rbd' replicated size 3 min_size 2 ...
> ...
> ------
>
>
>
> It's not until I add a third OSD, or reduce the size of the pools, does
> the 192 pgs become unstuck and migrate towards active+clean.
>
>
>
> I think the documentation should indicate that three nodes are required
> for Ceph to become optimal.
>
>
>


-- 
Joao Eduardo Luis
Software Engineer | http://inktank.com | http://ceph.com
