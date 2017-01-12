From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: XmlFormatter: space isn't allowed in xml tag
Date: Thu, 12 Jan 2017 09:20:11 +0000
Message-ID: <robbat2-20170112T091829-255678655Z@orbis-terrarum.net>
References: <CACKY0b9_gPAoB3uWAiom1UiPHvDtbXAFJiCtQZN1PV+ps6P5Yw@mail.gmail.com>
Reply-To: ceph-devel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:50092 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbdALJUM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 12 Jan 2017 04:20:12 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 452F5341666
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jan 2017 09:20:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CACKY0b9_gPAoB3uWAiom1UiPHvDtbXAFJiCtQZN1PV+ps6P5Yw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: liuchang0812 <liuchang0812@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jan 12, 2017 at 01:27:33PM +0800, liuchang0812 wrote:
> hi, all
> 
> an XML tag cannot contains space in it. see
> https://www.w3.org/TR/2008/REC-xml-20081126/#NT-NameChar.
Where are spaces leaking into the element names?

I did a refactor of Formatter parters when I was introducing the
HTMLFormatter used by s3website mode, and I don't recall seeing any
cases of accidental space in XML element names, at least in the RGW
side.

-- 
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136
