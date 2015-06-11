From: "Zhou, Yuan" <yuan.zhou@intel.com>
Subject: RE: Regarding hadoop over RGW blueprint
Date: Thu, 11 Jun 2015 03:44:06 +0000
Message-ID: <06681238D8946F44A60AA400760A1CBF01FCED84@SHSMSX104.ccr.corp.intel.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD9FACB@SACMBXIP01.sdcorp.global.sandisk.com>
 <51FC7A40FB29414D88A121A7FFEF9A471114DC78@SHSMSX104.ccr.corp.intel.com>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD9FE16@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32541 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbbFKDoL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jun 2015 23:44:11 -0400
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CD9FE16@SACMBXIP01.sdcorp.global.sandisk.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, "Zhang, Jian" <jian.zhang@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Somnath,

The background was a bit complicated. This was part of the MOC project, which aims to setup an open-exchange cloud between several private cloud inside several universities.
https://www.openstack.org/summit/openstack-summit-atlanta-2014/session-videos/presentation/the-massachusetts-open-cloud-moc-a-new-model-to-operate-and-innovate-in-a-vendor-neutral-cloud

There was a strong requirement of multi-tenancy, which is lack in S3 interface. So we actually go to the SwiftFS approach. Currently SwiftFS only support one proxy-server, which is not able to scale to some rack level, this is a big gap. SwiftFS supports locality-awareness but this is  restricted to single proxy.

During our tests, we also find there's some bug when the data set goes to >20GB. SwiftFS is not able to support large data sets. We have some patches but not full ready.

In conclusion, there was some new requirements that S3/SwiftFS cannot meet. So we just propose the new plugin for Ceph RGW. 

thanks, -yuan

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
Sent: Thursday, June 11, 2015 11:02 AM
To: Zhang, Jian; ceph-devel
Subject: RE: Regarding hadoop over RGW blueprint

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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
