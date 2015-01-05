From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: Ceph-client branch for Ubuntu 14.04.1 LTS (3.13.0-x kernels)
Date: Mon, 5 Jan 2015 18:57:41 +0300
Message-ID: <CALFYKtAxr9AbPR_DJp9EBTZ+FX4+d9dwhk89M74VRDK2Gq3E1g@mail.gmail.com>
References: <9E914F5BD7F48A4782456CEB550A42280A758A6D@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:51270 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbbAEP5m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 10:57:42 -0500
Received: by mail-qg0-f53.google.com with SMTP id l89so15239217qgf.26
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jan 2015 07:57:41 -0800 (PST)
In-Reply-To: <9E914F5BD7F48A4782456CEB550A42280A758A6D@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jan 5, 2015 at 1:53 PM, Chaitanya Huilgol
<Chaitanya.Huilgol@sandisk.com> wrote:
> Hi All,
>
> The stock ceph-client modules with Ubuntu 14.04 LTS are quite dated and we are seeing crashes and soft-lockup issues which have been fixed in the current ceph-client code base.
> What would be recommended ceph-client branch compatible with the Ubuntu 14.04 (3.13.0-x) kernels so that we can get as many fixes as possible?

We actively mark rbd (not so much cephfs) fixes for stable and Ubuntu
kernel team generally picks them up.  3.13 series should have most of
the important fixes, although I haven't counted.

What issues in particular you are running into?  uname -a?

Thanks,

                Ilya
