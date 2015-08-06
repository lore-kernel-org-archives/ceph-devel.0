From: Nigel Williams <nigel.williams@utas.edu.au>
Subject: Re: [ANN] ceph-deploy 1.5.27 released
Date: Thu, 6 Aug 2015 14:00:24 +1000
Message-ID: <mpum4o$4ud$1@ger.gmane.org>
References: <CACkq2mqgjP-J3CFM0zA8uoXbi1oPjni8JbtTwvvE5K0hSDTQig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52938 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715AbbHFEAf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 Aug 2015 00:00:35 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1ZNCM4-0003Sc-4i
	for ceph-devel@vger.kernel.org; Thu, 06 Aug 2015 06:00:32 +0200
Received: from fjzmd2s-nigelw.its.utas.edu.au ([131.217.4.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 06 Aug 2015 06:00:32 +0200
Received: from nigel.williams by fjzmd2s-nigelw.its.utas.edu.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 06 Aug 2015 06:00:32 +0200
In-Reply-To: <CACkq2mqgjP-J3CFM0zA8uoXbi1oPjni8JbtTwvvE5K0hSDTQig@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ceph-users@lists.ceph.com

On 6/08/2015 9:45 AM, Travis Rhoden wrote:
> A new version of ceph-deploy has been released. Version 1.5.27
> includes the following:

Has the syntax for use of --zap-disk changed? I moved it around but it is no longer 
recognised; worked around by doing a ceph-disk zap before running ceph-deploy.

This worked previously:

ceph-deploy --overwrite-conf osd --zap-disk prepare ceph05:/dev/sdb:/dev/sdd



