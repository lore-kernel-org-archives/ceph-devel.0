From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: RGW object versioning status
Date: Fri, 17 Jul 2015 13:08:21 -0400 (EDT)
Message-ID: <1368361459.8906899.1437152901958.JavaMail.zimbra@redhat.com>
References: <06681238D8946F44A60AA400760A1CBF020147BE@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:55754 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbbGQRIY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jul 2015 13:08:24 -0400
In-Reply-To: <06681238D8946F44A60AA400760A1CBF020147BE@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuan Zhou <yuan.zhou@intel.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>



----- Original Message -----
> From: "Yuan Zhou" <yuan.zhou@intel.com>
> To: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> Cc: "Ceph Devel" <ceph-devel@vger.kernel.org>
> Sent: Thursday, July 16, 2015 9:06:29 PM
> Subject: RGW object versioning status
> 
> Hi Yehuda,
> 
> I see there's a wiki page on RGW object versioning. And from the code looks
> like it's already there.
> https://wiki.ceph.com/Development/RGW_Object_Versioning

Right, object versioning (S3) went into hammer.

> 
> But the RGW doc tells me Swift/S3 object version is not supported.
> 
> http://ceph.com/docs/master/radosgw/swift/
> http://ceph.com/docs/master/radosgw/s3/
> 
> 
> What is the status of this feature? Is there any doc on this?
> 

The docs are not up to date. The feature follows the S3 versioning api.

Yehuda
