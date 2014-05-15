From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-users] Does CEPH rely on any multicasting?
Date: Thu, 15 May 2014 09:55:48 -0700
Message-ID: <CAPYLRzhUJTma_g+WP0TsCCdVR4ROYwWiO-FfiR6WCssuqndcvA@mail.gmail.com>
References: <CADgBPFAc6mSy5qnvgoo7SEwEH-0cM7tPq7dUwj0V3XsX3CqfCw@mail.gmail.com>
	<CADgBPFDb8Eqy4xi=MynHzwdqmrOoomCmoo769CsB3OtzASnE+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:43765 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752AbaEOQzs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 May 2014 12:55:48 -0400
Received: by mail-qc0-f178.google.com with SMTP id l6so2295879qcy.9
        for <ceph-devel@vger.kernel.org>; Thu, 15 May 2014 09:55:48 -0700 (PDT)
In-Reply-To: <CADgBPFDb8Eqy4xi=MynHzwdqmrOoomCmoo769CsB3OtzASnE+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amit Vijairania <amit.vijairania@gmail.com>
Cc: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, May 15, 2014 at 9:52 AM, Amit Vijairania
<amit.vijairania@gmail.com> wrote:
> Hello!
>
> Does CEPH rely on any multicasting?  Appreciate the feedback..

Nope! All networking is point-to-point.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
