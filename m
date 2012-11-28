From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: OSD and MON memory usage
Date: Thu, 29 Nov 2012 00:13:25 +0100
Message-ID: <CAF6-1L4rAv5z15HhdZLHW1Uhy1Cb+cxfVG3FSRoF1L5gDMJ1cA@mail.gmail.com>
References: <20121116172401.ef3e5e52.ctpm@ist.utl.pt>
	<50AFA848.4050109@inktank.com>
	<20121127172350.b6d21634.ctpm@ist.utl.pt>
	<CA+4uBUYv49DmX0EC5QovOtpgR5=TFM1xK4LPjp0M-8bM9B_0iA@mail.gmail.com>
	<20121128210501.cefc7b4c2877410803d81c7f@ist.utl.pt>
	<CA+4uBUZ4+vZt-BErOeBBFMunwQBsiJURaoPEFpJ5FDrXUmQ2jQ@mail.gmail.com>
	<20121128213032.183913c7e662741850918f32@ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:33026 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab2K1XN0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Nov 2012 18:13:26 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so13965606oag.19
        for <ceph-devel@vger.kernel.org>; Wed, 28 Nov 2012 15:13:25 -0800 (PST)
In-Reply-To: <20121128213032.183913c7e662741850918f32@ist.utl.pt>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Cl=E1udio_Martins?= <ctpm@ist.utl.pt>
Cc: Samuel Just <sam.just@inktank.com>, Joao Eduardo Luis <joao.luis@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

>  If you want, I can try to restart the whole thing tomorrow and collect
> fresh log output from the dying OSDs, or any other action or debug info
> that you might find useful.

Is the clock synchronized on all machines ?

What you describe (growing mem, recovery that doesn't seem to end)
seems pretty similar to what I experienced when clocks of OSD were off
...

Cheers,

    Sylvain
