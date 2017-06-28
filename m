From: Sage Weil <sage@newdream.net>
Subject: Re: Minor doc nits for Luminous upgrade
Date: Wed, 28 Jun 2017 13:48:41 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706281347180.3424@piezo.novalocal>
References: <a29ea0cb-a1b8-9c26-ae4c-9ff91ba6a917@catalyst.net.nz> <CAEw75dMcOjzfZFYWhPpo4yRfpU7ReN6a_gg5a7vKbm61Bn=X9A@mail.gmail.com> <8d60d33f-babc-2a56-73f8-8f3547ee08e4@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57160 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbdF1Nsu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jun 2017 09:48:50 -0400
In-Reply-To: <8d60d33f-babc-2a56-73f8-8f3547ee08e4@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Cc: Abhishek L <abhishek.lekshmanan@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 28 Jun 2017, Mark Kirkwood wrote:
> On 28/06/17 16:23, Abhishek L wrote:
> > On Wed, Jun 28, 2017 at 3:07 AM, Mark Kirkwood
> > <mark.kirkwood@catalyst.net.nz> wrote:
> > > 
> > > 1/ Mon feature list
> > > 
> > > <# ceph mon feature ls
> > > > # ceph mon feature list
> > While the final feature of release and the next RC will feature the
> > `ls` version, this  RC still had the older list version, I've made a
> > correction to the blog entry.
> > 
> > 
> I'm not sure I've been clear with this point, but the 'ls' command does not
> work if you are upgrading from Jewel - surely this is a) a problem and b) a
> very likely upgrade path!

The first rc 12.1.0 has 'mon feature list' instead of 'mon feature ls'; 
the command was renamed right after the release was tagged to be more 
consistent with other cli commands.  (Can you confirm that 'mon feature 
list' works?)

The command should start working as soon as the monitors are upgraded to 
luminous.

sage

