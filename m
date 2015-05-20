From: "Deneau, Tom" <tom.deneau@amd.com>
Subject: RE: journal writes when running rados bench seq on ec pool
Date: Wed, 20 May 2015 18:31:27 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF916644DCA5@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF9166442D87@SATLEXDAG01.amd.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD8BFBD@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0145.outbound.protection.outlook.com ([157.56.111.145]:52550
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752268AbbETSrE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 May 2015 14:47:04 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD8BFBD@SACMBXIP01.sdcorp.global.sandisk.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi --

I never saw an explanation for the writes that are occurring during ecpool reads.

-- Tom


> -----Original Message-----
> From: Somnath Roy [mailto:Somnath.Roy@sandisk.com]
> Sent: Wednesday, May 13, 2015 6:48 PM
> To: Deneau, Tom; ceph-devel
> Subject: RE: journal writes when running rados bench seq on ec pool
> 
> Tom,
> Good that you brought this up !
> I was also seeing the small writes during reads but forgot to mention in my
> last report on EC.
> Basically, Ceph code base seems to be issuing small writes during reads and
> it is basically going to both data/jounal (considering filestore backend)
> ..But, since data partition is syncing on every 5 sec , it is not obvious
> there.
> 
> Loic,
> Could you please explain a bit more on this ? What exactly we are writing
> during reads ?
> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Deneau, Tom
> Sent: Wednesday, May 13, 2015 4:40 PM
> To: ceph-devel
> Subject: journal writes when running rados bench seq on ec pool
> 
> I am running a rados bench seq read benchmark on an erasure-coded pool (k=2,
> m=1),
> and recording the disk activity.   I notice that I always see a small number
> of writes
> to the journal partitions during the seq read run.  (I always drop the caches
> on the osd nodes before starting the seq read run).
> 
> I never see this journal write behavior with a replicated pool and I didn't
> think there would be any journal writes with either kind of pool on a read
> benchmark.
> 
> The write activity is low enough that it's probably not that important
> performance-wise but I as just curious as to what would cause this.
> 
> -- Tom Deneau
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> 
> ________________________________
> 
> PLEASE NOTE: The information contained in this electronic mail message is
> intended only for the use of the designated recipient(s) named above. If the
> reader of this message is not the intended recipient, you are hereby notified
> that you have received this message in error and that any review,
> dissemination, distribution, or copying of this message is strictly
> prohibited. If you have received this communication in error, please notify
> the sender by telephone or e-mail (as shown above) immediately and destroy
> any and all copies of this message in your possession (whether hard copies or
> electronically stored copies).

