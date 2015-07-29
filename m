From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Ceph write path optimization
Date: Wed, 29 Jul 2015 15:35:07 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDE9CA7@SACMBXIP01.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDE784B@SACMBXIP01.sdcorp.global.sandisk.com>
 <20150729065708.GA27890@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0053.outbound.protection.outlook.com ([157.56.111.53]:12218
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751309AbbG2PfT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jul 2015 11:35:19 -0400
In-Reply-To: <20150729065708.GA27890@infradead.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

<<inline

-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org]
Sent: Tuesday, July 28, 2015 11:57 PM
To: Somnath Roy
Cc: ceph-devel@vger.kernel.org
Subject: Re: Ceph write path optimization

On Tue, Jul 28, 2015 at 09:08:27PM +0000, Somnath Roy wrote:
> 2. Each filestore Op threads is now doing O_DSYNC write followed by
> posix_fadvise(**fd, 0, 0, POSIX_FADV_DONTNEED);

Where aren't you using O_DIRECT | O_DSYNC?

[Somnath] We can do that, but, I saw we are not gaining anything by doing that.

> 15. The main challenge I am facing in both the scheme is XFS metadata
> flush process (xfsaild) is choking all the processes accessing the
> disk when it is waking up. I can delay it till max 30 sec and if there
> are lot of dirty metadata, there is a performance spike down for very
> brief amount of time. Even if we are acknowledging writes from say
> NVRAM journal write, still the opthreads are doing getattrs on the XFS
> and those threads are getting blocked.

Can you send a more detailed report to the XFS lists?  E.g. which locks your blocked on and some perf data?

[Somnath] This list could be helpful http://oss.sgi.com/archives/xfs/2015-06/msg00111.html
I think I am hitting similar..

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

