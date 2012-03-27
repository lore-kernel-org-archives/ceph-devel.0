From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Unmount btrfs when stopping OSD's
Date: Tue, 27 Mar 2012 12:25:16 -0700
Message-ID: <CAORUGqC6WWOT5=tOFD74EEeoUx5k8qJTwrZnpyZwxkbPPhccJg@mail.gmail.com>
References: <4F71CCBD.4070501@widodh.nl> <CAORUGqB91F4qifOtCKMWcJ_9FxxRUZK_WVS9mAaMC3Y-40uWfg@mail.gmail.com>
 <4F721081.8010100@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34871 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659Ab2C0TZg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Mar 2012 15:25:36 -0400
Received: by pbcun15 with SMTP id un15so595563pbc.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Mar 2012 12:25:36 -0700 (PDT)
In-Reply-To: <4F721081.8010100@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Mar 27, 2012 at 12:09, Wido den Hollander <wido@widodh.nl> wrote:
> Any plans yet on removing "btrfs devs" from the configuration?

It's a low-priority cleanup, but it will happen.
