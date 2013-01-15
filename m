From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Another rbd compatibility issue between 0.48.2argonaut-2 and
 0.56.1 ?
Date: Tue, 15 Jan 2013 11:42:03 -0800
Message-ID: <50F5B10B.5060601@inktank.com>
References: <50F3B0E7.3090809@fremaks.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:38596 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab3AOTnM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 14:43:12 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so302001pad.2
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 11:43:12 -0800 (PST)
In-Reply-To: <50F3B0E7.3090809@fremaks.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Simon_Frerichs_=7C=A0Fremaks_GmbH?= <frerichs@fremaks.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 01/13/2013 11:16 PM, Simon Frerichs | Fremaks GmbH wrote:
> Hi,
>
> we've updated ceph on one node from argonaut to 0.56.1.
> The osds are working fine but i see the following error:
>
> rbd info kvm1395
> rbd: error opening image kvm1395: (5) Input/output error
> 2013-01-14 06:09:10.162206 7efff3aed760 -1 librbd: Error getting lock
> info: (5) Input/output error
>
> rbd --version
> ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)
>
> Switching rbd back to argonaut fixes this error.
>
> Any hints?

This was fixed in the next and master branches last week by
4483285c9fb16f09986e2e48b855cd3db869e33c, but this was after
0.56.1 was released. It should be in the next point release
if there is one.
