From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: [PATCH] msgr: Correctly handle half-open connections.
Date: Fri, 3 Dec 2010 08:59:36 -0800
Message-ID: <AANLkTikmvnSDvOj5JZK+QmZtxQOFAeep-XyT3dm-LJ_J@mail.gmail.com>
References: <1291318895-11879-1-git-send-email-jaschut@sandia.gov>
	<1291323999.4879.198.camel@sale659.sandia.gov>
	<1291394903.4879.206.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47345 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358Ab0LCRGB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Dec 2010 12:06:01 -0500
Received: by eye27 with SMTP id 27so5149091eye.19
        for <ceph-devel@vger.kernel.org>; Fri, 03 Dec 2010 09:05:59 -0800 (PST)
In-Reply-To: <1291394903.4879.206.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Dec 3, 2010 at 8:48 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> I still see lots of clients resetting osds, but it has no
> ill effects now.
This at least is expected -- we realized a few months back that
connections were never being removed from the OSD if the client
crashed (didn't send a FIN notification) and had to implement
timeouts. Having reasonably robust failure handling on each end meant
we didn't need to do anything clever with keepalives, so we just left
it. :)

Separately,
> This combination has survived the heaviest write loads
> (64 clients against 13 osds) that I've tested with to date.
How is this scaling for you on the client side? We're starting to do
more large-scale testing but haven't gotten through much yet!
-Greg
