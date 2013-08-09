From: James Page <james.page@ubuntu.com>
Subject: Re: Could we introduce launchpad/gerrit for ceph
Date: Fri, 09 Aug 2013 16:14:16 +0100
Message-ID: <52050748.7060808@ubuntu.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC01E54E02@SHSMSX102.ccr.corp.intel.com> <alpine.DEB.2.00.1308082200400.1479@cobra.newdream.net> <6F3FA899187F0043BA1827A69DA2F7CC01E55325@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:34773 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934342Ab3HIPOY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Aug 2013 11:14:24 -0400
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC01E55325@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 09/08/13 14:58, Chen, Xiaoxi wrote:
> I do think Launchpad is a mature alternative since there are big
> successful story such like Ubuntu and Openstack :)

Indeed

> OpenStack has already use it for years, and seems everyone happy
> with it, I am also happy with it, but I am not familiar with jira
> so I cannot do a comparison.

Bear in mind that the OpenStack project uses Launchpad for Blueprints,
Bug Tracking and Release Management and github+gerrit for code
management and reviews so its a bit of both worlds but it does seem to
work pretty well.

Monty's OpenStack CI team did some magic in gerrit to make comments in
reviews link back to bugs and blueprints.

HTH

James

- -- 
James Page
Ubuntu and Debian Developer
james.page@ubuntu.com
jamespage@debian.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCAAGBQJSBQdEAAoJEL/srsug59jDOHwP/j0P7izbsfggwSZItcgHB4nY
iFJlCh1IEqPjJu1g09pjR/jCQJpAxhV6pMg9Q8u7N9Zwcoql/VIDWy4WZlL7Kgce
7QGEFIOqqvrd+8AzqqV5tsCzcLggUJDIvBfUiz+K3YtDnZeBAgqAFAX1ykG0Ntoi
kaeSkfEC7EDoLKcw1p1mJs9VE02IkSyN3Wl/dGr4SL5Cf8XwkVJEH9GItEEiQCMW
go0n9gsR0HY7N7tXpxyiFLfZODZYKd3pXc3CyerlwAHNyoKOatIAQ7e2amnyvXaF
mDljaRwtoSLEuj3xXaDKUxaoT5ZCMBFfooVtfca3h4YoZLvoOhFQ1YzObX+zqd7L
TbU784cG0Q/l82kvTpliiZvs9lMMJdx2LlONmRVUni/YZAfh74JdEXKlF8G08uN1
cgx4KrgbpgHHd/AA2fCjADzjeeklr8vsbyb6gPCPAGoKW6fAV6ehLe23eeQWPS7A
0sNbRg1xTLD+TrjqNlXkEnIy4B5ZdBMIhc+fLeXTdHwJT26f/P0abQyCYyEUQiNo
qRsm792+mbf9P0AluHiBi+a6/H05TTmPK5FbsAltPfUjOb0KHE5/UCGjiDLuIrV8
8Ym2R7vOpmLnEs9/t1tAMIUDZdZZV4oYAGPg3IyPbgxMay3dcLt9m3ARj4mS3o+f
iwAn2dOGJ3yJIOnla4kD
=bq9T
-----END PGP SIGNATURE-----
