From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: git ceph "errno=Connection timed out"
Date: Wed, 18 May 2011 09:15:18 +0000
Message-ID: <1305710118.4502.0.camel@localhost>
References: <1305641664.1606.14.camel@localhost>
	 <BANLkTimsi4NQ4t1LUp6nkDt3E-e-F-TwFw@mail.gmail.com>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:8095 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932082Ab1ERBPQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2011 21:15:16 -0400
In-Reply-To: <BANLkTimsi4NQ4t1LUp6nkDt3E-e-F-TwFw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi greg ,
Thanks.
Jeff

On Tue, 2011-05-17 at 19:30 +0800, Gregory Farnum wrote:
> On Tue, May 17, 2011 at 7:14 AM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
> > Hi ,
> >
> > Does anybody run into the following issue to checkout ceph ?
> > I couldn't git ceph for several days.
> >
> > -------------------------------------------------------
> >
> > $ git clone git://ceph.newdream.net/git/ceph.git
> > Cloning into ceph...
> > ceph.newdream.net[0: 208.113.190.86]: errno=Connection timed out
> > fatal: unable to connect a socket (Connection timed out)
> > $
> Hasn't been a problem for me and I just tried now over a cell
> connection. Did you see if you could ping it at any point?
> -Greg

