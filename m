From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: maintanance on osd host
Date: Fri, 1 Mar 2013 21:38:06 +0100
Message-ID: <CAF6-1L5Snv7xgp8U54n7baBnhEyZ6G4Sg1bQgcJgdO_Au5qcbg@mail.gmail.com>
References: <512CCD19.7010509@profihost.ag>
	<alpine.DEB.2.00.1302260904440.2730@cobra.newdream.net>
	<727CEF0E-7D1E-4298-B0E4-9729CAA4E787@profihost.ag>
	<alpine.DEB.2.00.1302260922510.4819@cobra.newdream.net>
	<512D10AA.2020906@profihost.ag>
	<CAPYLRzi+Mrcyp-Nd8C-hqBWfUAvSCNOYY8PE9Po7uPfPTcS9EQ@mail.gmail.com>
	<512DB7A5.3090500@profihost.ag>
	<CAPYLRzh4YFTuZ4rrewYPX3j0kg6bA2bSuyhrKtJ=3SRYHOTgdg@mail.gmail.com>
	<CAM2gkg7Eyt=-Qjys8JtvpNGzYHb9PN-yKaEmNCP+tavd1jwirg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:52034 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab3CAUiI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Mar 2013 15:38:08 -0500
Received: by mail-bk0-f52.google.com with SMTP id jk13so1516217bkc.25
        for <ceph-devel@vger.kernel.org>; Fri, 01 Mar 2013 12:38:06 -0800 (PST)
In-Reply-To: <CAM2gkg7Eyt=-Qjys8JtvpNGzYHb9PN-yKaEmNCP+tavd1jwirg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Wilkins <john.wilkins@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

> I have it documented here:
>
> http://ceph.com/docs/master/rados/operations/troubleshooting-osd/#stopping-w-out-rebalancing

That looks wrong to me

AFAIU it should be 'noout'. You want it marked down ASAP.

Cheers,

    Sylvain
