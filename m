From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] configure.ac: check for org.junit.rules.ExternalResource
Date: Tue, 15 Jan 2013 09:36:22 -0800
Message-ID: <CAPYLRzjacUuMBw_jy7oRZhKSkmtnwkncgQZdzrQ26gf2Z9f_vQ@mail.gmail.com>
References: <1357767316-27868-1-git-send-email-danny.al-gaaf@bisect.de>
	<CAPrxi58_D4PVhMAtABfKiRrXKZv0p4OUSfc+MuVkha0ndWPWxA@mail.gmail.com>
	<BB8FDF50-D01D-4B4A-A201-8AEA43FFFA2D@inktank.com>
	<50EE73F3.6050705@bisect.de>
	<3EC7678C-6C3D-4E59-A5ED-FC9B2DC28C08@inktank.com>
	<CAPrxi58uyBNJTvHnwKyALWN=f0XiiFicnDHOfWfOCT4tebqxxw@mail.gmail.com>
	<50F51B9F.8020504@canonical.com>
	<50F52218.9020106@bisect.de>
	<CAPrxi59+Q234v50c9s_fiFH8__=Hc63pWmVLDDEZQGq_Lm8J_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:33645 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755255Ab3AORgW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 12:36:22 -0500
Received: by mail-qc0-f169.google.com with SMTP id t2so242163qcq.0
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 09:36:22 -0800 (PST)
In-Reply-To: <CAPrxi59+Q234v50c9s_fiFH8__=Hc63pWmVLDDEZQGq_Lm8J_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Danny Al-Gaaf <danny.al-gaaf@bisect.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, James Page <james.page@canonical.com>, Gary Lowell <gary.lowell@inktank.com>, Sage Weil <sage@inktank.com>

On Tue, Jan 15, 2013 at 6:55 AM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> On Tue, Jan 15, 2013 at 1:32 AM, Danny Al-Gaaf <danny.al-gaaf@bisect.de> wrote:
>> Am 15.01.2013 10:04, schrieb James Page:
>>> On 12/01/13 16:36, Noah Watkins wrote:
>>>> On Thu, Jan 10, 2013 at 9:13 PM, Gary Lowell
>>>> <gary.lowell@inktank.com> wrote:
>>
>> I would also prefer to not add another huge build dependency to ceph,
>> especially since it's e.g. not supported by SLES11 and since ceph
>> currently builds fine (even with these small warnings from autotools).
>
> Ahh, I had in my head a separate repository for Java bindings managed
> by maven (or ant). Either way, I have no strong opinion -- we only
> have one junit dependency :)

I don't believe Ceph currently requires any Java to build, and it's
going to remain that way if I have anything to say about it. ;) Hadoop
bindings can be packaged in about a billion different ways that don't
require core Ceph to depend on a Java toolchain.
-Greg
