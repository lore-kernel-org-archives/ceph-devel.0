From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: [PATCH 2/2] libceph: validate timespec conversions
Date: Mon, 22 Apr 2013 11:00:44 -0400 (EDT)
Message-ID: <221013945.45.1366642844097.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <517456D7.8090603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:4858 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031Ab3DVPFu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 22 Apr 2013 11:05:50 -0400
In-Reply-To: <517456D7.8090603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org


----- "Alex Elder" <elder@inktank.com> wrote:

> A ceph timespec contains 32-bit unsigned values for its seconds and
> nanoseconds components.  For a standard timespec, both fields are
> signed, and the seconds field is almost surely 64 bits.

Is the Ceph timespec going to change at some point?

> 
> Add some explicit casts so the fact that this conversion is taking
> place is obvious.  Also trip a bug if we ever try to put out of
> range (negative or too big) values into a ceph timespec.
> 

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
