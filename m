From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: [PATCH] configure.ac: check for org.junit.rules.ExternalResource
Date: Tue, 15 Jan 2013 06:55:34 -0800
Message-ID: <CAPrxi59+Q234v50c9s_fiFH8__=Hc63pWmVLDDEZQGq_Lm8J_w@mail.gmail.com>
References: <1357767316-27868-1-git-send-email-danny.al-gaaf@bisect.de>
	<CAPrxi58_D4PVhMAtABfKiRrXKZv0p4OUSfc+MuVkha0ndWPWxA@mail.gmail.com>
	<BB8FDF50-D01D-4B4A-A201-8AEA43FFFA2D@inktank.com>
	<50EE73F3.6050705@bisect.de>
	<3EC7678C-6C3D-4E59-A5ED-FC9B2DC28C08@inktank.com>
	<CAPrxi58uyBNJTvHnwKyALWN=f0XiiFicnDHOfWfOCT4tebqxxw@mail.gmail.com>
	<50F51B9F.8020504@canonical.com>
	<50F52218.9020106@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:38887 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046Ab3AOOzf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 09:55:35 -0500
Received: by mail-vc0-f171.google.com with SMTP id n11so190309vch.30
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 06:55:35 -0800 (PST)
In-Reply-To: <50F52218.9020106@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, James Page <james.page@canonical.com>, Gary Lowell <gary.lowell@inktank.com>, Sage Weil <sage@inktank.com>

On Tue, Jan 15, 2013 at 1:32 AM, Danny Al-Gaaf <danny.al-gaaf@bisect.de> wrote:
> Am 15.01.2013 10:04, schrieb James Page:
>> On 12/01/13 16:36, Noah Watkins wrote:
>>> On Thu, Jan 10, 2013 at 9:13 PM, Gary Lowell
>>> <gary.lowell@inktank.com> wrote:
>
> I would also prefer to not add another huge build dependency to ceph,
> especially since it's e.g. not supported by SLES11 and since ceph
> currently builds fine (even with these small warnings from autotools).

Ahh, I had in my head a separate repository for Java bindings managed
by maven (or ant). Either way, I have no strong opinion -- we only
have one junit dependency :)
