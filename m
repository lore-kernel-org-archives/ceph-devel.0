From: Gaudenz Steinlin <gaudenz@debian.org>
Subject: Re: [Ceph-maintainers] disabling updatedb
Date: Tue, 18 Feb 2014 18:52:13 +0100
Message-ID: <8738jg2trm.fsf@meteor.durcheinandertal.bofh>
References: <alpine.DEB.2.00.1402180845440.15052@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from vechigen.cirrax.com ([217.197.128.12]:60590 "EHLO
	mail.cirrax.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754282AbaBRSCB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Feb 2014 13:02:01 -0500
In-Reply-To: <alpine.DEB.2.00.1402180845440.15052@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-maintainers@ceph.com, ceph-devel@vger.kernel.org


Hi

Sage Weil <sage@inktank.com> writes:

> Dan at CERN noticed that his performance was tanking because updatedb was 
> running against /var/lib/ceph.  updatedb has a PRUNE line in 
> /etc/updatedb.conf that we should presumably be adding ourselves to.  One 
> user pointed out a package that uses sed to rewrite this line in the init 
> script on start.
>
> I have two questions:
>
> - is there no better way than sed to add ourselves to this list?
> - should we do it in the init script, or postinst, or both?
>
> Presumably this is a problem others have solved with other packages.

At least for Debian neither solution is appropriate. Changing other
packages conffiles in postinst scripts is forbidden by policy. There is
also no way to preserve this reliably over upgrades without user
interaction. I'm not sure if there is an explicit policy for init
scripts, but this seems equally wrong. Also it's unclear how one would
handle the case were an administrator does NOT want to exclude this
directory.

The only solution I see if you really want to completely exclude the
directory is to convince the mlocate maintainers to either add the
directory to the default configuration or to add something like an
/etc/updatedb.d directory where packages can drop configuration file
snippets. But the latter seems like overkill to me.

The real question to me is why an updatedb run can drastically impact
ceph performance. At least in Debian updatedb is run with ionice
-c3 in the "Idle" scheduling class. According to the man page this
means: "A program running with idle I/O priority will only get disk time
when no other program has asked for disk I/O for a defined grace period.
The impact of an idle I/O process on normal system activity should be
zero. This scheduling class does not take a priority argument.
Presently, this scheduling class is permitted for an ordinary user
(since kernel 2.6.25)." So it should not have any negative effect.

Maybe CERN (or the distribution they use) should also run updatedb under
ionice.

Gaudenz

-- 
Ever tried. Ever failed. No matter.
Try again. Fail again. Fail better.
~ Samuel Beckett ~
