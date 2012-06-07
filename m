From: Tommi Virtanen <tv@inktank.com>
Subject: Re: radosgw authentication problems
Date: Thu, 7 Jun 2012 12:44:19 -0700
Message-ID: <CADvuQRH=MJjNL7KMSWXXcOgRv5nAfOiH9efGOq+NXHary5iovQ@mail.gmail.com>
References: <CAMmJxt+QMPoY-6WOypGjoTDjXafk_-knRUhfrsoca3zRn=YcXA@mail.gmail.com>
 <CAC-hyiFaTvhORZ-TdYSxgdBmZYuvWFKobHs_qvq8J8FY+pr=-g@mail.gmail.com>
 <CAMmJxtKZryK+i6jzoqRp=ojQXs1c_3d3Xsmjx7+c9GDpfwc9pg@mail.gmail.com>
 <CADvuQRE=rUwwzByGSdiExNMOy8-d37DBmxcj=Ez-QwwW70BcjQ@mail.gmail.com> <CAMmJxt+LhrsiCYETb5KUA=rNthPY4y2Yyh53v9Hocgq+PmsKrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42510 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940Ab2FGToj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Jun 2012 15:44:39 -0400
Received: by pbbrp8 with SMTP id rp8so1514835pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 07 Jun 2012 12:44:39 -0700 (PDT)
In-Reply-To: <CAMmJxt+LhrsiCYETb5KUA=rNthPY4y2Yyh53v9Hocgq+PmsKrA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Axel Eriksson <john@insane.se>
Cc: ceph-devel@vger.kernel.org

On Thu, Jun 7, 2012 at 11:52 AM, John Axel Eriksson <john@insane.se> wrote:
> Do you recommend btrfs or perhaps xfs for osds etc?

Right now I think the preference order is xfs btrfs ext4, but we keep
seeing performance & reliability issues fairly evenly these days.
Btrfs apparently still has a tendency to get slower as the filesystem
ages.

Mark, feel free to correct me here ;)
