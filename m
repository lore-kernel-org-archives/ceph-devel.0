From: Tommi Virtanen <tv@inktank.com>
Subject: Re: radosgw authentication problems
Date: Thu, 7 Jun 2012 09:33:30 -0700
Message-ID: <CADvuQRE=rUwwzByGSdiExNMOy8-d37DBmxcj=Ez-QwwW70BcjQ@mail.gmail.com>
References: <CAMmJxt+QMPoY-6WOypGjoTDjXafk_-knRUhfrsoca3zRn=YcXA@mail.gmail.com>
 <CAC-hyiFaTvhORZ-TdYSxgdBmZYuvWFKobHs_qvq8J8FY+pr=-g@mail.gmail.com> <CAMmJxtKZryK+i6jzoqRp=ojQXs1c_3d3Xsmjx7+c9GDpfwc9pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53928 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839Ab2FGQdv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 12:33:51 -0400
Received: by pbbrp8 with SMTP id rp8so1296323pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jun 2012 09:33:50 -0700 (PDT)
In-Reply-To: <CAMmJxtKZryK+i6jzoqRp=ojQXs1c_3d3Xsmjx7+c9GDpfwc9pg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Axel Eriksson <john@insane.se>
Cc: Yehuda Sadeh <yehuda@inktank.com>, ceph-devel@vger.kernel.org

On Thu, Jun 7, 2012 at 3:16 AM, John Axel Eriksson <john@insane.se> wrote:
> In general I really like ceph but it does seem like it has a few rough
> edges.

We're putting a significant amount of effort in the documentation,
installability and manageability aspects of Ceph, and hope that more
of the fruit of that labor will become useful to the larger community
in the coming months.

> What I understand is that cephs object storage is pretty stable and is
> used in production by some. We're only interested in the object
> storage/rados part so what's a more informed opinion on this than my
> speculation?

RADOS, RBD and radosgw are considered production ready, when
configured correctly. Inktank is actively providing commercial support
for those components.
