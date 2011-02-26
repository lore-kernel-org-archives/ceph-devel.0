From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: building Ceph on various architectures
Date: Sat, 26 Feb 2011 11:52:27 -0800
Message-ID: <E3D560F92CD249D4B2D590A54614CA08@gmail.com>
References: <1298720478.16174.14.camel@julia.gcs.org.hu>
 <C0A35234378B4D3A90BDEF41E55AF4A3@gmail.com>
 <1298749221.16174.29.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:61920 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377Ab1BZTwb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Feb 2011 14:52:31 -0500
Received: by pxi15 with SMTP id 15so426307pxi.19
        for <ceph-devel@vger.kernel.org>; Sat, 26 Feb 2011 11:52:31 -0800 (PST)
In-Reply-To: <1298749221.16174.29.camel@julia.gcs.org.hu>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: ceph-devel@vger.kernel.org

On Saturday, February 26, 2011 at 11:40 AM, Laszlo Boszormenyi wrote: 
> On Sat, 2011-02-26 at 10:28 -0800, Gregory Farnum wrote:
> > This looks like an error that came up (and got fixed) on Ubuntu several months ago:
> > https://bugs.launchpad.net/ubuntu/+source/ceph/+bug/635388
>  Yes, it looks similar. But please note two things. The counterpart of
> #635388 in Ubuntu is #597193 [1] in Debian. It was fixed on the 20th of
> September, last year. Also, that bugs was:
> 'AO_fetch_and_sub1_write' was not declared in this scope
> Compared to this one:
> 'AO_fetch_and_add_write' was not declared in this scope
> 
> I don't say it completely different, but doesn't look the exact same.

Ah, I didn't notice that -- I'll look into it more closely! 
