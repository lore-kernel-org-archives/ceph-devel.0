From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: CEPH distributed filesystem on two sites
Date: Mon, 12 Jul 2010 12:39:14 -0700
Message-ID: <AANLkTikj5e1JlAHK2lfoiVlXsnxCh0M5gAMBl6ZdxtEn@mail.gmail.com>
References: <AANLkTikDlZd0AUFzJ_VCnWYYsTnHlTmilok2o4_ErFvq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64351 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708Ab0GLTjP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Jul 2010 15:39:15 -0400
Received: by qwh6 with SMTP id 6so1383818qwh.19
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jul 2010 12:39:15 -0700 (PDT)
In-Reply-To: <AANLkTikDlZd0AUFzJ_VCnWYYsTnHlTmilok2o4_ErFvq@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roland Rabben <roland@jotta.no>
Cc: ceph-devel@vger.kernel.org

On Mon, Jul 12, 2010 at 11:59 AM, Roland Rabben <roland@jotta.no> wrote:
> Have there been any work to get CEPH working with two datacenters?
>
> I would like to have two copies of a file at site 1 and a third copy
> at site two.
> And would you be able to continue running with one of the sites down?
>
> Best regards
>
> Roland Rabben
We've tossed around a few ideas for this but there hasn't been any
serious work on making it happen. Ceph very much assumes a fast
network between all the OSDs and any work on supporting multi-site
installations would require significant updates to the basic
algorithms.
That said, as Brian discusses it will work, but expect writes to
proceed at about the speed of your datacenter interconnect. And
there's not any sort of transparent mapping between a file being
created in one datacenter and it having a master there.

At present, the best options I know of for multi-site filesystems are
something like XtreemFS or an AndrewFS derivative -- they won't
necessarily satisfy your requirements but they are standard
filesystems designed for multi-site support, unlike any others I'm
aware of.
-Greg
