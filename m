From: Tommi Virtanen <tv@inktank.com>
Subject: Re: mkcephfs problem
Date: Mon, 20 Aug 2012 16:24:29 -0700
Message-ID: <CADvuQREPJ5Q_sQSpbsgEuiV82kbjiW17p3+_s71M1cZQm-SBjA@mail.gmail.com>
References: <CAEj+kbmn=UY1dUKkyDDymqhbTuvEypVM+o4Ny-phS1SKZkmshA@mail.gmail.com>
 <CAEj+kbmhDRF5X=Yn=MDOPbphqDgu=rFwSQ9DBzfSwXC_d346OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:38883 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756618Ab2HTXYv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Aug 2012 19:24:51 -0400
Received: by vbbff1 with SMTP id ff1so5919724vbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 20 Aug 2012 16:24:50 -0700 (PDT)
In-Reply-To: <CAEj+kbmhDRF5X=Yn=MDOPbphqDgu=rFwSQ9DBzfSwXC_d346OA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tim Flavin <tim.flavin@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Jul 22, 2012 at 8:35 AM, Tim Flavin <tim.flavin@gmail.com> wrote:
>> cat: /tmp/foo/key.*: No such file or directory
...
> In addition to localhost, I found a number of other network related
> problems with my setup.
> When I fixed them mkcephfs was much happier.

Hi. I wanted to check back on this; we just stumbled on this same
problem, and I tracked down what's going on. The simplest fix is
exactly what you discovered; don't use "host=localhost" in ceph.conf.

The ticket for this is http://tracker.newdream.net/issues/3001
