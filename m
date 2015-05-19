From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Jobs of a teuthology run
Date: Tue, 19 May 2015 09:53:06 -0700
Message-ID: <CAC6JEv8EmentqokDkQv-8c8fWVYwUZVqhP8vxRK0pomPFRjMPQ@mail.gmail.com>
References: <06E7D85B3BA36C4DB207FEDE871C53489E8212@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36279 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767AbbESQxI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 May 2015 12:53:08 -0400
Received: by iepj10 with SMTP id j10so18579636iep.3
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2015 09:53:07 -0700 (PDT)
Received: from mail-ig0-f181.google.com (mail-ig0-f181.google.com. [209.85.213.181])
        by mx.google.com with ESMTPSA id n9sm8232198igy.2.2015.05.19.09.53.06
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2015 09:53:06 -0700 (PDT)
Received: by igbpi8 with SMTP id pi8so111516297igb.0
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2015 09:53:06 -0700 (PDT)
In-Reply-To: <06E7D85B3BA36C4DB207FEDE871C53489E8212@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, May 19, 2015 at 6:17 AM, Wang, Zhiqiang <zhiqiang.wang@intel.com> wrote:
> Hi all,
>
> I was running teuthology on sepia to test proxy write. I used the command like below to start the run. Somehow it generated 1143 jobs. I see from pulpit that there are usually no more than 300 jobs in other people's run. So my question is that should I go ahead with the 1000+ jobs? Or Is there some way to filter out some, so that I just need to run 200+ jobs?
>
> ./virtualenv/bin/teuthology-suite --filter-out btrfs,ext4 --suite rados --suite-branch hammer --machine-type plana,burnupi,mira --distro ubuntu --email zhiqiang.wang@intel.com --owner zhiqiang.wang@intel.com --ceph wip-proxy-write


There's a (relatively new) --subset [x]/[y] option, which splits up
the suite into y pieces. All the pieces together contain every test,
and each piece uses every test "fragment" at least once. A common one
is to split it up into ~14 pieces and iterate through the x on each
subsequent run. You can use this instead of the --filter-out flags.

And yes, please don't try and run an 1100-test suite through the
cluster; it's already overloaded (especially with the point release
testing that has been going on). :(
-Greg
