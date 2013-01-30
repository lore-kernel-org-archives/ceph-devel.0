From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: [PATCH 0/6] fix build (ceph.spec)
Date: Wed, 30 Jan 2013 19:30:39 +0100
Message-ID: <510966CF.6070501@bisect.de>
References: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de> <92E15B6073484C53B4AE3A0B85F0FC25@inktank.com>
Reply-To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:52748 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755152Ab3A3San (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Jan 2013 13:30:43 -0500
In-Reply-To: <92E15B6073484C53B4AE3A0B85F0FC25@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: dan.mick@inktank.com, ceph-devel@vger.kernel.org, Sage Weil <sage@inktank.com>, Watkins Noah <noah.watkins@inktank.com>

Am 30.01.2013 19:07, schrieb Gregory Farnum:
> On Wednesday, January 30, 2013 at 10:00 AM, Danny Al-Gaaf wrote:
>> This set fixes some issues in the spec file.
>> 
>> I'm not sure what the reason for
>> #35e5d74e5c5786bc91df5dc10b5c08c77305df4e was. But I would revert
>> it and fix the underlaying issues instead.
> 
> 
> That is a pretty obtuse commit message, but it was actually because
> while rbd-fuse is ready to be in-tree, we don't think it's ready for
> people to be using; there are some undocumented gotchas involved with
> it and not a lot of testing. :)

Hm, but this is git master and not a released ceph version or the next
tree. IMO rbd-fuse should be installed in the master branch to be
tested. Otherwise it will be build but maybe never tested by others than
developers which know it's there.

> I'll let others comment on the Java library moves and other packaging
> changes. -Greg

Only an additional comment: I've moved the libcephfs_jni.* files to
%{_libdir} because this is what SUSE already do for e.g. the *.so files
in the libjnidispatch package.

Danny
