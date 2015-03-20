From: Xinze Chi <xmdxcxz@gmail.com>
Subject: Re: scubbing for a long time and not finished
Date: Fri, 20 Mar 2015 09:23:19 +0800
Message-ID: <CANE=7sWQFpDpHysz8q_d2bHocagG-VxdMdjRpcgX=40nRzbVbQ@mail.gmail.com>
References: <CANE=7sWwheXa3WZb_+b3G57MBuhcdMssJJqVjR9y9yRHu6vFEQ@mail.gmail.com>
	<da34275f64ad3e2960322516f488fd@ip-10-0-3-214>
	<CANE=7sWbh9aJHp603BuFZivtLJ5a-axDq7CyHCfwaDWMRw7wAg@mail.gmail.com>
	<alpine.DEB.2.00.1503190629530.7043@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:33532 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbCTBXU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Mar 2015 21:23:20 -0400
Received: by obcxo2 with SMTP id xo2so68063298obc.0
        for <ceph-devel@vger.kernel.org>; Thu, 19 Mar 2015 18:23:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1503190629530.7043@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I add a issue http://tracker.ceph.com/issues/11162.

2015-03-19 21:33 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Thu, 19 Mar 2015, Xinze Chi wrote:
>> Currently, users do not know  when some pg do scrubbing for a long time.
>> I think whether we could give some warming if it happend (defined as
>> osd_scrub_max_time).
>> It would tell the user something may be wrong in cluster.
>
> This should be pretty straightforward to add along with the other "stuck
> x" warnings based on the pg_stat_t state timestamps.  On the otherhead,
> that may be a somewhat heavyweight approach (each new warning bloats the
> stat structure a bit); open to other ideas!
>
> sage
