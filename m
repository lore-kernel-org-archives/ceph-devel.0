From: Dan Mick <dan.mick@inktank.com>
Subject: Re: include/ and -I
Date: Fri, 02 Nov 2012 16:35:20 -0700
Message-ID: <509458B8.8070709@inktank.com>
References: <509437D1.9080105@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52261 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758810Ab2KBXfX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Nov 2012 19:35:23 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2750894pbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 02 Nov 2012 16:35:23 -0700 (PDT)
In-Reply-To: <509437D1.9080105@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>



On 11/02/2012 02:14 PM, Dan Mick wrote:
> I was somewhat surprised to note that we don't build with -I include, so
> that files that userland programs would find with
> relative-to-/usr/include paths have to be modified for building in the
> tree.
>
> Was this conscious, or does anyone else think it would be smoother to
> -I include/ so that outside-the-tree and inside-the-tree #includes are
> more similar?

(and Mr. Lang points out that, of course, I really mean something like
-I $(srcdir)/include, of course)
