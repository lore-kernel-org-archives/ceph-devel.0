From: Gregory Farnum <greg@inktank.com>
Subject: Re: Very bad behavior when
Date: Sat, 24 Nov 2012 08:45:54 -0800
Message-ID: <D988AE88A2484A23AA62CF8112AA9B7A@inktank.com>
References: <CAF6-1L5WSukXaDfy64wxUuuHDdhZ3G3AW_=fkjiVLzbm_g-rng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34760 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab2KXQp4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Nov 2012 11:45:56 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so7098899pbc.19
        for <ceph-devel@vger.kernel.org>; Sat, 24 Nov 2012 08:45:56 -0800 (PST)
In-Reply-To: <CAF6-1L5WSukXaDfy64wxUuuHDdhZ3G3AW_=fkjiVLzbm_g-rng@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

On Thursday, November 22, 2012 at 5:26 AM, Sylvain Munaut wrote:
> Hi,
> 
> I know that ceph has time synced servers has a requirements, but I
> think a sane failure mode like a message in the logs instead of
> incontrollably growing memory usage would be a good idea.
> 
> I had the NTP process die on me tonight on an OSD (for unknown reason
> so far ...) and the clock went 3000s out of sync and the OSD memory
> just kept growing, and also the master mon memory.
> (which has the nice effect of having the master mon being OOM killed,
> then one of the backup takes the master role and grows as well and
> gets killed and so on and so forth until there is no quorum anymore).
> 


In addition to Sam's question about version, are you using cephx?
-Greg

