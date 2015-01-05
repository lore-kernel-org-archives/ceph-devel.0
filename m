From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: Ceph-client branch for Ubuntu 14.04.1 LTS (3.13.0-x kernels)
Date: Mon, 5 Jan 2015 23:33:38 +0300
Message-ID: <CALFYKtC+7EDJg-J3PnvoedkrSoak1cnHN6+aejsZE91E0dcFCg@mail.gmail.com>
References: <9E914F5BD7F48A4782456CEB550A42280A758A6D@SACMBXIP01.sdcorp.global.sandisk.com>
	<CALFYKtAxr9AbPR_DJp9EBTZ+FX4+d9dwhk89M74VRDK2Gq3E1g@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F28271DE7@SACMBXIP02.sdcorp.global.sandisk.com>
	<CALFYKtCTg7qPF76qnGLEFYoKN73tGhVD+RNr7a2v486FURNC-Q@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F28271FF7@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:61898 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbbAEUdj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Jan 2015 15:33:39 -0500
Received: by mail-qa0-f45.google.com with SMTP id f12so14091838qad.18
        for <ceph-devel@vger.kernel.org>; Mon, 05 Jan 2015 12:33:38 -0800 (PST)
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F28271FF7@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jan 5, 2015 at 11:01 PM, Somnath Roy <Somnath.Roy@sandisk.com> wrote:
> Ilya,
> Here is the steps..
>
> 1. You have a cluster (3 nodes) and replication is 3
>
> 2. map krbd image to a client.
>
> 3. Reboot or stop ceph services on one or more nodes
>
> 4. The client with krbd mapped module crashes

Is it idle or under load?

Do you have a trace of the crash?

Thanks,

                Ilya
