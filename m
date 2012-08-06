From: Gregory Farnum <greg@inktank.com>
Subject: Re: send/receive feature to determine the difference between snapshots
Date: Mon, 6 Aug 2012 09:14:03 -0700
Message-ID: <CAPYLRzj=v9r=VhMGnfxBzZYvj+03+Em-8Btofdm+r_b=TSV2Ow@mail.gmail.com>
References: <20120806072410.GA27179@oder.kd-bie.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:47355 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755760Ab2HFQOF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Aug 2012 12:14:05 -0400
Received: by lagy9 with SMTP id y9so834570lag.19
        for <ceph-devel@vger.kernel.org>; Mon, 06 Aug 2012 09:14:03 -0700 (PDT)
In-Reply-To: <20120806072410.GA27179@oder.kd-bie.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dieter Kasper <d.kasper@kabelmail.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Monday, August 6, 2012, Dieter Kasper wrote:
>
> @All,
>
> I just read about a
>   "send/receive feature in Kernel-3.6 for btrfs which can be used by backup solutions to determine the difference between snapshots"
>
> http://www.h-online.com/open/news/item/First-release-candidate-of-Linux-kernel-version-3-6-1659576.html
> http://lwn.net/Articles/506244/
>
> This is a very efficient interface for backup tools, especially for large Cluster File Systems!
> Can we put it on the feature list for Ceph-FS ?
>
>
> Best Regards,
> -Dieter

While send/receive functionality in some form will be important, I
don't think we want to work on it until we have a plan for backups in
the first place -- using the filesystem client for backups is probably
the wrong interface for a Ceph cluster. :)
This topic is definitely coming up on the roadmap, though. I think
backups and cluster sync are next in line for the OSDs after PG
splitting (and merging?) is done.
-Greg
