From: Tommi Virtanen <tv@inktank.com>
Subject: Re: mount: 10.0.6.10:/: can't read superblock
Date: Fri, 8 Jun 2012 12:52:03 -0700
Message-ID: <CADvuQRFFXHscBVLD4k2K=NVZAz+TaiFfQm7uuusgg21JVFEMSg@mail.gmail.com>
References: <CADvuQREEAKq3AJHe3=1y59VJS36FFVY3dXPcvOLFaYecmjb9xg@mail.gmail.com>
 <c4db6453-e419-4366-8f7b-924912f31b15@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50611 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933436Ab2FHTwX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 15:52:23 -0400
Received: by pbbrp8 with SMTP id rp8so2959183pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jun 2012 12:52:23 -0700 (PDT)
In-Reply-To: <c4db6453-e419-4366-8f7b-924912f31b15@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Wilderoth <martin.wilderoth@linserv.se>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jun 8, 2012 at 12:44 PM, Martin Wilderoth
<martin.wilderoth@linserv.se> wrote:
> When upgrading from different versions I just run apt-get upgrade in a running cluster.
> I just stop ods,mds and mon on the host and then upgrade.
>
> Maybe this is very bad ?

In general, we work to make upgrades safe. MDS may not be getting as
much attention as the other daemons, so that might be the issue here.
