From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Newstore Update Part 2
Date: Fri, 8 May 2015 17:19:28 -0700
Message-ID: <CAC6JEv-thH39P9LG3ErioqzJ=MUVyWNz9_zx+Azg2aAZ+ah2yw@mail.gmail.com>
References: <554D44E3.7080600@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37591 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbbEIATa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 20:19:30 -0400
Received: by igbsb11 with SMTP id sb11so34630012igb.0
        for <ceph-devel@vger.kernel.org>; Fri, 08 May 2015 17:19:29 -0700 (PDT)
Received: from mail-ig0-f181.google.com (mail-ig0-f181.google.com. [209.85.213.181])
        by mx.google.com with ESMTPSA id o2sm648715igr.9.2015.05.08.17.19.28
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 17:19:28 -0700 (PDT)
Received: by igbsb11 with SMTP id sb11so34629819igb.0
        for <ceph-devel@vger.kernel.org>; Fri, 08 May 2015 17:19:28 -0700 (PDT)
In-Reply-To: <554D44E3.7080600@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, May 8, 2015 at 4:21 PM, Mark Nelson <mnelson@redhat.com> wrote:
> Hi Guys,
>
> At the performance meeting this week we discussed the possibility of
> changing how newstore handles large partial overwrites.

Er, what was the potential change?

> To determine if
> this is useful, we look at rados bench and rbd performance of newstore at
> various IO sizes.  I've also included some rados bench read results as folks
> were interested in those.  On the graphs I've tried to mark interesting
> improvements/regressions and also some questions/comments. These tests were
> run without overlay which may help small IO performance in some cases.
>
> Graphs are here:
>
> http://nhm.ceph.com/newstore/8c8c5903_rbd_rados_tests.pdf
>
> Thanks,
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
