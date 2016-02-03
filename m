From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Infernalis on NVMe cephx authentication impact
Date: Wed, 3 Feb 2016 02:30:31 +0000
Message-ID: <BN1PR02MB055BF4A4566B78C2AC33B87F4D00@BN1PR02MB055.namprd02.prod.outlook.com>
References: <034AAD465C6CBE4F96D9FB98573A79A6024B1591@FMSMSX108.amr.corp.intel.com>
 <56B14F6B.7050405@redhat.com> <56B15DA5.3010505@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0079.outbound.protection.outlook.com ([207.46.100.79]:38763
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754866AbcBCCaf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Feb 2016 21:30:35 -0500
In-Reply-To: <56B15DA5.3010505@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>, Mark Nelson <mnelson@redhat.com>, "Moreno, Orlando" <orlando.moreno@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Blinick, Stephen L" <stephen.l.blinick@intel.com>

Josh,
At least from my past experience message signing was taking lot of cpus and all of our performance run we disabled that.
Never tested with Infernalis/master though by enabling auth/signatures and see the impact..
Thanks Orlando for sharing this..

Thanks & Regards
Somnath

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Josh Durgin
Sent: Tuesday, February 02, 2016 5:54 PM
To: Mark Nelson; Moreno, Orlando; ceph-devel@vger.kernel.org
Cc: Blinick, Stephen L
Subject: Re: Infernalis on NVMe cephx authentication impact

On 02/02/2016 04:52 PM, Mark Nelson wrote:
> Hi Orlando,
>
> Hrm, looks like https://github.com/ceph/ceph/pull/3896 didn't make it
> into Hammer at release. :(  That might also account for a large part
> of the performance disparity.  Coincidentally Josh Durgin made a
> branch with the PR backported to hammer a couple of weeks ago here:
>
> https://github.com/ceph/ceph/commits/wip-auth-hammer

Turns out it fixes a bug [0] in addition to being faster, so expect it in a future hammer release.

Has anyone measured the overhead of message signing (the 'cephx sign messages' option)? It's on by default with cephx, but can be disabled separately. What auth settings were these tests using?

It may be worth requiring message signatures by default now that it's been supported in the kernel client since 3.19.

Josh

[0] http://tracker.ceph.com/issues/14620
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
