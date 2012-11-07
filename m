From: Gregory Farnum <greg@inktank.com>
Subject: Re: Mons network
Date: Wed, 7 Nov 2012 16:22:54 +0100
Message-ID: <CAPYLRzj67=DQaoJ5pZmO0soauFmgiGx4MNjvnaPiMGkzzYKRzA@mail.gmail.com>
References: <CAJH6TXiqRbuX=8gKL9hkVd=9X3vZew5jFHwM8xe=wjpu7_+5-Q@mail.gmail.com>
	<CAPYLRzhvX3D4RUGmj=VT74=prLdxh0abeUOCGwiYOO0qQexhMQ@mail.gmail.com>
	<CAJH6TXhtkdQZPrX3sX96b7JvHjR42y1T4ig7qHnzniPaaF2_wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:57321 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab2KGPWy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 10:22:54 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so2500520iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Nov 2012 07:22:54 -0800 (PST)
In-Reply-To: <CAJH6TXhtkdQZPrX3sX96b7JvHjR42y1T4ig7qHnzniPaaF2_wA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Nov 7, 2012 at 4:20 PM, Gandalf Corvotempesta
<gandalf.corvotempesta@gmail.com> wrote:
> 2012/11/7 Gregory Farnum <greg@inktank.com>:
>> The mons need to be reachable by everybody. They don't do a ton of
>> network traffic, but 100Mb/s might be pushing it a bit low...
>
> Some portion of my network are 10/100 with gigabit uplink.
> In this portion we have many XenServer nodes that we would like to use
> for mons, but maximum speed of each is 100mbit
> Moving mons to the SAN will result in new hardware to buy.

Well, you can experiment with it and see what happens.
Or just colocate the monitors with some of your OSDs.
