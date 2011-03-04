From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: monitor dispatch queue seems backed up?
Date: Fri, 4 Mar 2011 13:00:45 -0800
Message-ID: <192085D5D2EB46F1B37A801063082AFD@gmail.com>
References: <1299258853.4750.191.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1103041137050.25280@cobra.newdream.net>
 <1C3F2964F2314471949A0E8F6C807216@gmail.com>
 <AANLkTinndgwjSdyZCucUa=rDBXTDOcd0_L3B=8AZisNj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47116 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932437Ab1CDVAt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2011 16:00:49 -0500
Received: by ywj3 with SMTP id 3so907454ywj.19
        for <ceph-devel@vger.kernel.org>; Fri, 04 Mar 2011 13:00:49 -0800 (PST)
In-Reply-To: <AANLkTinndgwjSdyZCucUa=rDBXTDOcd0_L3B=8AZisNj@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Sage Weil <sage@newdream.net>, Jim Schutt <jaschut@sandia.gov>
Cc: "=?utf-8?Q?ceph-devel=40vger.kernel.org?=" <ceph-devel@vger.kernel.org>

On Friday, March 4, 2011 at 12:53 PM, Yehuda Sadeh Weinraub wrote:

> you mean 'osd pg bits' in the ceph.conf?
> 
Sorry, yes.

Jim, that 3 second gap is a configurable timeout/retry period; I don't remember exactly where it's set up. I suspect this failed reads problem is some kind of fallout from the activity with SIGPIPE yesterday (and signals in general the last few days), but couldn't say for sure on my own...
-Greg



