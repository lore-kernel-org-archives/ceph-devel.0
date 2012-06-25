From: Tommi Virtanen <tv@inktank.com>
Subject: Re: Unable to restart Mon after reboot
Date: Mon, 25 Jun 2012 08:58:13 -0700
Message-ID: <CADvuQRFcgPOy765-cYSVT1DPjOZ5nPXSb1Lr1Xjt5e3rU7joNw@mail.gmail.com>
References: <BDAE812E-2659-4025-9B30-2DEC6675B59A@100percentit.com>
 <4FE55567.6080201@inktank.com> <4FE558CB.4010509@inktank.com> <F38AD123-3C97-44BD-ABE5-33635AD6D768@100percentit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57314 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022Ab2FYP6f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jun 2012 11:58:35 -0400
Received: by dady13 with SMTP id y13so5505279dad.19
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jun 2012 08:58:34 -0700 (PDT)
In-Reply-To: <F38AD123-3C97-44BD-ABE5-33635AD6D768@100percentit.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Blundell <David.Blundell@100percentit.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Jun 23, 2012 at 3:43 AM, David Blundell
<David.Blundell@100percentit.com> wrote:
> The logs on all three servers are full of messages like:
> Jun 23 04:02:19 Store2 kernel: [63811.494955] ceph-osd: page allocation failure: order:3, mode:0x4020
>
> The difference between the lines is that order: varies between 2, 3, 4 or 5
>
> Is this likely to be a btrfs bug?

That means you're running out of memory, in kernelspace. The order is
the power-of-two (2**n) of how many 4kB pages were requested, 0x4020 =
GFP_COMP|GFP_HIGH (compound & access emergency pools). Btrfs may be
indirectly related, it's not clear what's consuming all the memory,
but that doesn't sound all that likely. That message should be
followed by a stack dump, that might tell us more.

Are you using the Ceph distributed filesystem, or just the RADOS
level, e.g. RBD images?
