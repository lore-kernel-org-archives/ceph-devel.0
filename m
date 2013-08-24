From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] enable mds rejoin with active inodes' old parent xattrs
Date: Sat, 24 Aug 2013 07:38:17 -0300
Message-ID: <ory57ridba.fsf@livre.home>
References: <orvc2ytei1.fsf@livre.home>
	<CAAM7YAk+1pZsn8=f-Z+wxzm+4-zkKQCN52gVTWot6e_OmHDSTQ@mail.gmail.com>
	<orppt4k6ys.fsf@livre.home>
	<CAPYLRzjHPbRe-AKnzqb-M+jO78u9vMYdru+8kLGWmVEPNanfqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:45823 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092Ab3HXKic (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Aug 2013 06:38:32 -0400
In-Reply-To: <CAPYLRzjHPbRe-AKnzqb-M+jO78u9vMYdru+8kLGWmVEPNanfqA@mail.gmail.com>
	(Gregory Farnum's message of "Fri, 23 Aug 2013 13:11:14 -0700")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "Yan, Zheng" <ukernel@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Aug 23, 2013, Gregory Farnum <greg@inktank.com> wrote:

> On Fri, Aug 23, 2013 at 4:00 AM, Alexandre Oliva <oliva@gnu.org> wrote:
>> On Aug 22, 2013, "Yan, Zheng" <ukernel@gmail.com> wrote:
>> 
>>> This is not bug. Only the tail entry of the path encoded in the parent xattrs
>>> need to be updated. (the entry for inode's parent directory)
>> 
>> Why store the others, if they're not usable, then?  IMHO it just
>> introduces a risk of their being accidentally misused.

> We want to write a correct path whenever we touch the file, but we
> don't want to have to go out to each file's object in order to
> complete a directory rename. So for a given file object we consider
> only the immediate parent to be authoritative, but keep around the
> full path for disaster recovery.

Ok, so all this extra info is for disaster recovery only.  I guess that
makes some sense to me, as long as that's clear to everone who might
want to tap on that info.

> If we are touching the file's ancestor xattr and not updating the
> whole thing, that would be a bug, but I don't think that's what you're
> describing?

It was not, indeed.  Thanks for the clarification.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
