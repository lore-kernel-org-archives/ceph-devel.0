From: Craig Lewis <clewis@centraldesktop.com>
Subject: Re: Dev Summit: RGW Snapshots
Date: Tue, 28 Oct 2014 14:30:56 -0700
Message-ID: <CADHZLBYNC0NoDR8-Uwk67u3UfA8X6SD9G==Rp79Y1nNbEXi7Zw@mail.gmail.com>
References: <CADHZLBY_3sDOjjfke2Ag7+LNXPPcUwpa-n5iDFWkb9K+xrsF9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:36308 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbaJ1VbS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Oct 2014 17:31:18 -0400
Received: by mail-wg0-f41.google.com with SMTP id k14so506524wgh.28
        for <ceph-devel@vger.kernel.org>; Tue, 28 Oct 2014 14:31:17 -0700 (PDT)
In-Reply-To: <CADHZLBY_3sDOjjfke2Ag7+LNXPPcUwpa-n5iDFWkb9K+xrsF9w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>, Yehuda Sadeh <yehuda@inktank.com>

Sorry I flaked this morning for the RGW Snapshot blueprint discussion.  I
thought the summit was next week; I was completely unprepared.


I see the pad was updated with some new details.

I like the better direction.  I've always had concerns that the independent
rados snapshots were going to cause atomicity problems, but I'm pretty sure
that it could work for my use case.  That's because I have a pretty easy use
case, and I can work around the edge cases.  This blueprint has a much
broader appeal to other users.

Unfortunately, this new blueprint is beyond my abilities.  I'm struggling to
implement my original blueprint.  Having RadosGW manage it's own snapshots
requires a much deeper understanding of the codebase than something a
weekend coder is going to be able to do.

I'm still able to work on documentation and testing, just not coding.


Where does that leave this blueprint?
