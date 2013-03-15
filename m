From: Sam Lang <slang@inktank.com>
Subject: Re: Mutiple network port for a single osd
Date: Fri, 15 Mar 2013 16:39:17 -0500
Message-ID: <CAKMAVE8YeKNL2ow+R++nLLrnu83Dm_WCsbqi34wn9y3QdD8pMw@mail.gmail.com>
References: <CALLyzeYeMNwzn6osF8BbZ+qnbotCLCuxEn8vv9UNhPgnQaMktg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:48362 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629Ab3COVjS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Mar 2013 17:39:18 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so3971231oag.15
        for <ceph-devel@vger.kernel.org>; Fri, 15 Mar 2013 14:39:18 -0700 (PDT)
In-Reply-To: <CALLyzeYeMNwzn6osF8BbZ+qnbotCLCuxEn8vv9UNhPgnQaMktg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Sla <4k3nd0@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Mar 6, 2013 at 11:27 AM, Alex Sla <4k3nd0@gmail.com> wrote:
> Hello guys,
>
> first of all, thank you for Ceph. Such an amazon technology. Great
> pleasure to work with.
>
> Then to my question. I review Ceph in scope of security and need to
> understand how the single osd is create network port (for iptables).

The osd binds to the first available port in the range 6800-7100.  You
can adjust the range with the config options ms_bind_port_min and
ms_bind_port_max.
-sam

> But i just saw some interesting thing:
>
> Some of my osds running on more then one port.
>
> for example:
>
> Ports:
>
> tcp        0      0 172.20.21.2:6902        0.0.0.0:*
> LISTEN      1635/ceph-osd
> tcp        0      0 172.20.21.2:6903        0.0.0.0:*
> LISTEN      1635/ceph-osd
> tcp        0      0 172.20.21.2:6904        0.0.0.0:*
> LISTEN      1635/ceph-osd
>
> ps aux|grep 1635
>
> root      1635  1.9  0.2 1239708 172556 ?      Ssl  Feb23 301:34
> /usr/bin/ceph-osd --cluster=ceph -i 1 -f
>
> But some doesn't have this much ports. Why do this happen ? More
> important to know, up to how many port will be used? In overall it
> looks only 3.

Its unclear what you're asking...
>
>
> so far
> 4k3nd0
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
