From: Owen Synge <osynge@suse.com>
Subject: Re: systemd status
Date: Fri, 31 Jul 2015 15:29:04 +0200
Message-ID: <55BB7820.1090006@suse.com>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net>	<CACkq2mr0aU+X_KDKGeQFy=sdtmRyy7CSR5tKHxYGyUFAA6kfEQ@mail.gmail.com>	<mpad83$pu4$1@ger.gmane.org>	<alpine.DEB.2.00.1507290550250.22099@cobra.newdream.net>	<mpampk$1pq$1@ger.gmane.org>	<alpine.DEB.2.00.1507290715450.22099@cobra.newdream.net>	<mpao1u$pe2$1@ger.gmane.org>	<alpine.DEB.2.00.1507290748290.22099@cobra.newdream.net>	<mpaqqd$blm$1@ger.gmane.org> <CAGtbiz1=yV8sW7d3Jc42NgUNdHXuakzM5RyfCkgCVXpOWRYykw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [89.191.203.168] ([89.191.203.168]:20270 "EHLO
	mail.emea.novell.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751074AbbGaNbE (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Fri, 31 Jul 2015 09:31:04 -0400
In-Reply-To: <CAGtbiz1=yV8sW7d3Jc42NgUNdHXuakzM5RyfCkgCVXpOWRYykw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vasiliy Angapov <angapov@gmail.com>, ceph-devel@vger.kernel.org



On 07/29/2015 06:50 PM, Vasiliy Angapov wrote:
> Hi colleagues,
> 
> I see some systemd-related actions here. Can you please also have a
> look at how I managed to rule Ceph with systemd -
> https://github.com/angapov/ceph-systemd/ ?
> It uses systemd generator script, which is called every time host
> boots up or when we issue "systemctl daemon-reload". It automates all
> the routine job of adding/removing systemd unit files. It also has a
> convenient ceph-osd and ceph-mon targets, which allows to start/stop
> OSDs/MONs all at once.
> I got production cluster working with it already, so this is fine for
> me. It handles only OSD and MON daemons for the moment but RGW can be
> added in a seconds.
> 
> The idea of systemd generators adds much more flexibility to Ceph like
> the original init script has.

I have tried to use generators some time ago, but since all generators
where run before root was mounted, or disks where detected, this caused
issues on rebooting.

How did you work around this? If you didnt what OS and version of
systemd are you using?

Best regards

Owen
