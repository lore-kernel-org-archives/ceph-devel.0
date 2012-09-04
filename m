From: Tommi Virtanen <tv@inktank.com>
Subject: Re: wip-crush
Date: Tue, 4 Sep 2012 08:42:29 -0700
Message-ID: <CADvuQRHPRASW3jf1auZFtGuL-TWZaxs+uTuYJrDC2L1Z+K2VEA@mail.gmail.com>
References: <alpine.DEB.2.00.1208211807330.12167@cobra.newdream.net>
 <5034F0B4.3060107@hastexo.com> <C4813C81-696A-4261-A4E7-991C719C0DB2@ornl.gov>
 <alpine.DEB.2.00.1208220929390.32470@cobra.newdream.net> <CAPYLRzjmcOuSkxG1iO8GqEZPeLchKwKP94KizB7mXWzAU2a57w@mail.gmail.com>
 <alpine.DEB.2.00.1208221047460.29719@cobra.newdream.net> <alpine.DEB.2.00.1208311331000.2525@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40116 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab2IDPmu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Sep 2012 11:42:50 -0400
Received: by yenl14 with SMTP id l14so1251394yen.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Sep 2012 08:42:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1208311331000.2525@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, "Atchley, Scott" <atchleyes@ornl.gov>, Florian Haas <florian@hastexo.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 31, 2012 at 1:36 PM, Sage Weil <sage@inktank.com> wrote:
> Okay, it's trivial to change 'pool' to 'root' in the default generated
> crush map, and update all the docs accordingly.  The problem is that some
> stuff built on top of ceph has 'pool=default' in there, including our chef
> cookbooks and those that other people are building.

That's actually in ceph.git src/upstart/ceph-osd.conf -- it can change
exactly when the code changes!
