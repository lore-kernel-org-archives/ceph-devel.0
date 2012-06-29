From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph performance under xen?
Date: Fri, 29 Jun 2012 11:55:03 -0700
Message-ID: <CAPYLRzgMAPuTKOeZC78J48V1wCuL_7v-5Aj6YQX2Q=0BgQ5Cuw@mail.gmail.com>
References: <CAMsVa3t8foWYguozDeFCiHf0jrK6b2+L4pKtU__-G1mTVVHzWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44037 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072Ab2F2SzE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jun 2012 14:55:04 -0400
Received: by lbbgm6 with SMTP id gm6so5016966lbb.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jun 2012 11:55:03 -0700 (PDT)
In-Reply-To: <CAMsVa3t8foWYguozDeFCiHf0jrK6b2+L4pKtU__-G1mTVVHzWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Edmonds <mornir@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, Jun 28, 2012 at 7:27 AM, Brian Edmonds <mornir@gmail.com> wrote=
:
> I've installed a little, four node Ceph (0.47.2) cluster using Xen
> virtual machines for testing, and when I run bonnie against a (kernel
> driver) mount of it, it seems to be somewhat flaky (disturbing log
> messages, occasional binary deaths), and very slow. =A0I expected som=
e
> slowness, with all the virtualization going on, but when bonnie is
> running, simply doing a cd into the mount takes minutes to complete.
> Is this to be expected, or is it worth spending time to investigate?
> I intend to deploy this on bare metal eventually, but was hoping to
> get some operational experience with Ceph before investing the money
> in that.

So right now you're using the Ceph filesystem, rather than RBD, right?
What processes do you have running on which machines/VMs? What's the
CPU usage on the ceph-mds process?

And a warning: the filesystem, while nifty, is not yet
production-ready =97 it works great for some use cases but there are
some serious known bugs that aren't very hard to trigger, as we've
been doing a lot of QA on RADOS and its associated systems (which the
filesystem depends on) at the expense of the filesystem itself.

-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
