From: Mark Nelson <mark.nelson@dreamhost.com>
Subject: Re: ioreplay allows replaying fs traces from a strace log file
Date: Thu, 12 Apr 2012 16:53:32 -0500
Message-ID: <4F874EDC.7030409@dreamhost.com>
References: <CAORUGqAPAnC6fJZgvZhbwHY6VNQa3+T8DRBBfiRwBmf4kBRCyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:60448 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762855Ab2DLVxf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Apr 2012 17:53:35 -0400
In-Reply-To: <CAORUGqAPAnC6fJZgvZhbwHY6VNQa3+T8DRBBfiRwBmf4kBRCyw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: Samuel Just <sam.just@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>

I played around with this about a month back during a rados bench run, 
but had some trouble getting it to work when strace was attached to an 
already running process.  I didn't end up spending a lot of time on it 
though.  Jeff Layton also wrote a strace analyzer tool specifically for 
IO, but it needs a bit of work to support -f.  His stuff can be found here:

http://clusterbuffer.wetpaint.com/page/Strace+Analyzer

Mark

On 4/12/12 3:47 PM, Tommi Virtanen wrote:
> This looks interesting: http://code.google.com/p/ioapps/

