From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: [PATCH] configure.ac: check for org.junit.rules.ExternalResource
Date: Tue, 15 Jan 2013 10:32:08 +0100
Message-ID: <50F52218.9020106@bisect.de>
References: <1357767316-27868-1-git-send-email-danny.al-gaaf@bisect.de> <CAPrxi58_D4PVhMAtABfKiRrXKZv0p4OUSfc+MuVkha0ndWPWxA@mail.gmail.com> <BB8FDF50-D01D-4B4A-A201-8AEA43FFFA2D@inktank.com> <50EE73F3.6050705@bisect.de> <3EC7678C-6C3D-4E59-A5ED-FC9B2DC28C08@inktank.com> <CAPrxi58uyBNJTvHnwKyALWN=f0XiiFicnDHOfWfOCT4tebqxxw@mail.gmail.com> <50F51B9F.8020504@canonical.com>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:58281 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750993Ab3AOJcM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 15 Jan 2013 04:32:12 -0500
In-Reply-To: <50F51B9F.8020504@canonical.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: James Page <james.page@canonical.com>, Noah Watkins <jayhawk@cs.ucsc.edu>, Gary Lowell <gary.lowell@inktank.com>, Sage Weil <sage@inktank.com>

Am 15.01.2013 10:04, schrieb James Page:
> On 12/01/13 16:36, Noah Watkins wrote:
>> On Thu, Jan 10, 2013 at 9:13 PM, Gary Lowell
>> <gary.lowell@inktank.com> wrote:
>>>>
>>>> Thanks Danny.  Installing sharutils solved that minor issue.
>>>> We now get though the build just fine on opensuse 12, but sles
>>>> 11sp2 gives more warnings (pasted below).  Should we be using a
>>>> newer version of autoconf  on sles?  I've tried moving
>>>> AC_CANONICAL_TARGET earlier in the file, but that causes some
>>>> other issues with the new java macros.
>> We could also move away from using autoconf/automake for Java, and
>> use a packaging/dependency system designed for Java, like Maven.
> 
> If this route it taken please bear in mind that use of Maven will
> create some challenges in Ubuntu; specifically with regards to the
> fact that ceph is in main and supported by Canonical and Maven +
> associated toolchain is *huge* in terms of packages and is not in main.
> 
> Ant however is in main and fully supported.

I would also prefer to not add another huge build dependency to ceph,
especially since it's e.g. not supported by SLES11 and since ceph
currently builds fine (even with these small warnings from autotools).

Danny
