From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: Re: building Ceph on various architectures
Date: Sat, 26 Feb 2011 20:40:21 +0100
Message-ID: <1298749221.16174.29.camel@julia.gcs.org.hu>
References: <1298720478.16174.14.camel@julia.gcs.org.hu>
	 <C0A35234378B4D3A90BDEF41E55AF4A3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.routers.hu ([212.40.96.82]:33080 "EHLO mail.routers.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520Ab1BZTkW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 26 Feb 2011 14:40:22 -0500
In-Reply-To: <C0A35234378B4D3A90BDEF41E55AF4A3@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, yehudasa@gmail.com

On Sat, 2011-02-26 at 10:28 -0800, Gregory Farnum wrote:
> On Saturday, February 26, 2011 at 3:41 AM, Laszlo Boszormenyi wrote:
> This looks like an error that came up (and got fixed) on Ubuntu several months ago:
> https://bugs.launchpad.net/ubuntu/+source/ceph/+bug/635388
 Yes, it looks similar. But please note two things. The counterpart of
#635388 in Ubuntu is #597193 [1] in Debian. It was fixed on the 20th of
September, last year. Also, that bugs was:
'AO_fetch_and_sub1_write' was not declared in this scope
Compared to this one:
'AO_fetch_and_add_write' was not declared in this scope

I don't say it completely different, but doesn't look the exact same.

[ about the build failure on s390 ]
> This isn't one I'm familiar with -- I'll look into it on Monday if nobody's got it before then. :)
 OK, let it be. I may try to look into it, but please don't count on me.

Laszlo/GCS
[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=597193

