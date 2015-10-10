From: Martin Bureau <mbureau@stingraydigital.onmicrosoft.com>
Subject: Re: [ceph-users] How to reduce the influenct on the IO when an osd is
	marked out?
Date: Sat, 10 Oct 2015 12:29:52 +0000
Message-ID: <BLUPR0801MB165230605729F9E3268AD893E0330@BLUPR0801MB1652.namprd08.prod.outlook.com>
References: <56188B95.7060006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0087.outbound.protection.outlook.com ([65.55.169.87]:39904
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751054AbbJJM35 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Oct 2015 08:29:57 -0400
In-Reply-To: <56188B95.7060006@gmail.com>
Content-Language: en-CA
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: wangsongbo <songbo1227@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

Hello,

You can use these settings to lower the impact of backfilling and recovery operations:

osd max backfills
osd recovery max active

Additionally, if you are using the cfq io scheduler, with these you can set the io priority of recovery operations versus client operations:

osd client op priority
osd recovery op priority

Finally, if the osd is down temporarily because of a maintenance for example, you can set the noout flag (ceph osd set noout) so that backfilling will not occur during this time.

Regards,
Martin

________________________________________
From: ceph-users <ceph-users-bounces@lists.ceph.com> on behalf of wangsongbo <songbo1227@gmail.com>
Sent: October 9, 2015 11:52 PM
To: ceph-devel; ceph-users@ceph.com
Subject: [ceph-users] How to reduce the influenct on the IO when an osd is      marked out?

Hi all,
when an osd is marked out, relative IO will be blocked, in which case,
application built on ceph will fail.According to test result, the larger
a data is,the longer it will take to elapse.
How to reduce the impact of this process on the IO?


Thanks and Regards,
WangSongbo
_______________________________________________
ceph-users mailing list
ceph-users@lists.ceph.com
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com