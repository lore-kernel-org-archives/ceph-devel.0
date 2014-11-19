From: Dong Yuan <yuandong1222@gmail.com>
Subject: Re: One question about ceph code
Date: Wed, 19 Nov 2014 21:38:52 +0800
Message-ID: <CAMm-wcKDHG+PN8FUFLwxHJDB0bLig0A9AtNS0GyW5Z6n-CeZ-Q@mail.gmail.com>
References: <CANf+_k+F0Ktt2YPHv-4EoLVnMmk30QS4VyVSX4+J-UsFVRLCBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:39351 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755212AbaKSNix (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Nov 2014 08:38:53 -0500
Received: by mail-vc0-f179.google.com with SMTP id le20so271502vcb.38
        for <ceph-devel@vger.kernel.org>; Wed, 19 Nov 2014 05:38:52 -0800 (PST)
In-Reply-To: <CANf+_k+F0Ktt2YPHv-4EoLVnMmk30QS4VyVSX4+J-UsFVRLCBA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ding Dinghua <dingdinghua85@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sage's paper will give you what you want, you find it on ceph.com:
http://ceph.com/papers/weil-thesis.pdf

On 19 November 2014 20:33, Ding Dinghua <dingdinghua85@gmail.com> wrote:
> Hi:
>            I'm new to ceph and when I 'm reading ceph code, I find it
> hard to understand the semantics of  PG::info::last_update and
> PG::info::last_complete (even after reading the comments in code..),
> so would you please give a explanation on the two fields and their
> semantics and their usage ?
> and: When last_complete will be unequal with last_update?
> Many thanks.
>
> --
> Ding Dinghua
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Dong Yuan
Email:yuandong1222@gmail.com
