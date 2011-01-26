From: Sage Weil <sage@newdream.net>
Subject: Re: Auto-striping feature
Date: Tue, 25 Jan 2011 20:32:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1101252031290.19989@cobra.newdream.net>
References: <1408EC05-75B0-4DD8-B6D6-7F5D10AAC096@gmail.com>
 <AANLkTinw9OZprRD8XoK9rjBm5Q_5aez8n-ZK75+hihYo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51720 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586Ab1AZEcL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jan 2011 23:32:11 -0500
In-Reply-To: <AANLkTinw9OZprRD8XoK9rjBm5Q_5aez8n-ZK75+hihYo@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Tatsuya Kawano <tatsuya6502@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 25 Jan 2011, Gregory Farnum wrote:
> On Tue, Jan 25, 2011 at 3:53 AM, Tatsuya Kawano <tatsuya6502@gmail.com> wrote:
> >
> > Hi,
> >
> > I have some questions about auto-striping feature in Ceph.
> >
> > - What is the default striping size?
> The default is to stripe the file across 4MB objects, 4MB at a time.
> You can also define your own striping strategy using cephfs. Make sure
> that "stripe_unit" * "stripe_count" equals "object_size".

Actually, you just need to make sure that object_size is a multiple of 
stripe_unit.  The striping strategy puts each stripe_unit on stripe_count 
consecutive objects until they reach a size of stripe_count; it then moves 
onto the next set of stripe_count objects.  The default degenerate case 
has stripe_unit == object_size and stripe_count == 1.

sage
