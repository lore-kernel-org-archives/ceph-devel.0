From: Dan van der Ster <dvanders@gmail.com>
Subject: Re: [ceph-users] reweight-by-utilization warning
Date: Sun, 15 May 2016 18:38:00 +0200
Message-ID: <CABZ+qq=bGec92+bH_x0BPYtdV1yjjfQzXuCtdrnY-oZ-s9BPrg@mail.gmail.com>
References: <CA+z5DsxSQCVTC6deY91BuDPoGZc9rqzt6SG2vovy+vk3R1A9eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36283 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336AbcEOQim (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 15 May 2016 12:38:42 -0400
Received: by mail-lf0-f49.google.com with SMTP id u64so109122062lff.3
        for <ceph-devel@vger.kernel.org>; Sun, 15 May 2016 09:38:41 -0700 (PDT)
In-Reply-To: <CA+z5DsxSQCVTC6deY91BuDPoGZc9rqzt6SG2vovy+vk3R1A9eA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Blair Bethwaite <blair.bethwaite@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi Blaire!

The good news is that the functionality of that python script is now
available natively in jewel and has been backported to hammer 0.96.7.

Now you can use

  ceph osd test-reweight-by-(pg|utilization)

in order to see how the weights would change if you were to run
reweight-by-(pg|utilization). Also there are some new options on the
(test-)reweight-by-* functions which allow you to adjust the max
weight changed per run and num osds changed per run.

Hope that helps!

Dan

On 15 May 2016 4:09 pm, "Blair Bethwaite" <blair.bethwaite@gmail.com> wrote:
>
> Hi all,
>
> IMHO reweight-by-utilization should come with some sort of warning, it
> just suddenly reweights everything - no dry run, no confirmation,
> apparently no option to see what it's going to do. It also doesn't
> appear to consider pools and hence crush rulesets, which I imagine
> could result in it making some poor reweighting decisions.
>
> We ran it on a cluster this evening and promptly had over 70% of
> objects misplaced - even at 5-7 GB/s that's quite a lot of data
> movement when there are half a billion objects in the cluster! I think
> we'll stick with Dan's scripts
> (https://github.com/cernceph/ceph-scripts/blob/master/tools/crush-reweight-by-utilization.py)
> for the moment (thanks Dan!).
>
> --
> Cheers,
> ~Blairo
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
