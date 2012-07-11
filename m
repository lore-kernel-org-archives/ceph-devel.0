From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [PATCH] Robustify ceph-rbdnamer and adapt udev rules
Date: Wed, 11 Jul 2012 09:32:28 -0700
Message-ID: <CADvuQRFUwhyNVMbE0Z5-x4udXYBYVLKqCF1SMr4YhNRvDK-92A@mail.gmail.com>
References: <1342012996.5511.27.camel@clawhammer> <4FFDA995.70302@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49686 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab2GKQct (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 12:32:49 -0400
Received: by pbbrp8 with SMTP id rp8so2231758pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 09:32:49 -0700 (PDT)
In-Reply-To: <4FFDA995.70302@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: "Pascal de Bruijn | Unilogic Networks B.V." <pascal@unilogicnetworks.net>, ceph-devel@vger.kernel.org, s.kleijkers@unilogic.nl

On Wed, Jul 11, 2012 at 9:28 AM, Josh Durgin <josh.durgin@inktank.com> wrote:
> This all makes sense, but maybe we should put the -part suffix in
> another namespace to avoid colliding with images that happen to have
> -partN in their name, e.g.:
>
>     /dev/rbd/mypool/myrbd/part1 -> /dev/rbd3p1

Good idea (assuming the udev details make that doable).

Namespaces are one honking great idea -- let's do more of those!   ;)
