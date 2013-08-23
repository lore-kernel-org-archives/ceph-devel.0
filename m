From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] mds: update backtrace when old format inode is touched
Date: Fri, 23 Aug 2013 07:09:01 -0300
Message-ID: <ortxigk9c2.fsf@livre.home>
References: <1377222150-4238-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:43795 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074Ab3HWKJW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Aug 2013 06:09:22 -0400
In-Reply-To: <1377222150-4238-1-git-send-email-zheng.z.yan@intel.com> (Zheng
	Yan's message of "Fri, 23 Aug 2013 09:42:30 +0800")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

On Aug 22, 2013, "Yan, Zheng" <zheng.z.yan@intel.com> wrote:

> We updated inode format version to 7 when introducing inode backtrace.
> If we found a inode's format version < 7 when fetching the inode, set
> the inode's backtrace_version to 0, to indicate the inode's backtrace
> is out of data. When touching a inode with backtrace_version == 0, we
> also update its backtrace.

> +  if (pi->backtrace_version == 0)
> +    pi->update_backtrace();
   
AFAICT all this does is to update the backtrace version number in the
cached-in-memory inode.  What am I missing?  Or is the code missing
something? :-)

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
