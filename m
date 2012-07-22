From: Jonathan Proulx <jon@jonproulx.com>
Subject: Re: getting started with RADOSGW
Date: Sun, 22 Jul 2012 11:46:42 -0400
Message-ID: <CABZB-shPO1L1Xs9SM6qF3-4c=xpVx7EWjd9i_x8EqTU6M0C5Dg@mail.gmail.com>
References: <CABZB-shn=RtKNFyXEaK5difh=NTfUVzgiF7DGJ8fJJSGO+5pFQ@mail.gmail.com>
	<CAC-hyiGaY6b=3PgY2jANMLM6ALLbe02j9KfWv7vR9JLW5q2XAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34339 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab2GVPqn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 22 Jul 2012 11:46:43 -0400
Received: by obbuo13 with SMTP id uo13so8077850obb.19
        for <ceph-devel@vger.kernel.org>; Sun, 22 Jul 2012 08:46:42 -0700 (PDT)
In-Reply-To: <CAC-hyiGaY6b=3PgY2jANMLM6ALLbe02j9KfWv7vR9JLW5q2XAA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Jul 22, 2012 at 10:59 AM, Yehuda Sadeh <yehuda@inktank.com> wrote:

> I think you've set up your apache to use external fastcgi, but you
> have to run radosgw manually using this method.

Spot on, thanks for the quick response.  By radosgw init script was
quietly exiting because I was using FQDN in ceph.conf but it was
trying to match on the short name.  Now it's failing to start, but at
least logging why.

2012-07-22 11:32:39.636760 7fd2b9be9780  0 librados:
client.radosgw.gateway authentication error (1) Operation not
permitted
2012-07-22 11:32:39.637018 7fd2b9be9780 -1 Couldn't init storage
provider (RADOS)

are these the right capabilities for that user
(http://ceph.com/docs/master/radosgw/config suggests they are)?

client.rados.gateway
	key: <redacted>
	caps: [mon] allow r
	caps: [osd] allow rwx

ceph.conf points to /etc/ceph/keyring.rados.gateway which has is
readable and has matching key

Thanks,
-Jon
