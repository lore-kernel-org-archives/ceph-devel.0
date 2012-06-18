From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: stable 10GBE under 3.4.2 or 3.5.0-rc2
Date: Mon, 18 Jun 2012 08:56:36 -0500
Message-ID: <4FDF3394.3000107@inktank.com>
References: <4FDEDB7F.4070600@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:60712 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab2FRN4j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 09:56:39 -0400
Received: by gglu4 with SMTP id u4so3656558ggl.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 06:56:38 -0700 (PDT)
In-Reply-To: <4FDEDB7F.4070600@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 6/18/12 2:40 AM, Stefan Priebe - Profihost AG wrote:
> Hi list,
>
> i've still problems with stable network speed under recent kernels. With
> 3.0.32 i get stable 9.90 Gbit/s in both directions. With 3.4.2 or
> 3.5.0-rc2 it drops sometimes down to around 1 Gbit/s. Sadly i've no idea
> when this happen? It works sometimes for minutes at 9.9Gbit/s and then
> suddently only with 3-4Gbit/s or even 1Gbit/s using recent kernels.
>
> I'm using various tunings recommanded by intel (Improving Performance)
> => http://downloadmirror.intel.com/5874/eng/README.txt
>

Hi Stefan,

Did you ever get a chance to talk to Jason Wang about the commit that 
was causing the problems?  It might be a good idea to report all of this 
upstream and see what they have to say.

Mark
