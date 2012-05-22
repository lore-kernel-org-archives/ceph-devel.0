From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: broken init script under debian squeeze
Date: Tue, 22 May 2012 09:08:51 -0700
Message-ID: <CAC-hyiHp9e6NKXAfaYfirX_E2A3O2XRmLT7nDSOnwxjbKRwT6w@mail.gmail.com>
References: <4FBB64EF.70402@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54394 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759248Ab2EVQIw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 12:08:52 -0400
Received: by bkcji2 with SMTP id ji2so5142190bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 09:08:51 -0700 (PDT)
In-Reply-To: <4FBB64EF.70402@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, May 22, 2012 at 3:05 AM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Hi,
>
> the ceph init script seems to be broken - at least under debian lenny.
>
> It does simply nothing on a configured osd / mon server, so while system
> start the daemons won't start. Ow do i have to configure the hostname to
> match anything special in ceph.conf?
> [root@system123 /etc]# /etc/init.d/ceph start
> [root@system123 /etc]#
>
> option -a works fine (/etc/init.d/ceph -a start)
>

My guess is that you're missing 'host = <hostname>' entry under the
relevant osd and mon sections in your ceph.conf.

Yehuda
