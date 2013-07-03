From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH 1/3] libceph: call r_unsafe_callback when unsafe reply is received
Date: Thu, 4 Jul 2013 06:43:30 +0800
Message-ID: <CAAM7YAnVZhTa6LQWo9KzMGHdkYCrwAQJLweJUBEm=dUaVqA5bA@mail.gmail.com>
References: <1372056089-11603-1-git-send-email-zheng.z.yan@intel.com>
	<51D12FA7.1090605@intel.com>
	<alpine.DEB.2.00.1307011245410.11177@cobra.newdream.net>
	<alpine.DEB.2.00.1307031455220.3375@cobra.newdream.net>
	<CANP1eJFe+d-UM4vSOSLiFP07NrbXGUeD1TNaXusSLrEo8HEXTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:50869 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932278Ab3GCWnb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jul 2013 18:43:31 -0400
Received: by mail-la0-f46.google.com with SMTP id eg20so650316lab.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Jul 2013 15:43:30 -0700 (PDT)
In-Reply-To: <CANP1eJFe+d-UM4vSOSLiFP07NrbXGUeD1TNaXusSLrEo8HEXTQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>, Alex Elder <alex.elder@linaro.org>, Sage Weil <sage@inktank.com>

On Thu, Jul 4, 2013 at 6:07 AM, Milosz Tanski <milosz@adfin.com> wrote:
> Yan,
>
> Can you help me understand how this change fixes:
> http://tracker.ceph.com/issues/2019 ? The symptom on the client is
> that the processes get stuck waiting in ceph_mdsc_do_request according
> to /proc/PID/stack.

The bug this patch fixes is that ceph_sync_write_unsafe can be called
multiple times
with parameter unsafe=true. The bug prevents the kclient from
releasing Fw cap, further
lead to filelock stuck in unstable state forever and request hang.

Yan, Zheng
