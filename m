From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: about cpu_profiler
Date: Fri, 4 Mar 2011 12:40:05 -0800
Message-ID: <00BB198CFBE347429653477BED3AA89B@gmail.com>
References: <AANLkTimYykJpXQF3qUPYA7OF2jUf55WruXje1q0xJTet@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54849 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760065Ab1CDUkJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2011 15:40:09 -0500
Received: by ywj3 with SMTP id 3so901339ywj.19
        for <ceph-devel@vger.kernel.org>; Fri, 04 Mar 2011 12:40:08 -0800 (PST)
In-Reply-To: <AANLkTimYykJpXQF3qUPYA7OF2jUf55WruXje1q0xJTet@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: ceph-devel@vger.kernel.org


On Friday, March 4, 2011 at 12:08 PM, Colin McCabe wrote: 
> tl;dr: cpu_profiler may randomly crash your program on x86_64.
> The problem "should" be resolved in the "future".

From what I've read, it's unfortunately not out of date. However, it manifests itself as a crash so it's not the reason that we can't get debugging output, unless there's something I'm missing. :)
And even if it turns out to be very unstable on x86-64, the value of a good cpu profiler is high enough that we can set up x86 boxes or VMs...
-Greg 



