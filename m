From: Sage Weil <sage@newdream.net>
Subject: Re: My favorite question
Date: Tue, 19 Jul 2011 07:29:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107190728370.5656@cobra.newdream.net>
References: <4E25646C.4000909@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59747 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab1GSOZh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2011 10:25:37 -0400
In-Reply-To: <4E25646C.4000909@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Tue, 19 Jul 2011, Fyodor Ustinov wrote:
> Hi!
> 
> 2011-07-19 14:00:39.509391   log 2011-07-19 14:00:34.185718 osd5
> 10.5.51.145:6803/19737 1563 : [ERR] 0.f8 scrub stat mismatch, got 2074/2074
> objects, 0/0 clones, 8624991435/8590119115 bytes, 8422853/8388798 kb.
> 2011-07-19 14:00:39.509391   log 2011-07-19 14:00:34.185732 osd5
> 10.5.51.145:6803/19737 1564 : [ERR] 0.f8 scrub 1 errors
> 
> How to respond to this message?

$ ceph pg repair 0.f8

should do the trick!

sage
