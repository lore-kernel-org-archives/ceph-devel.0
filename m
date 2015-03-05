From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: git submodule deinit
Date: Thu, 05 Mar 2015 14:22:22 -0700
Message-ID: <54F8C90E.8070906@redhat.com>
References: <54F8C745.7030508@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48838 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906AbbCEVXc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 5 Mar 2015 16:23:32 -0500
In-Reply-To: <54F8C745.7030508@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 03/05/2015 02:14 PM, Loic Dachary wrote:
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
> 
> Cheers
> 

I recently discovered that some of the gitbuilders (at least the Red
Hat-based ones) use a git version 1.8.5.3 built directly from source
and installed into /srv.

https://github.com/ceph/autobuild-ceph/blob/master/fabfile.py#L1078

The packager side of me cannot stop my eyebrow from involuntarily
twitching at this, but the hacker side of me suspects you may be able
to just call this install_git() function on Ubuntu Precise.

- Ken
