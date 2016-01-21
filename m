From: Jens Rosenboom <j.rosenboom@x-ion.de>
Subject: Re: Ceph scale testing
Date: Thu, 21 Jan 2016 09:12:41 +0100
Message-ID: <CADr68Wa-CUThHr_N_J+jEcCYK_Vo2jH=bZpLreZNuPJGcRk4Yw@mail.gmail.com>
References: <CO1PR02MB208D28221FDCE8CDB8D3802F4C30@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35790 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbcAUIMn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jan 2016 03:12:43 -0500
Received: by mail-lf0-f43.google.com with SMTP id c192so21504703lfe.2
        for <ceph-devel@vger.kernel.org>; Thu, 21 Jan 2016 00:12:42 -0800 (PST)
In-Reply-To: <CO1PR02MB208D28221FDCE8CDB8D3802F4C30@CO1PR02MB208.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2016-01-21 5:03 GMT+01:00 Somnath Roy <Somnath.Roy@sandisk.com>:
> Hi,
> Here is the copy of the ppt I presented in today's performance meeting..
>
> https://docs.google.com/presentation/d/1j4Lcb9fx0OY7eQlQ_iUI6TPVJ6t_orZWKJyhz0S_3ic/edit?usp=sharing

Wow, these number look pretty impressive. Did you use some additional
patches in your Jewel build? In my own testing I'm seeing only
marginal improvements in plain Jewel vs. Hammer.

To have a fair comparison, you should also use the same QD for both
Hammer and Jewel.

Finally, the avg latency for 4k ops isn't that significant, could you
also add numbers for max latency or 99.xx percentile?
