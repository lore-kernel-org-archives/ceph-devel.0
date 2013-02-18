From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [ceph-users] RGW Multipart Uplaods
Date: Mon, 18 Feb 2013 08:53:41 -0800
Message-ID: <CAC-hyiE_UAojZCDJ14BRn-hSN-RKJtNDSaaMfzhsPboF8NZ2vA@mail.gmail.com>
References: <512256AA.6070408@umiacs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:38247 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885Ab3BRQxn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Feb 2013 11:53:43 -0500
Received: by mail-lb0-f172.google.com with SMTP id n8so4477615lbj.17
        for <ceph-devel@vger.kernel.org>; Mon, 18 Feb 2013 08:53:42 -0800 (PST)
In-Reply-To: <512256AA.6070408@umiacs.umd.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: derek@umiacs.umd.edu
Cc: "ceph-users@ceph.com" <ceph-users@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Feb 18, 2013 at 8:28 AM, Derek Yarnell <derek@umiacs.umd.edu> wrote:
> Hi,
>
> I am trying to write some multipart parallel upload scripts.  I have run
> into an issue with listing the current multipart uploads.  Is this
> feature available in the current radosgw (0.56.3)?  I am able to upload
> using multipart when initiatiating the upload and then itterating over
> the chunks sequentially.  But when I try to iterate over a pool of
> chunks in parallel I can't call the listing of multipart uploads on the
> given bucket.
>
> The response I get back from the 'GET /?uploads HTTP/1.1' (the server is
> setup to handle bucket DNS names) is a 200 OK, with a XML
> <ListBucketResult> with the contents of the bucket.
>

The code is there, but looking at it right now, I see some issue. Try
doing 'GET /?uploadId HTTP/1.1' instead.

The fix is trivial, I opened issue #4177 for that. I'm also opening an
issue for fixing our test suite, as it was supposed to catch this
issue.

Thanks,
Yehuda
