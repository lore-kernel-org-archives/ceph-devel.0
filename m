From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] mds: update backtrace when old format inode is touched
Date: Fri, 23 Aug 2013 08:36:00 -0300
Message-ID: <orli3sk5b3.fsf@livre.home>
References: <1377222150-4238-1-git-send-email-zheng.z.yan@intel.com>
	<ortxigk9c2.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:43924 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755200Ab3HWLgZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Aug 2013 07:36:25 -0400
In-Reply-To: <ortxigk9c2.fsf@livre.home> (Alexandre Oliva's message of "Fri,
	23 Aug 2013 07:09:01 -0300")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, sage@inktank.com

On Aug 23, 2013, Alexandre Oliva <oliva@gnu.org> wrote:

> On Aug 22, 2013, "Yan, Zheng" <zheng.z.yan@intel.com> wrote:
>> We updated inode format version to 7 when introducing inode backtrace.
>> If we found a inode's format version < 7 when fetching the inode, set
>> the inode's backtrace_version to 0, to indicate the inode's backtrace
>> is out of data. When touching a inode with backtrace_version == 0, we
>> also update its backtrace.

>> +  if (pi->backtrace_version == 0)
>> +    pi->update_backtrace();
   
> AFAICT all this does is to update the backtrace version number in the
> cached-in-memory inode.  What am I missing?  Or is the code missing
> something? :-)

N/m, I see now that this eventually causes _mark_dirty_parent to be
called, which in turn gets the parent attribute updated.
inode_t::is_backtrace_updated() means exactly the opposite of what I
expected ;-)

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
