From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: endless flying slow requests
Date: Thu, 15 Nov 2012 09:09:53 +0100
Message-ID: <50A4A351.8020506@profihost.ag>
References: <50A3607A.6050209@profihost.ag> <alpine.DEB.2.00.1211140656590.6512@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:35663 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992679Ab2KOIKB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Nov 2012 03:10:01 -0500
In-Reply-To: <alpine.DEB.2.00.1211140656590.6512@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 14.11.2012 15:59, schrieb Sage Weil:
> Hi Stefan,
>
> I would be nice to confirm that no clients are waiting on replies for
> these requests; currently we suspect that the OSD request tracking is the
> buggy part.  If you query the OSD admin socket you should be able to dump
> requests and see the client IP, and then query the client.
>
> Is it librbd?  In that case you likely need to change the config so that
> it is listening on an admin socket ('admin socket = path').

Yes it is. So i have to specify admin socket at the KVM host? How do i 
query the admin socket for requests?

Stefan


> On Wed, 14 Nov 2012, Stefan Priebe - Profihost AG wrote:
>
>> Hello list,
>>
>> i see this several times. Endless flying slow requests. And they never stop
>> until i restart the mentioned osd.
>>
>> 2012-11-14 10:11:57.513395 osd.24 [WRN] 1 slow requests, 1 included below;
>> oldest blocked for > 31789.858457 secs
>> 2012-11-14 10:11:57.513399 osd.24 [WRN] slow request 31789.858457 seconds old,
>> received at 2012-11-14 01:22:07.654922: osd_op(client.30286.0:6719
>> rbd_data.75c55bf2fdd7.0000000000001399 [write 282624~4096] 3.3f6d2373) v4
>> currently delayed
>> 2012-11-14 10:11:58.513584 osd.24 [WRN] 1 slow requests, 1 included below;
>> oldest blocked for > 31790.858646 secs
>> 2012-11-14 10:11:58.513586 osd.24 [WRN] slow request 31790.858646 seconds old,
>> received at 2012-11-14 01:22:07.654922: osd_op(client.30286.0:6719
>> rbd_data.75c55bf2fdd7.0000000000001399 [write 282624~4096] 3.3f6d2373) v4
>> currently delayed
>> 2012-11-14 10:11:59.513766 osd.24 [WRN] 1 slow requests, 1 included below;
>> oldest blocked for > 31791.858827 secs
>> 2012-11-14 10:11:59.513768 osd.24 [WRN] slow request 31791.858827 seconds old,
>> received at 2012-11-14 01:22:07.654922: osd_op(client.30286.0:6719
>> rbd_data.75c55bf2fdd7.0000000000001399 [write 282624~4096] 3.3f6d2373) v4
>> currently delayed
>> 2012-11-14 10:12:00.513909 osd.24 [WRN] 1 slow requests, 1 included below;
>> oldest blocked for > 31792.858971 secs
>> 2012-11-14 10:12:00.513916 osd.24 [WRN] slow request 31792.858971 seconds old,
>> received at 2012-11-14 01:22:07.654922: osd_op(client.30286.0:6719
>> rbd_data.75c55bf2fdd7.0000000000001399 [write 282624~4096] 3.3f6d2373) v4
>> currently delayed
>> 2012-11-14 10:12:01.514061 osd.24 [WRN] 1 slow requests, 1 included below;
>> oldest blocked for > 31793.859124 secs
>> 2012-11-14 10:12:01.514063 osd.24 [WRN] slow request 31793.859124 seconds old,
>> received at 2012-11-14 01:22:07.654922: osd_op(client.30286.0:6719
>> rbd_data.75c55bf2fdd7.0000000000001399 [write 282624~4096] 3.3f6d2373) v4
>> currently delayed
>>
>> When i now restart osd 24 they go away and everything is fine again.
>>
>> Stefan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
