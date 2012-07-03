From: Tommi Virtanen <tv@inktank.com>
Subject: Re: URL-safe base64 encoding for keys
Date: Tue, 3 Jul 2012 08:35:09 -0700
Message-ID: <CADvuQRERYhuFiz07Kp_YxOo_ya6-jACJ3X2gNihp=5F83BJQiQ@mail.gmail.com>
References: <4FF2E40B.8090705@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51857 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616Ab2GCPfa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 11:35:30 -0400
Received: by yhmm54 with SMTP id m54so6197011yhm.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 Jul 2012 08:35:30 -0700 (PDT)
In-Reply-To: <4FF2E40B.8090705@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 3, 2012 at 5:22 AM, Wido den Hollander <wido@widodh.nl> wrote:
> CloudStack's API expects a URI to be passed when adding a storage pool,
> e.g.:
>
> addStoragePool?uri=rbd://user:cephxkey@monitor.addr/poolname
>
> If 'cephxkey' contains a / the URI parser in Java fails (java.net.URI) and
> splits the URI in the wrong place.

First, I actually agree with you -- urlsafe b64 just makes sense. We'd
have to go through some sort of a transition period, accepting both,
perhaps generating old-style, for some time.

Second, have you tried quoting the unsafe characters? / is %2f, + is
%2b, % is %25.
