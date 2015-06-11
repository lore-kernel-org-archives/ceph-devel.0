From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Regarding hadoop over RGW blueprint
Date: Thu, 11 Jun 2015 00:54:06 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD9FACB@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0063.outbound.protection.outlook.com ([157.56.110.63]:53920
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751711AbbFKAyP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jun 2015 20:54:15 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Yuan/Jian

I was going through your following blueprint.

http://tracker.ceph.com/projects/ceph/wiki/Hadoop_over_Ceph_RGW_status_update

This is very interesting. I have some query though.

1. Did you guys benchmark RGW + S3 interface integrated with Hadoop. This should work as is today. Are you seeing some shortcomings with this solution other than localization ?

2. The only advantage with your solution is to get locality with RGW proxy ? Or there are other advantages as well ?

3. Hadoop with CephFs is the preferred solution from RedHat. Are you going to benchmark your solution against this as well ?

Thanks & Regards
Somnath


________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

