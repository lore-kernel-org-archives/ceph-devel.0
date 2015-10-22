From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: newstore direction
Date: Thu, 22 Oct 2015 01:22:29 +0000
Message-ID: <7334B4281E425749B85E08CF7EC6F8534383E519@SACMBXIP03.sdcorp.global.sandisk.com>
References: <alpine.DEB.2.00.1510191216200.4188@cobra.newdream.net>
 <56268886.7010806@redhat.com>
 <7334B4281E425749B85E08CF7EC6F8534383DD15@SACMBXIP03.sdcorp.global.sandisk.com>
 <562775DD.8050304@redhat.com>
 <7334B4281E425749B85E08CF7EC6F8534383E481@SACMBXIP03.sdcorp.global.sandisk.com>
 <56283902.4020006@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0061.outbound.protection.outlook.com ([65.55.169.61]:65236
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756334AbbJVBWe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Oct 2015 21:22:34 -0400
In-Reply-To: <56283902.4020006@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ric Wheeler <rwheeler@redhat.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I agree. My only point was that you still have to factor this time into the argument that by continuing to put NewStore on top of a file system you'll get to a stable system much sooner than the longer development path of doing your own raw storage allocator. IMO, once you factor that into the equation the "on top of an FS" path doesn't look like such a clear winner.


Allen Samuels
Software Architect, Fellow, Systems and Software Solutions

2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com

-----Original Message-----
From: Ric Wheeler [mailto:rwheeler@redhat.com]
Sent: Thursday, October 22, 2015 10:17 AM
To: Allen Samuels <Allen.Samuels@sandisk.com>; Sage Weil <sweil@redhat.com>; ceph-devel@vger.kernel.org
Subject: Re: newstore direction

On 10/21/2015 08:53 PM, Allen Samuels wrote:
> Fixing the bug doesn't take a long time. Getting it deployed is where the delay is. Many companies standardize on a particular release of a particular distro. Getting them to switch to a new release -- even a "bug fix" point release -- is a major undertaking that often is a complete roadblock. Just my experience. YMMV.
>

Customers do control the pace that they upgrade their machines, but we put out fixes on a very regular pace.  A lot of customers will get fixes without having to qualify a full new release (i.e., fixes come out between major and minor releases are easy).

If someone is deploying a critical server for storage, then it falls back on the storage software team to help guide them and encourage them to update when needed (and no promises of success, but people move if the win is big. If it is not, they can wait).

ric


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

