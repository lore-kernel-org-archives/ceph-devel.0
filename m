From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: cuttlefish ceph-fuse writes make for frequent inconsistent pgs
Date: Tue, 28 May 2013 06:50:19 -0300
Message-ID: <ord2sbigbo.fsf@livre.home>
References: <orzjvgi2m7.fsf@livre.home>
	<CA+4uBUZFR8a3LL5q5pNMv64P8zv4DKOTjhigm0qeMzYUoNYJ+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:47740 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab3E1Juk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 May 2013 05:50:40 -0400
In-Reply-To: <CA+4uBUZFR8a3LL5q5pNMv64P8zv4DKOTjhigm0qeMzYUoNYJ+Q@mail.gmail.com>
	(Samuel Just's message of "Mon, 27 May 2013 19:44:28 -0700")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: ceph-devel@vger.kernel.org

On May 27, 2013, Samuel Just <sam.just@inktank.com> wrote:

> Thanks for the detailed information!  Xfs?

btrfs.

> Were there any osd restarts/power cycles?

I can't rule that out, but I'm afraid it was a while ago, and my logs
don't go that far back.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
