From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: ceph caps (Ganesha + Ceph pnfs)
Date: Sat, 5 Jan 2013 11:23:17 -0500 (EST)
Message-ID: <674860131.10.1357402997087.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <507490260.8.1357402950428.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:2134 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755796Ab3AEQXV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 5 Jan 2013 11:23:21 -0500
In-Reply-To: <507490260.8.1357402950428.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@inktank.com>, Gregory Farnum <greg@inktank.com>, David Zafman <david.zafman@inktank.com>

correction:

I mixed stuff together in the previous summary.

If we're committing a final state of an inode (pNFS LAYOUTCOMMIT), it's done from the MDS, which does hold caps.  The prototype DS doesn't currently handle the sync case using the bypass i/o path.  But the prototype up to now has only used that path for unstable DS writes.  If the DS uses the bypass data path, it holds no caps (currently; we might want to change that, perhaps optionally, to get fencing).  To get the spec behavior for stable DS writes, the DS instead does an ordinary ll_write--this deals with metadata correctly but it's not what we want.    To compose the bypass data path with stability, the DS gains the obligation to update inode state itself.  Looking at whether the DS could do this using Ceph protocol, is what led me to start the conversation.

Thanks,

Matt

----- "Matt W. Benjamin" <matt@linuxbox.com> wrote:

> b) on a given DS, we currently get CEPH_CAP_FILE_WR|CEPH_CAP_FILE_RD
> caps when asked to perform i/o on behalf of a valid layout--but we
> need to update metadata (size, mtime) and my question in IRC was cross
> checking these capabilities as correct to send an update message


-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel. 734-761-4689
fax. 734-769-8938
cel. 734-216-5309
