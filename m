From: Nat N <phenisha@gmail.com>
Subject: Re: unstable branch: ls -l hang after write by 64 clients
Date: Fri, 29 Oct 2010 13:45:28 +1100
Message-ID: <AANLkTinQ36aQUeY5t2V2o6UW_G--zkYmUSuhAbDvFY+7@mail.gmail.com>
References: <1288117260.10847.93.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1010261224450.20055@cobra.newdream.net>
	<1288128642.10847.95.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1010272200340.14714@cobra.newdream.net>
	<1288282588.10847.131.camel@sale659.sandia.gov>
	<AANLkTikT8PyiTP4_5rzn3VD_NVpJ-+z6LmyNXCVW2gui@mail.gmail.com>
	<AANLkTikBSOdfpD5dCpxpRO6imeeGSuMczi6ZRcL348Z8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44670 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758486Ab0J2Cp3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Oct 2010 22:45:29 -0400
Received: by qwf7 with SMTP id 7so1852516qwf.19
        for <ceph-devel@vger.kernel.org>; Thu, 28 Oct 2010 19:45:28 -0700 (PDT)
In-Reply-To: <AANLkTikBSOdfpD5dCpxpRO6imeeGSuMczi6ZRcL348Z8@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

>
> This should work:
>
> $ cd ~/linux-2.6.36
> $ linux$ wget -O ceph-revert.patch
> "http://ceph.newdream.net/git/?p=ceph-client.git;a=commitdiff_plain;h=2f56f56ad991edd51ffd0baf1182245ee1277a04"
> $ patch -p1 < ceph-revert.patch
>
>
> Yehuda
>

Thanks Yehuda,


This worked a charm

Regards.
