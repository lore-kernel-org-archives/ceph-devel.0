From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: RocksDB tuning
Date: Fri, 10 Jun 2016 18:17:43 +0000
Message-ID: <BLUPR0201MB1524FBCA6545533F1AE21ECCE8500@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <D37DE46C.5743E%manavalan.krishnan@sandisk.com>
 <BLUPR0201MB1524D8A9D42F7C50646D0AE8E85E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <a3216e58-d591-50ae-f2f2-0cbb7cdaa7bb@redhat.com>
 <fb82e615-0762-0843-9a9f-cbc4686e35ba@redhat.com>
 <BL2PR02MB2115BD376A32CF2B6E54ABABF45F0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <BL2PR02MB2115DF8FF9EF7CF822C838BAF4500@BL2PR02MB2115.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1606100533300.6221@cpach.fuggernut.com>
 <BLUPR0201MB15246B72324C2D633EBCB21AE8500@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1606101052190.6221@cpach.fuggernut.com>
 <BLUPR0201MB1524D36741665F05BCB8AC0EE8500@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1606101352550.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0095.outbound.protection.outlook.com ([207.46.100.95]:22914
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751225AbcFJSRr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Jun 2016 14:17:47 -0400
In-Reply-To: <alpine.DEB.2.11.1606101352550.6221@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, Mark Nelson <mnelson@redhat.com>, Manavalan Krishnan <Manavalan.Krishnan@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

Language is imprecise. I agree with you completely. We should pick the fastest hash that we can find and truncate it accordingly.



Allen Samuels
SanDisk |a Western Digital brand
2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com


> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Friday, June 10, 2016 10:55 AM
> To: Allen Samuels <Allen.Samuels@sandisk.com>
> Cc: Somnath Roy <Somnath.Roy@sandisk.com>; Mark Nelson
> <mnelson@redhat.com>; Manavalan Krishnan
> <Manavalan.Krishnan@sandisk.com>; Ceph Development <ceph-
> devel@vger.kernel.org>
> Subject: RE: RocksDB tuning
> 
> On Fri, 10 Jun 2016, Allen Samuels wrote:
> > Oh, and use 16-bit checksums :)
> 
> csum_type xxhash32, 0.576609s seconds, 4655.42 MB/sec csum_type
> xxhash64, 0.306633s seconds, 8754.29 MB/sec csum_type crc32c, 0.176754s
> seconds, 15187 MB/sec csum_type crc32c_16, 0.172195s seconds, 15589
> MB/sec csum_type crc32c_8, 0.137655s seconds, 19500.6 MB/sec csum_type
> crc16, 8.32507s seconds, 322.442 MB/sec csum_type crc16_8, 8.29444s
> seconds, 323.633 MB/sec
> 
> on my dev box.  See
> 
> 	https://github.com/ceph/ceph/pull/9632
> 
> (This is based on other stuff that's not merged; only the last few patches
> there are relevant).
> 
> I think we should drop the crc16 and just stick with low bits of crc32c, since it's
> way faster... I'm pretty sure even without the intel instructions.
> 
> sage
