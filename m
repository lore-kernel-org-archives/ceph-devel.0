From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: getting started with RADOSGW
Date: Sun, 22 Jul 2012 09:31:26 -0700
Message-ID: <CAC-hyiEXayeDOTJ-SpvF5Le9B22-ZP_nfpa1xrkAUoVeuYX6iQ@mail.gmail.com>
References: <CABZB-shn=RtKNFyXEaK5difh=NTfUVzgiF7DGJ8fJJSGO+5pFQ@mail.gmail.com>
	<CAC-hyiGaY6b=3PgY2jANMLM6ALLbe02j9KfWv7vR9JLW5q2XAA@mail.gmail.com>
	<CABZB-shPO1L1Xs9SM6qF3-4c=xpVx7EWjd9i_x8EqTU6M0C5Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:57382 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081Ab2GVQb2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Jul 2012 12:31:28 -0400
Received: by bkwj10 with SMTP id j10so4552902bkw.19
        for <ceph-devel@vger.kernel.org>; Sun, 22 Jul 2012 09:31:27 -0700 (PDT)
In-Reply-To: <CABZB-shPO1L1Xs9SM6qF3-4c=xpVx7EWjd9i_x8EqTU6M0C5Dg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jonathan Proulx <jon@jonproulx.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Jul 22, 2012 at 8:46 AM, Jonathan Proulx <jon@jonproulx.com> wrote:
> On Sun, Jul 22, 2012 at 10:59 AM, Yehuda Sadeh <yehuda@inktank.com> wrote:
>
>> I think you've set up your apache to use external fastcgi, but you
>> have to run radosgw manually using this method.
>
> Spot on, thanks for the quick response.  By radosgw init script was
> quietly exiting because I was using FQDN in ceph.conf but it was
> trying to match on the short name.  Now it's failing to start, but at
> least logging why.
>
> 2012-07-22 11:32:39.636760 7fd2b9be9780  0 librados:
> client.radosgw.gateway authentication error (1) Operation not
> permitted
> 2012-07-22 11:32:39.637018 7fd2b9be9780 -1 Couldn't init storage
> provider (RADOS)
>
> are these the right capabilities for that user
> (http://ceph.com/docs/master/radosgw/config suggests they are)?
>
> client.rados.gateway
>         key: <redacted>
>         caps: [mon] allow r
>         caps: [osd] allow rwx

I think the radosgw needs the 'w' cap for the monitor for
automatically creating the rados pools. Though it may be that you'd be
better off creating the pools yourself with the required amount of pgs
than letting it do that by itself, as the default number of pgs that
will be created is very low.

>
> ceph.conf points to /etc/ceph/keyring.rados.gateway which has is
> readable and has matching key
>
Try running 'ceph auth list' and see if you see the auth info for that
user. If not then you'll need to 'ceph auth add' that keyring.

Yehuda
