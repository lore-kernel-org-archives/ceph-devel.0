From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: git clone from ceph missig files and dirs under src/libs3/
Date: Fri, 18 Oct 2013 11:35:22 +0200
Message-ID: <526100DA.4060508@bisect.de>
References: <002201cecbe3$5cdec0c0$169c4240$@gmail.com>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:36311 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751961Ab3JRJf2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 18 Oct 2013 05:35:28 -0400
In-Reply-To: <002201cecbe3$5cdec0c0$169c4240$@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hjwsm1989-gmail <hjwsm1989@gmail.com>, ceph-devel@vger.kernel.org

Am 18.10.2013 11:20, schrieb hjwsm1989-gmail:
> Hi,all
> I get ceph from git@github.com:ceph/ceph.git
> But when I try to build rpm package from the master branch,
> It runs error like : No target to Make.
> I found there are no file or dirs under src/libs3/ in my mater and next
> branch.(all my branchs are uptodate)
> But those files exists from the ceph-0.71.tar.gz download from ceph.com.
> 
> Thanks!

Please checkout the README:


Building Ceph
=============

To prepare the source tree after it has been git cloned,

        $ git submodule update --init

Danny
