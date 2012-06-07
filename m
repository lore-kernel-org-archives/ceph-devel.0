From: John Axel Eriksson <john@insane.se>
Subject: Re: radosgw authentication problems
Date: Thu, 7 Jun 2012 20:52:59 +0200
Message-ID: <CAMmJxt+LhrsiCYETb5KUA=rNthPY4y2Yyh53v9Hocgq+PmsKrA@mail.gmail.com>
References: <CAMmJxt+QMPoY-6WOypGjoTDjXafk_-knRUhfrsoca3zRn=YcXA@mail.gmail.com>
	<CAC-hyiFaTvhORZ-TdYSxgdBmZYuvWFKobHs_qvq8J8FY+pr=-g@mail.gmail.com>
	<CAMmJxtKZryK+i6jzoqRp=ojQXs1c_3d3Xsmjx7+c9GDpfwc9pg@mail.gmail.com>
	<CADvuQRE=rUwwzByGSdiExNMOy8-d37DBmxcj=Ez-QwwW70BcjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58790 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428Ab2FGSxA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 14:53:00 -0400
Received: by obbtb18 with SMTP id tb18so1234348obb.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jun 2012 11:53:00 -0700 (PDT)
In-Reply-To: <CADvuQRE=rUwwzByGSdiExNMOy8-d37DBmxcj=Ez-QwwW70BcjQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, ceph-devel@vger.kernel.org

Thanks Tommi!

Do you recommend btrfs or perhaps xfs for osds etc?

On Thu, Jun 7, 2012 at 6:33 PM, Tommi Virtanen <tv@inktank.com> wrote:
> On Thu, Jun 7, 2012 at 3:16 AM, John Axel Eriksson <john@insane.se> wrote:
>> In general I really like ceph but it does seem like it has a few rough
>> edges.
>
> We're putting a significant amount of effort in the documentation,
> installability and manageability aspects of Ceph, and hope that more
> of the fruit of that labor will become useful to the larger community
> in the coming months.
>
>> What I understand is that cephs object storage is pretty stable and is
>> used in production by some. We're only interested in the object
>> storage/rados part so what's a more informed opinion on this than my
>> speculation?
>
> RADOS, RBD and radosgw are considered production ready, when
> configured correctly. Inktank is actively providing commercial support
> for those components.
