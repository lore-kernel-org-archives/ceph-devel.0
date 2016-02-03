From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Backporting stability fixes for ceph-disk
Date: Wed, 3 Feb 2016 10:56:46 -0700
Message-ID: <CALqRxCyTk5NPQJE7PTX4txbCPB2eagMBvH+V9HLHXkir4hij4g@mail.gmail.com>
References: <56B04476.5020203@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38081 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964787AbcBCR4s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 12:56:48 -0500
Received: by mail-wm0-f45.google.com with SMTP id p63so82337525wmp.1
        for <ceph-devel@vger.kernel.org>; Wed, 03 Feb 2016 09:56:47 -0800 (PST)
In-Reply-To: <56B04476.5020203@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <ldachary@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

Thanks for explaining the differences between Hammer's disk
activations and Jewel's. I think I understand the problem better now.

On Mon, Feb 1, 2016 at 10:53 PM, Loic Dachary <ldachary@redhat.com> wrote:
> The conservative approach to the problem would be to cherry-pick what
> we can (
> https://github.com/dachary/ceph/commit/9dce05a8cdfc564c5162885bbb67a04ad7b95c5a
> for instance ) and document known side effects of ceph-disk
> instability so people know it's an annoyance but nothing destructive
> or blocking. In the worst case scenario, deactivating the udev rules
> and running ceph-disk prepare + ceph-disk activate manually or by
> writing a script that does things sequentially is a viable workaround.

This approach (documentation) sounds reasonable to me, and it makes
sense that the larger re-architecture of running "ceph-disk activate"
outside udev is only something that can happen in a major release
boundary (in this case Infernalis / Jewel). Once we're happy that the
docs for manually recovering are solid, we can possibly address it
with a script as you suggest.

If we can document the worst case scenario and what to do when
ceph-disk-in-udev fails, that would really improve the user
experience.

What's the procedure for deactivating the Hammer udev rules, for example?

- Ken
