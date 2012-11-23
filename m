From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Re: OSD and MON memory usage
Date: Fri, 23 Nov 2012 16:46:00 +0000
Message-ID: <50AFA848.4050109@inktank.com>
References: <20121116172401.ef3e5e52.ctpm@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:57955 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755803Ab2KWQqN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Nov 2012 11:46:13 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so3961412bkw.19
        for <ceph-devel@vger.kernel.org>; Fri, 23 Nov 2012 08:46:12 -0800 (PST)
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

=46ollowing up on this, wip-mon-leaks-fix was merged into master a coup=
le
of days ago. If you have the chance to check if that fixes your memory
consumption issues on the monitor, it would be much appreciated!

  -Joao

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
