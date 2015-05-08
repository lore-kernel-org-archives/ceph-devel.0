From: Joao Eduardo Luis <joao@suse.de>
Subject: RFC: Deprecating ceph-tool commands
Date: Sat, 09 May 2015 00:55:04 +0100
Message-ID: <554D4CD8.6020809@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58529 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbbEHXzG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 8 May 2015 19:55:06 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

All,

While working on #11545 (mon: have mon-specific commands under 'ceph mon
...') I crashed into a slightly tough brick wall.

The purpose of #11545 is to move certain commands, such as 'ceph scrub',
'ceph compact' and 'ceph sync force' to the 'mon' module of the ceph-tool.

These commands have long stood in this format because 'mon'-module
commands have been traditionally considered as being somehow related
with monmaps and/or the MonmapMonitor.  However, from a user
perspective, if they relate to the monitor itself (and not cluster-wide)
they should reside under the 'mon'-module.

As such, I decided they should be moved to 'ceph mon scrub', 'ceph mon
compact' and 'ceph mon sync force'.

Adding these commands and doing the correct mapping is not hard at all.
 However, backward compatibility must be maintained, and simply dropping
the old style commands doesn't seem reasonable at all.

Keeping the old style commands alongside with the new commands is
trivial enough to not pose a problem, but they must go away at some
point.  After everyone get used to the new commands, and as soon as the
vast majority of deployments support the new commands, the old style
commands will simply be clutter.

And while these commands are not widely used, and while most people
certainly have not ever needed to use them, this sort of thing can at
some point be required for any other (most commonly used) command.

As I have not been able to find any mentions to guidelines to
deprecating commands, I thus propose the following:

A command being DEPRECATED must be:

 - clearly marked as DEPRECATED in usage;
 - kept around for at least 2 major releases;
 - kept compatible for the duration of the deprecation period.

Once two major releases go by, the command will then enter the OBSOLETE
period.  This would be one major release, during which the command would
no longer work although still acknowledged.  A simple message down the
lines of 'This command is now obsolete; please check the docs' would
suffice to inform the user.

The command would no longer exist in the next major release.

This approach gives a lifespan of roughly 3 releases (at current rate,
roughly 1.5 years) before being completely dropped.  This should give
enough time to people to realize what has happened and adjust any
scripts they may have.

E.g., a command being deprecated in Infernallis would be completely
dropped in the L-release, spanning its existence to at least one
long-term stable (i.e., jewel) and being dropped as soon as the first
dev cycle for the L-release begins.

Any thoughts and comments are welcome.

Cheers!

  -Joao

p.s., If you want to take a look at how this would translate in terms of
code on the monitor, please check [1].

[1] - https://github.com/ceph/ceph/pull/4595
