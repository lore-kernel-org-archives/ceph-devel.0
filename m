From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Unmount btrfs when stopping OSD's
Date: Tue, 27 Mar 2012 21:09:53 +0200
Message-ID: <4F721081.8010100@widodh.nl>
References: <4F71CCBD.4070501@widodh.nl> <CAORUGqB91F4qifOtCKMWcJ_9FxxRUZK_WVS9mAaMC3Y-40uWfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:51973 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604Ab2C0TKA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Mar 2012 15:10:00 -0400
In-Reply-To: <CAORUGqB91F4qifOtCKMWcJ_9FxxRUZK_WVS9mAaMC3Y-40uWfg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On 03/27/2012 08:50 PM, Tommi Virtanen wrote:
> On Tue, Mar 27, 2012 at 07:20, Wido den Hollander<wido@widodh.nl>  wrote:
>> When we start an OSD we automatically mount the btrfs filesystem if "btrfs
>> devs" is set, but we do not unmount when we stop the OSD.
> ...
>> I'd vote for setting this to 1 by default.
>
> btrfs_devs was meant to make Sage's development use easier. We don't
> want to support it on actual use (we'd need to expand it to cover all
> the filesystems, etc), and intend to remove it. Please do not use it
> -- we sure don't.
>
> The proper location for this functionality is in Chef/Puppet/etc automation.

Ah, I think I became a bit rusty with the old configuration :)

>
> Earlier conversation:
> http://marc.info/?l=ceph-devel&m=133044999403426&w=2

I've been following it, but not that closely.

Any plans yet on removing "btrfs devs" from the configuration?

Wido
