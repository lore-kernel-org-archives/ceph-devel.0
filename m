From: Sage Weil <sweil@redhat.com>
Subject: Re: Regarding journal replay
Date: Thu, 10 Sep 2015 15:04:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509101500380.12362@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE41F48@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36740 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250AbbIJWEL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Sep 2015 18:04:11 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE41F48@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 10 Sep 2015, Somnath Roy wrote:
> Sage et. al,
> Could you please let me know what will happen during journal replay in this scenario ?
> 
> 1. Say last committed seq is 3 and after that one more independent transaction with say 4 came. Transaction seq 4, has say delete xattr, delete object, create a new object,  set xattr
> 
> 2. Seq 4 is committed in journal and in half way of applying (say all deletes are done , and created new object but set xattr not done) system crashed.
> 
> 3. During restart OSD will try to replay seq 4.
> 
> Now, my understanding is, it will blindly run the entire transaction again. But..
> 
> 1. Delete will fail since the file doesn't exists.
> 
> 2. It will create the new object again even if it is already created , probably get an already exist error (?)
> 
> Question is, how it will determine the error is because of filesystem corruption or half executed transaction ?
>  I saw in the code we are ignoring these errors during replay , is it correct ?
> Any information on this will be helpful.

There are a subset of operations where errors (or certain errors) are 
ignored (and expected) during replay.  ENOENT on delete is one of them.
The largest set of them is whitelisted here

https://github.com/ceph/ceph/blob/master/src/os/FileStore.cc#L2781

but if you grep for 'replaying' you'll see several other instances 
elsewhere.

Sadly you can't tell if these are happening because of the timing of the 
crash or because of some other corruption.... the combination 
of a write-ahead transaction log and posix is far from ideal.  In general, 
though, operation are all safe to replay.  In the cases where they 
are not, there is the replay_guard machinery to prevent certain things 
from being replayed.

sage

