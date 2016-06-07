From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Anybody else hitting this panic in latest master with bluestore?
Date: Tue, 7 Jun 2016 14:23:07 +0000
Message-ID: <BL2PR02MB2115DE873C6CC9FCC0C3454CF45D0@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <CY1PR0201MB1820F45DA0E891966F2CBC42855D0@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <BL2PR02MB2115D774BB2D4CFC43F8C847F45D0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <8dd167e2-89c2-84dc-fee1-216be0dc6392@redhat.com>
 <alpine.DEB.2.11.1606070903500.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0095.outbound.protection.outlook.com ([157.56.110.95]:60628
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755133AbcFGOXL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jun 2016 10:23:11 -0400
In-Reply-To: <alpine.DEB.2.11.1606070903500.6221@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Mark Nelson <mnelson@redhat.com>
Cc: Ramesh Chander <Ramesh.Chander@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Sage,
I did a global 'make clean' before build, isn't that sufficient ? Still need to go to rocksdb folder and clean ?


-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net]
Sent: Tuesday, June 07, 2016 6:06 AM
To: Mark Nelson
Cc: Somnath Roy; Ramesh Chander; ceph-devel
Subject: Re: Anybody else hitting this panic in latest master with bluestore?

On Tue, 7 Jun 2016, Mark Nelson wrote:
> I believe this is due to the rocksdb submodule update in PR #9466.
> I'm working on tracking down the commit in rocksdb that's causing it.

Is it possible that the problem is that your build *didn't* update rocksdb?

The ceph makefile isn't smart enough to notice changes in the rocksdb/ dir and rebuild.  You have to 'cd rocksdb ; make clean ; cd ..' after the submodule updates to get a fresh build.

Maybe you didn't do that, and some of the ceph code is build using the new headers and data structures that don't match the previously compiled rocksdb code?

sage
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
