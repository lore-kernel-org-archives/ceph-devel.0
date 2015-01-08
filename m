From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: Ceph-client branch for Ubuntu 14.04.1 LTS (3.13.0-x kernels)
Date: Thu, 8 Jan 2015 11:22:20 +0300
Message-ID: <CALFYKtDy2YxNgXkmxOh4OcbtbuYNU5Bku-rN64miShrDYqYk1A@mail.gmail.com>
References: <9E914F5BD7F48A4782456CEB550A42280A758A6D@SACMBXIP01.sdcorp.global.sandisk.com>
	<CALFYKtAxr9AbPR_DJp9EBTZ+FX4+d9dwhk89M74VRDK2Gq3E1g@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F28271DE7@SACMBXIP02.sdcorp.global.sandisk.com>
	<CALFYKtCTg7qPF76qnGLEFYoKN73tGhVD+RNr7a2v486FURNC-Q@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F28271FF7@SACMBXIP02.sdcorp.global.sandisk.com>
	<CALFYKtC+7EDJg-J3PnvoedkrSoak1cnHN6+aejsZE91E0dcFCg@mail.gmail.com>
	<755F6B91B3BE364F9BCA11EA3F9E0C6F2827201B@SACMBXIP02.sdcorp.global.sandisk.com>
	<9E914F5BD7F48A4782456CEB550A42280A75905D@SACMBXIP01.sdcorp.global.sandisk.com>
	<CALFYKtAs+685rxyJx0dasHprMatLUeLyv7oq397Ty2SiJ_uCCw@mail.gmail.com>
	<9E914F5BD7F48A4782456CEB550A42280A759A1A@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:34758 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114AbbAHIWV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jan 2015 03:22:21 -0500
Received: by mail-qa0-f42.google.com with SMTP id n8so6332512qaq.1
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jan 2015 00:22:20 -0800 (PST)
In-Reply-To: <9E914F5BD7F48A4782456CEB550A42280A759A1A@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jan 8, 2015 at 6:30 AM, Chaitanya Huilgol
<Chaitanya.Huilgol@sandisk.com> wrote:
> We have hit issue-2 to on the rhel7a code base (soft lockup in ceph_osdc_handle_map, when large number of osds were flapping due to spurious heartbeat failures).  We have not been able to reproduce other issues.

Can I see the entire dmesg of a boot when it happened on rhel7-a?

> On a side-note, are the changes in the ceph-client rhel7a branch being actively pulled into the rhel7/centos7 kernel updated?

All of rhel7-a is on its way to rhel7.1 I think.  Not sure about centos.

Thanks,

                Ilya
