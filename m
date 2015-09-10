From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Regarding journal replay
Date: Thu, 10 Sep 2015 22:06:11 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE42336@SACMBXIP01.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE41F48@SACMBXIP01.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1509101500380.12362@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0071.outbound.protection.outlook.com ([207.46.100.71]:13024
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750764AbbIJWGP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Sep 2015 18:06:15 -0400
In-Reply-To: <alpine.DEB.2.00.1509101500380.12362@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Yeah, thanks Sage for confirming this.

Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com]
Sent: Thursday, September 10, 2015 3:04 PM
To: Somnath Roy
Cc: ceph-devel
Subject: Re: Regarding journal replay

On Thu, 10 Sep 2015, Somnath Roy wrote:
> Sage et. al,
> Could you please let me know what will happen during journal replay in this scenario ?
>
> 1. Say last committed seq is 3 and after that one more independent
> transaction with say 4 came. Transaction seq 4, has say delete xattr,
> delete object, create a new object,  set xattr
>
> 2. Seq 4 is committed in journal and in half way of applying (say all deletes are done , and created new object but set xattr not done) system crashed.
>
> 3. During restart OSD will try to replay seq 4.
>
> Now, my understanding is, it will blindly run the entire transaction again. But..
>
> 1. Delete will fail since the file doesn't exists.
>
> 2. It will create the new object again even if it is already created ,
> probably get an already exist error (?)
>
> Question is, how it will determine the error is because of filesystem corruption or half executed transaction ?
>  I saw in the code we are ignoring these errors during replay , is it correct ?
> Any information on this will be helpful.

There are a subset of operations where errors (or certain errors) are ignored (and expected) during replay.  ENOENT on delete is one of them.
The largest set of them is whitelisted here

https://github.com/ceph/ceph/blob/master/src/os/FileStore.cc#L2781

but if you grep for 'replaying' you'll see several other instances elsewhere.

Sadly you can't tell if these are happening because of the timing of the crash or because of some other corruption.... the combination of a write-ahead transaction log and posix is far from ideal.  In general, though, operation are all safe to replay.  In the cases where they are not, there is the replay_guard machinery to prevent certain things from being replayed.

sage


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

