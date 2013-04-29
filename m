From: James Page <james.page@canonical.com>
Subject: Re: [ceph-users] Backporting the kernel client
Date: Mon, 29 Apr 2013 16:05:13 +0100
Message-ID: <517E8C29.1020707@canonical.com>
References: <alpine.DEB.2.02.1304291544340.23141@orbit.lan> <CABBk=J8CCB6JtGAFxoMbgZ1R3sWtTvotXOw+fPwNSkr6wHWcjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:39827 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab3D2PFR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Apr 2013 11:05:17 -0400
In-Reply-To: <CABBk=J8CCB6JtGAFxoMbgZ1R3sWtTvotXOw+fPwNSkr6wHWcjg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Juha Aatrokoski <jha@kurp.hut.fi>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi Juha

On 29/04/13 15:29, Yehuda Sadeh wrote:
> On Mon, Apr 29, 2013 at 6:16 AM, Juha Aatrokoski<jha@kurp.hut.fi>  wrote:
>> >I'm probably not the only one who would like to run a distribution-provided
>> >kernel (which for Debian Wheezy/Ubuntu Precise is 3.2) and still have a
>> >recent-enough Ceph kernel client. So I'm wondering whether it's feasible to
>> >backport the kernel client to an earlier kernel. The plan is as follows:

Ubuntu 12.04 now includes Hardware Enablement Kernels from Quantal (3.5) 
and soon from Raring (3.8):

http://www.jorgecastro.org/2013/02/19/what-the-lts-enablement-stack-means-for-sysadmins/

This allows you to use a more recent, distro provided kernel than 3.2 
which should have the required fixes/features you need.

That said if you are having problems with the 3.2 kernel please do 
report bugs back to Ubuntu.

Cheers

James

-- 
James Page
Technical Lead
Ubuntu Server Team
james.page@canonical.com
