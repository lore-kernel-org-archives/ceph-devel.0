From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: git ceph "errno=Connection timed out"
Date: Tue, 17 May 2011 04:30:54 -0700
Message-ID: <BANLkTimsi4NQ4t1LUp6nkDt3E-e-F-TwFw@mail.gmail.com>
References: <1305641664.1606.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:60050 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848Ab1EQLa5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 May 2011 07:30:57 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id D6998C0E1
	for <ceph-devel@vger.kernel.org>; Tue, 17 May 2011 04:30:56 -0700 (PDT)
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by mail.hq.newdream.net (Postfix) with ESMTP id 859D9C0DE
	for <ceph-devel@vger.kernel.org>; Tue, 17 May 2011 04:30:56 -0700 (PDT)
Received: by eyx24 with SMTP id 24so105102eyx.19
        for <ceph-devel@vger.kernel.org>; Tue, 17 May 2011 04:30:55 -0700 (PDT)
In-Reply-To: <1305641664.1606.14.camel@localhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cpwu@tnsoft.com.cn
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, May 17, 2011 at 7:14 AM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
> Hi ,
>
> Does anybody run into the following issue to checkout ceph ?
> I couldn't git ceph for several days.
>
> -------------------------------------------------------
>
> $ git clone git://ceph.newdream.net/git/ceph.git
> Cloning into ceph...
> ceph.newdream.net[0: 208.113.190.86]: errno=Connection timed out
> fatal: unable to connect a socket (Connection timed out)
> $
Hasn't been a problem for me and I just tried now over a cell
connection. Did you see if you could ping it at any point?
-Greg
