From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: Ceph-client branch for Ubuntu 14.04.1 LTS (3.13.0-x kernels)
Date: Mon, 5 Jan 2015 21:50:25 +0300
Message-ID: <CALFYKtCTg7qPF76qnGLEFYoKN73tGhVD+RNr7a2v486FURNC-Q@mail.gmail.com>
References: <9E914F5BD7F48A4782456CEB550A42280A758A6D@SACMBXIP01.sdcorp.global.sandisk.com>
	<CALFYKtAxr9AbPR_DJp9EBTZ+FX4+d9dwhk89M74VRDK2Gq3E1g@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F28271DE7@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:58126 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbbAESu0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 13:50:26 -0500
Received: by mail-qc0-f171.google.com with SMTP id r5so15714383qcx.2
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jan 2015 10:50:25 -0800 (PST)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F28271DE7@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jan 5, 2015 at 8:11 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Ilya,
> The main issue we are facing the krbd client crash in case of cluster node reboot. Is this fix backported to any 14.04 stable LTS kernel ?

I don't recall anything like that or at least phrased that way.
Can you give more details - crash traces at least?

Thanks,

                Ilya
