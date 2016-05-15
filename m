From: Dan van der Ster <dan@vanderster.com>
Subject: Re: [ceph-users] reweight-by-utilization warning
Date: Sun, 15 May 2016 18:42:26 +0200
Message-ID: <CABZ+qqmzFiT5WKiOeR7Z48TKrM+nKN5k-m1t1RAFPHEWPrPPTg@mail.gmail.com>
References: <CA+z5DsxSQCVTC6deY91BuDPoGZc9rqzt6SG2vovy+vk3R1A9eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36795 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277AbcEOQnJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 15 May 2016 12:43:09 -0400
Received: by mail-lf0-f41.google.com with SMTP id u64so109145981lff.3
        for <ceph-devel@vger.kernel.org>; Sun, 15 May 2016 09:43:08 -0700 (PDT)
Received: from mail-lb0-f174.google.com (mail-lb0-f174.google.com. [209.85.217.174])
        by smtp.gmail.com with ESMTPSA id n8sm4524094lbc.17.2016.05.15.09.43.06
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 May 2016 09:43:06 -0700 (PDT)
Received: by mail-lb0-f174.google.com with SMTP id jj5so43157931lbc.0
        for <ceph-devel@vger.kernel.org>; Sun, 15 May 2016 09:43:06 -0700 (PDT)
In-Reply-To: <CA+z5DsxSQCVTC6deY91BuDPoGZc9rqzt6SG2vovy+vk3R1A9eA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Blair Bethwaite <blair.bethwaite@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi Blaire! (re-copying to list)

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


On Sun, May 15, 2016 at 4:09 PM, Blair Bethwaite
<blair.bethwaite@gmail.com> wrote:
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
