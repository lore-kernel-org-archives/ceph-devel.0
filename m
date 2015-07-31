From: David Disseldorp <ddiss@suse.de>
Subject: Re: changing default installed packages by ceph-deploy
Date: Fri, 31 Jul 2015 12:09:30 +0200
Message-ID: <20150731120930.54c5b266@g21.suse.de>
References: <CACkq2mpmFLotjC9u45YHK=fGyUT8kzgvmkX0voxXoasfrLX1ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56922 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbbGaKJc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 31 Jul 2015 06:09:32 -0400
In-Reply-To: <CACkq2mpmFLotjC9u45YHK=fGyUT8kzgvmkX0voxXoasfrLX1ew@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 29 Jul 2015 15:41:29 -0700, Travis Rhoden wrote:

> There are the following flags in ceph-deploy today that can control
> what daemons get installed:
> 
>  ceph-deploy install --help
> ...
>   --mon                 install the mon component only
>   --mds                 install the mds component only
>   --rgw                 install the rgw component only
>   --osd                 install the osd component only
>   --cli, --common       install the common component only
>   --all                 install all ceph components (e.g. mon,osd,mds,rgw).
>                         This is the default
> 
> So, my proposal is to change the default behavior from "ceph-deploy
> install --all ..." to "ceph-deploy install --mon --osd ...".
> 
> Any objections?

Sounds good to me Travis.

For the ceph-deploy install --iscsi changes at
https://github.com/ceph/ceph-deploy/pull/326 I had intentionally left
targetcli out of the --all group so that it wouldn't be installed by
default, but I'll add it if your proposed changes go in.
Any thoughts on the install --iscsi changes?

Cheers, David
