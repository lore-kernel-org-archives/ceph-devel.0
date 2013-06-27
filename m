From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: wip-libcephfs rebase
Date: Thu, 27 Jun 2013 13:54:29 -0400 (EDT)
Message-ID: <466224703.168.1372355669107.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <260303729.166.1372355254438.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:1397 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752622Ab3F0Ryh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 27 Jun 2013 13:54:37 -0400
In-Reply-To: <260303729.166.1372355254438.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@inktank.com>, aemerson <aemerson@linuxbox.com>, David Zafman <david.zafman@inktank.com>, Ilya Storozhilov <Ilya_Storozhilov@epam.com>

Hi All,

Just to confirm what Adam and I are doing on this end, ie, this is our plan to rebase wip-libcephfs following wip-libcephfs-rebase.

* proceeding commit-wise on wip-libcephfs-rebase, mapping each change back to a commit in wip-libcephfs
** striking out anything marked reject in rebase
** striking out anything marked "whitespace"
*** (unless you want these)
** either striking out or motivating in commit message anything marked "why"
** updating commit messages of every commit which remains
*** with author, signed off by, SHAs of the source commit(s), updated commit message (background authors)
* test, fix, and rebase as necessary
* cherry-pick changes from Ilya
** adapt anything we propose to adjust in new commits
* rebase on head
* push to our Ceph repo for review/pull when ready

Matt

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
