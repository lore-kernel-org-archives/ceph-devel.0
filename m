From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: OSD and MON memory usage
Date: Fri, 16 Nov 2012 18:42:18 +0000
Message-ID: <50A6890A.4050300@inktank.com>
References: <20121116172401.ef3e5e52.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:40366 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab2KPSm1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Nov 2012 13:42:27 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so1189197eaa.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Nov 2012 10:42:26 -0800 (PST)
In-Reply-To: <20121116172401.ef3e5e52.ctpm@ist.utl.pt>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?Q2zDoXVkaW8gTWFydGlucw==?= <ctpm@ist.utl.pt>
Cc: ceph-devel@vger.kernel.org

On 11/16/2012 05:24 PM, Cl=C3=A1udio Martins wrote:
>  As for the monitor daemon on this cluster (running on a dedicated
> machine), it is currently using 3.2GB of memory, and it got to that
> point again in a matter of minutes after being restarted. Would it be
> good if we tested with the changes from the wip-mon-leaks-fix branch?

The wip-mon-leaks-fix branch had a regression introduced that would
cause your monitors to crash under certain conditions. The patch that
caused it has been identified and will be removed, but the branch still
needs some more testing before we consider it ready to be merged. We ar=
e
aiming however towards early next week.

=46or the time being, I wouldn't advise you to use that branch.

  -Joao
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
