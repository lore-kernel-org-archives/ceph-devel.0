From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Unmount btrfs when stopping OSD's
Date: Tue, 27 Mar 2012 11:50:21 -0700
Message-ID: <CAORUGqB91F4qifOtCKMWcJ_9FxxRUZK_WVS9mAaMC3Y-40uWfg@mail.gmail.com>
References: <4F71CCBD.4070501@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34038 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab2C0Sum (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Mar 2012 14:50:42 -0400
Received: by pbcun15 with SMTP id un15so559583pbc.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Mar 2012 11:50:42 -0700 (PDT)
In-Reply-To: <4F71CCBD.4070501@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Mar 27, 2012 at 07:20, Wido den Hollander <wido@widodh.nl> wrote:
> When we start an OSD we automatically mount the btrfs filesystem if "btrfs
> devs" is set, but we do not unmount when we stop the OSD.
...
> I'd vote for setting this to 1 by default.

btrfs_devs was meant to make Sage's development use easier. We don't
want to support it on actual use (we'd need to expand it to cover all
the filesystems, etc), and intend to remove it. Please do not use it
-- we sure don't.

The proper location for this functionality is in Chef/Puppet/etc automation.

Earlier conversation:
http://marc.info/?l=ceph-devel&m=133044999403426&w=2
