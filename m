From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: Some usability question
Date: Thu, 26 Feb 2015 21:05:53 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F282BB873@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0071.outbound.protection.outlook.com ([157.56.111.71]:29894
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754045AbbBZVF7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 16:05:59 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,
Is there any way to know which OSD to map to which drive of a host from an Admin node ?
We know from command like say 'ceph osd tree' to identify till the host where an osd belongs to but not the disk. The workaround I have is to login to the corresponding node and see the mount points to identify. Is this the best one or am I missing any command ?
If we can depict a tree view (similar to 'ceph osd tree') from pool to disk level (pool -> hosts ( and the crush buckets hierarchy) -> osds -> disks), user can easily find out their crush map is working as expected on a specific pool (say cache tier).

Second question,  regarding Erasure coded pool a certain amount of storage could be lost because of padding. I think it will be helpful if we can show how much is lost because of the variant client workload with the help of a command. This information can help user to choose the erasure coded profile (as it is dependent on K value) accordingly. Presently, rados object can't identify what is valid (and what not), so it could be a lot of effort, but is it worth ?  Any thoughts ?

Thanks & Regards
Somnath



________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

