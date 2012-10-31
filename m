From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RGW in Bobtail
Date: Wed, 31 Oct 2012 00:32:52 -0700
Message-ID: <CAC-hyiF=GdnZ92bh9gRJ=s3Fy2_Pd6WC8n3eFFTbFBwLst7bWw@mail.gmail.com>
References: <CAC-hyiG5hCVBx-_-S7ViK4FrKro+rJ+-mtKS=p0Kw_k0RvJHnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51215 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933359Ab2JaHcy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 03:32:54 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so478167bkc.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 00:32:52 -0700 (PDT)
In-Reply-To: <CAC-hyiG5hCVBx-_-S7ViK4FrKro+rJ+-mtKS=p0Kw_k0RvJHnw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Following on my own message:

On Tue, Oct 30, 2012 at 10:36 AM, Yehuda Sadeh <yehuda@inktank.com> wrote:

>  - Keystone
>
> This is not completely implemented yet, but it is likely that it will
> make it to Bobtail. We'll make it so that Swift authentication (and
> user management) will be able to go through Keystone.

This is going along nicely. There is one issue that we're not
completely sure which way to go though. The equivalent of a radosgw
'user' in keystone is a 'tenant'. A keystone tenant has an id, which
is a long random hex string and a name.
A user id that we'd use in radosgw is typically something less random,
which maps better to the keystone name. However, it seems that the
more correct way to go would be to map the radosgw user to the
keystone id and not to the keystone name.

Note that when mapping a radosgw user to the keystone tenant name, if
we'd remove a keystone tenant and recreate another one with the same
name, it'll map to the same radosgw user, whereas if we map the
radosgw user to the keystone tenant id, we'd be pointing at a
different user instance.


Any thoughts?


Yehuda
