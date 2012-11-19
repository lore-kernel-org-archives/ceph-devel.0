From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: OSD and MON memory usage
Date: Mon, 19 Nov 2012 23:20:15 +0000
Message-ID: <50AABEAF.5020703@inktank.com>
References: <20121116172401.ef3e5e52.ctpm@ist.utl.pt> <CAPYLRzj95YK92KUwMnZF5W7oRJOx4kaaSL0siZ27Vt_x7d-Tzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53564 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab2KSXUd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 18:20:33 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so3161051wgb.1
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 15:20:32 -0800 (PST)
In-Reply-To: <CAPYLRzj95YK92KUwMnZF5W7oRJOx4kaaSL0siZ27Vt_x7d-Tzw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: =?ISO-8859-1?Q?Cl=E1udio_Martins?= <ctpm@ist.utl.pt>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

On 11/19/2012 11:15 PM, Gregory Farnum wrote:
> Can you restart your monitor, then run "ceph heap start_profiler", and
> then once the memory has gone way up run "ceph heap dump"? You should
> find some files in the same directory as your monitor log files that
> you can analyze using tcmalloc's tools (see
> http://ceph.com/wiki/Memory_Profiling for some info), or send them our
> way for analysis.
> This will go easier if you also have Ceph's debug symbol packages installed. :)

The wiki has been somewhat officially deprecated and is now redirecting
to the docs. That page can still be accessed through

http://ceph.com/deprecated/Memory_Profiling

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

