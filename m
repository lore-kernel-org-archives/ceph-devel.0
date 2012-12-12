From: Gregory Farnum <greg@inktank.com>
Subject: Re: ceph osd create XX
Date: Wed, 12 Dec 2012 14:09:12 -0800
Message-ID: <CAPYLRzhq2DMvRoLPsEG0FJ-AejwQ7KyjhZs8iwZbEtecUpA6Ug@mail.gmail.com>
References: <50C8F7AC.9070600@profihost.ag>
	<CAPYLRzjntgh+CHXbtoRvLHhvjo1wqT9F16vshsiBhLcYebUB-Q@mail.gmail.com>
	<50C8F939.6080400@profihost.ag>
	<CAPYLRzjvZWx4T4T9OHPwaY_4cuOuZW2pgPDpwVR-1Afvi=-LeA@mail.gmail.com>
	<50C8FA80.7060808@profihost.ag>
	<CAPYLRzifpCB77z=YjbcxAPJ2TRF-NfH+MzgCbnGhFxrBLLs17Q@mail.gmail.com>
	<50C8FE97.4020302@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:65280 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318Ab2LLWJM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Dec 2012 17:09:12 -0500
Received: by mail-ie0-f181.google.com with SMTP id 16so3030080iea.12
        for <ceph-devel@vger.kernel.org>; Wed, 12 Dec 2012 14:09:12 -0800 (PST)
In-Reply-To: <50C8FE97.4020302@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: John Wilkins <john.wilkins@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Dec 12, 2012 at 2:00 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> Hi Greg,
>
> thanks for explanation. I'm using current next branch.
>
> I'm using:
> host1:
> osd 11 .. 14
> host2:
> osd 21 .. 24
> host3:
> osd 31 .. 34
> host4:
> osd 41 .. 44
> host5:
> osd 51 .. 54
>
> Right now i want to add host6. But i still don't know even with your
> explanation how to add osd 61-64 to osdmap.

Yeah, it's not going to let you allocate non-sequential IDs at this
point, sorry. We are slowly divorcing the ID and the name, but it's
not done yet...
