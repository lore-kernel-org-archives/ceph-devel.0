From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: about cpu_profiler
Date: Fri, 4 Mar 2011 12:47:13 -0800
Message-ID: <AANLkTinNO-U_E-Z76obnTJ+Ciz9VqWfBJr24J9-bBdGJ@mail.gmail.com>
References: <AANLkTimYykJpXQF3qUPYA7OF2jUf55WruXje1q0xJTet@mail.gmail.com>
	<00BB198CFBE347429653477BED3AA89B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39464 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760017Ab1CDUrO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Mar 2011 15:47:14 -0500
Received: by fxm17 with SMTP id 17so2553114fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 04 Mar 2011 12:47:13 -0800 (PST)
In-Reply-To: <00BB198CFBE347429653477BED3AA89B@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

I'm testing out oprofile now. So far, it seems relatively painless,
and it is a system-wide profiler. It seems to have some kernel hooks
too...

Colin


On Fri, Mar 4, 2011 at 12:40 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
>
> On Friday, March 4, 2011 at 12:08 PM, Colin McCabe wrote:
>> tl;dr: cpu_profiler may randomly crash your program on x86_64.
>> The problem "should" be resolved in the "future".
>
> From what I've read, it's unfortunately not out of date. However, it manifests itself as a crash so it's not the reason that we can't get debugging output, unless there's something I'm missing. :)
> And even if it turns out to be very unstable on x86-64, the value of a good cpu profiler is high enough that we can set up x86 boxes or VMs...
> -Greg
>
>
>
>
