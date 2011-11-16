From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: v0.38 released
Date: Wed, 16 Nov 2011 10:04:20 -0800
Message-ID: <CAORUGqCGRAK+x4Opzsw4hmjw2gKPWzxSvuVdx4A-2uR4mqQFZg@mail.gmail.com>
References: <Pine.LNX.4.64.1111102113260.27241@cobra.newdream.net>
 <20111115164254.GJ13394@systemlinux.org> <CAF3hT9AA5zgTsbHb-Gxn5BTeMG+=krGdO2NtRFcHTR_k_3dKgw@mail.gmail.com>
 <20111116095614.GK13394@systemlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48008 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867Ab1KPSEm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Nov 2011 13:04:42 -0500
Received: by wyh11 with SMTP id 11so840172wyh.19
        for <ceph-devel@vger.kernel.org>; Wed, 16 Nov 2011 10:04:41 -0800 (PST)
In-Reply-To: <20111116095614.GK13394@systemlinux.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andre Noll <maan@systemlinux.org>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Wed, Nov 16, 2011 at 01:56, Andre Noll <maan@systemlinux.org> wrote:
>> 2) I wouldn't expect your OSDs to have become so unbalanced that one
>> of them hits 95% full when the cluster's only at 84% capacity.
>
> This seems to be due to the fact that roughly the same amount of data
> was written to each file system despite of the different file system
> sizes. Hence only 60% disk space is used on the two 800G file systems.

That would be it. You probably want to set the weights of your OSDs
according to their storage capacity, otherwise the smaller ones will
get filled first.

http://ceph.newdream.net/wiki/Monitor_commands#reweight
