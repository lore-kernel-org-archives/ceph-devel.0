From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: [PATCH] enable mds rejoin with active inodes' old parent xattrs
Date: Fri, 23 Aug 2013 08:00:11 -0300
Message-ID: <orppt4k6ys.fsf@livre.home>
References: <orvc2ytei1.fsf@livre.home>
	<CAAM7YAk+1pZsn8=f-Z+wxzm+4-zkKQCN52gVTWot6e_OmHDSTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:43875 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab3HWLA2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Aug 2013 07:00:28 -0400
In-Reply-To: <CAAM7YAk+1pZsn8=f-Z+wxzm+4-zkKQCN52gVTWot6e_OmHDSTQ@mail.gmail.com>
	(Zheng Yan's message of "Thu, 22 Aug 2013 16:27:24 +0800")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Aug 22, 2013, "Yan, Zheng" <ukernel@gmail.com> wrote:

> This is not bug. Only the tail entry of the path encoded in the parent xattrs
> need to be updated. (the entry for inode's parent directory)

Why store the others, if they're not usable, then?  IMHO it just
introduces a risk of their being accidentally misused.

> Cuttlefish also has this issue, it just does not print the error message
> to console.

Speaking of Cuttlefish, I don't think my statement that I'd run into
this issue in Cuttlefish was correct: I don't see similar code to the
one I patched there, and indeed, (accidentally) starting a Cuttlefish
mds on an otherwise Dumpling cluster enabled recovery to complete where
Dumpling's mds wouldn't.  So, no backporting for this patch of mine, I
think.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
