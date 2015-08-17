From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Package issue in hammer branch on ubuntu
Date: Mon, 17 Aug 2015 16:11:49 -0600
Message-ID: <CALqRxCz8YFAPveyUCemzLuXpUB=VNVE_NfmPsetUapipZ7Gw0A@mail.gmail.com>
References: <C226B0AB34511445928D9882AA519F601C46FF47@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35847 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbbHQWLu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Aug 2015 18:11:50 -0400
Received: by oiev193 with SMTP id v193so88825996oie.3
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2015 15:11:49 -0700 (PDT)
In-Reply-To: <C226B0AB34511445928D9882AA519F601C46FF47@SACMBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Varada Kari <Varada.Kari@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Aug 17, 2015 at 3:58 AM, Varada Kari <Varada.Kari@sandisk.com> wrote:
> Seems in debian/control , ceph version is mentioned as 0.94.2-2 than
> 0.94.2-1. Change log files contains the build till 0.94.2-1. Made the
> following change, my installation went through.

It sounds like you're patching Ceph and doing your own build?

If that's the case, add a new debian/changelog entry for 0.94.2-2,
describing your changes.

You just need to bump the version to something >=2 .

- Ken
