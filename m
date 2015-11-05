From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Request for Comments: Weighted Round Robin OP Queue
Date: Thu, 5 Nov 2015 07:46:51 -0800
Message-ID: <CAJ4mKGb4Bysx3+pWs_yS7=_yydxaM+4h-pmZGVbvUt=3nHXZGg@mail.gmail.com>
References: <CAANLjFq4MdaO5NrK346wxMfThy9MKy-6NzB3_BRTicSWc2uh7w@mail.gmail.com>
	<CAN=+7FWJ2aH1mRg7Z4P2o9f7hB7q2MHE6rBzyeR9Yrnf8qh3jA@mail.gmail.com>
	<CAANLjFpBzV921FaCitr8f7rWYa5tCHTihjFmFa_dY76cYVxMFw@mail.gmail.com>
	<CAJ4mKGbaYX+RqZ9iZmTi6nDkhiLBfXRoX4a4R33JeLtMz-jxbw@mail.gmail.com>
	<CAANLjFo8RiTqmQJEbr5O082613pNGsu3-YM0VX-tToY-YPBfuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37897 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756303AbbKEPqx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Nov 2015 10:46:53 -0500
Received: by wmeg8 with SMTP id g8so17105398wme.1
        for <ceph-devel@vger.kernel.org>; Thu, 05 Nov 2015 07:46:52 -0800 (PST)
In-Reply-To: <CAANLjFo8RiTqmQJEbr5O082613pNGsu3-YM0VX-tToY-YPBfuQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Nov 5, 2015 at 7:14 AM, Robert LeBlanc <robert@leblancnet.us> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Thanks Gregory,
>
> People are most likely busy and haven't had time to digest this and I
> may be expecting more excitement from it (I'm excited due to the
> results and probably also that such a large change still works). I'll
> keep working towards a PR, this was mostly proof of concept, now that
> there is some data I'll clean up the code.
>
> I was thinking that a config option to choose the scheduler would be a
> good idea. In terms of the project what is the better approach: create
> a new template and each place the template class is instantiated
> select the queue, or perform the queue selection in the same template
> class, or something else I haven't thought of.
>
> Are there public teuthology-openstack systems that could be used for
> testing? I don't remember, I'll have to search back through the
> mailing list archives.

Loic has sent some emails about this. It's a way to invoke the ceph
tests on an openstack cluster of your choice. I think he said a
reasonable rados run costs ~$20 on ovh? (You'll want to make sure to
use the subset functionality so it doesn't do the full geometric
expansion of the possible test combinations.)
-Greg
