From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: can we stop packaging sysvinit scripts?
Date: Wed, 10 Jan 2018 17:18:24 +0100
Message-ID: <b6b69060-2424-5404-cdf0-4ca019ec9ead@m-privacy.de>
References: <alpine.DEB.2.11.1801101440550.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www1.m-privacy.de ([85.214.254.135]:50466 "EHLO
        www1.m-privacy.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754256AbeAJQSf (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jan 2018 11:18:35 -0500
In-Reply-To: <alpine.DEB.2.11.1801101440550.24931@piezo.novalocal>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

Am 10.01.2018 um 15:44 schrieb Sage Weil:
> We've had systemd unit files for several releases now and all major 
> distros are using systemd by default.  Can we stop packaging the sysvinit 
> scripts?
> 
> I realize that Debian allows you to switch init systems... do any users 
> actually do this?  Is it required that debs include the sysvinit scripts 
> or is there some glue that lets packages avoid maintaining sysvinit 
> scripts?
> 
> I ask because the init scripts are one of the few remainining bits that 
> use the ceph-conf utility, which I would like to deprecate (and eventually 
> remove).  It parses local config files but we are migrating this to the 
> mon.  We could make ceph-conf pull configs from the mon but I would 
> like to simplify if possible!

We would really appreciate having the init scripts around for a long
while, as we are not willing to use systemd on our servers for security
reasons. Please do not drop them.

Amon Ott
-- 
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Werner-Voß-Damm 62       Fax: +49 30 99296856
12101 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Geschäftsführer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649

