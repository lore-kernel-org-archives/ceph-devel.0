From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: compile error for ceph-0.28.*.tar.gz
Date: Tue, 31 May 2011 10:24:59 -0700
Message-ID: <20110531172458.GA12733@dreamer>
References: <BANLkTinCKuhzaRLKaBmJXJJCsNNHeDFuPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:39760 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757866Ab1EaRZA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 May 2011 13:25:00 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinCKuhzaRLKaBmJXJJCsNNHeDFuPA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Simon Tian <aixt2006@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, May 31, 2011 at 02:23:10PM +0800, Simon Tian wrote:
> hi  folks,
> 
>     When I make ceph after ./configure,  error comes both in 0.28.1
> and 0.28.2 like bellow:
> 
> ./include/encoding.h:294: error: no matching function for call to
> ?.ecode(PG::Log::Entry&, ceph::buffer::list::iterator&)?
> ./include/encoding.h:42: note: candidates are: void decode(__u8&,
> ceph::buffer::list::iterator&)
> ... ...
> 
> ./include/encoding.h:406: error: no matching function for call to
> ?.ncode(const PG::Missing::item&, ceph::buffer::list&)?
> ./include/encoding.h:42: note: candidates are: void encode(const
> __u8&, ceph::bufferlist&)
> ... ...
> 
> 
> I just download them from http://ceph.newdream.net/download/ceph-0.28.*.tar.gz

I just built ceph-0.28.2 from the tarball, with ./configure && make,
and had no problems.

What operating system and version are you trying to build it on?

Does the output really say "?.ecode" and "?.ncode"? Those seem really
odd. Can this machine successfully compile bigger projects, e.g. the
Linux kernel? That's a good general test of hardware reliability..

-- 
:(){ :|:&};:
