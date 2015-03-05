From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: git submodule deinit
Date: Fri, 06 Mar 2015 00:08:05 +0100
Message-ID: <54F8E1D5.4090104@bisect.de>
References: <54F8C745.7030508@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:43849 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753416AbbCEXIL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Mar 2015 18:08:11 -0500
In-Reply-To: <54F8C745.7030508@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Am 05.03.2015 um 22:14 schrieb Loic Dachary:
> Hi Danny,
> 
> Unfortunately it looks like submodule deinit requires a version of
> git that's not in precise.
> 
> http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-precise-amd64-basic/log.cgi?log=9a0ac62a9cf27573d5345143a3bc6c6b737031db
>
>  + git submodule deinit -f .
> 
> error: pathspec 'deinit' did not match any file(s) known to git.
> 
> error: pathspec '-f' did not match any file(s) known to git.
> 
> I'll revert that and go back to rm until we find a better way.

'git submodule deinit' was introduced in git 1.8.2(-rc3), 4. Mar 2013,
it is quite old, the upcoming git version is 2.3.2.

Which version is used in precise? The code of deinit is only a script.
This may could also be integrated in the existing gitbuilder code as a
helper function. if there is no way to update git to an newer version.

Danny

