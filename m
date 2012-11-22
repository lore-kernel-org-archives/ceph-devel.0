From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Very bad behavior when
Date: Thu, 22 Nov 2012 14:26:39 +0100
Message-ID: <CAF6-1L5WSukXaDfy64wxUuuHDdhZ3G3AW_=fkjiVLzbm_g-rng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:37914 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932350Ab2KVS6M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 13:58:12 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so8295538oag.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 10:58:11 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I know that ceph has time synced servers has a requirements, but I
think a sane failure mode like a message in the logs instead of
incontrollably growing memory usage would be a good idea.

I had the NTP process die on me tonight on an OSD (for unknown reason
so far ...) and the clock went 3000s out of sync and the OSD memory
just kept growing, and also the master mon memory.
(which has the nice effect of having the master mon being OOM killed,
then one of the backup takes the master role and grows as well and
gets killed and so on and so forth until there is no quorum anymore).

Cheers,

     Sylvain
