From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Upgrade a running cluster to bobtail ? (when it will be out :p)
Date: Wed, 28 Nov 2012 10:34:54 +0100
Message-ID: <CAF6-1L7R6DbWtmokUthKS0QPPMGRFdLWXXnH7DSekF-S3cb-EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:51730 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab2K1Jez (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Nov 2012 04:34:55 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so13297836oag.19
        for <ceph-devel@vger.kernel.org>; Wed, 28 Nov 2012 01:34:55 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I'd like to know the recommended upgrade procedure when bobtail is out ?

I've read in the past in the list that rolling upgrade between stable
release was going to be possible, but exactly what is the way to do
this ?

Upgrade OSD host by host, then upgrade MON one by one ?  Or do the MON first ?

Cheers,

    Sylvain
