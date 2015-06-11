From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Regarding hadoop over RGW blueprint
Date: Thu, 11 Jun 2015 03:02:08 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD9FE16@SACMBXIP01.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD9FACB@SACMBXIP01.sdcorp.global.sandisk.com>
 <51FC7A40FB29414D88A121A7FFEF9A471114DC78@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0085.outbound.protection.outlook.com ([157.56.110.85]:52575
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751484AbbFKDCN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jun 2015 23:02:13 -0400
In-Reply-To: <51FC7A40FB29414D88A121A7FFEF9A471114DC78@SHSMSX104.ccr.corp.intel.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Zhang, Jian" <jian.zhang@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

Thanks Jian !
What about my first question :-) ? Are you seeing any shortcomings with that ?
Dumb question may be (not much knowledge on Hadoop front ) , but I was asking why to write a new filesystem interface to plugin with Hadoop, why not plug in RGWProxy somewhere in between may be like Hadoop + S3 + RGWProxy + RGW ?

Regards
Somnath

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Zhang, Jian
Sent: Wednesday, June 10, 2015 7:06 PM
To: Somnath Roy; ceph-devel
Cc: Zhang, Jian
Subject: RE: Regarding hadoop over RGW blueprint

Somnath,
For you second question, our blueprint is targeting to solve the scenario that people trying to run multiple cluster (geographically distributed), which only has a dedicated proxy server have access to the storage cluster, that's one of the biggest advantage of this blueprints. 
For the third question, I think most end users still have concerns on CephFS, currently we don't have plan to benchmark this solution against CephFS. 

Jian



-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
Sent: Thursday, June 11, 2015 8:54 AM
To: ceph-devel
Subject: Regarding hadoop over RGW blueprint

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

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
