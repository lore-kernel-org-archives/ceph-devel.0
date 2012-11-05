From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: massive rbd speed decrease with latest git master
Date: Mon, 05 Nov 2012 12:58:44 -0600
Message-ID: <50980C64.8050501@inktank.com>
References: <50979779.3040300@profihost.ag> <50980A0C.7010200@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51877 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab2KES6o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Nov 2012 13:58:44 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so8492357iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 05 Nov 2012 10:58:43 -0800 (PST)
In-Reply-To: <50980A0C.7010200@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, alexandre DERUMIER <aderumier@odiso.com>

On 11/05/2012 12:48 PM, Stefan Priebe wrote:
> Am 05.11.2012 11:39, schrieb Stefan Priebe - Profihost AG:
>> Hello list,
>>
>> while updating ceph to the latest master i noticed this:
>>
>> Commit a01b112d71a0b6a1bb206d53867d13536d17bbf6:
>> rand. 4k WRITE: 3000 iop/s
>>
>> Commit 72a710ac47355ae3ca1d055be1496c91956d549d:
>> rand. 4k WRITE: 900 iop/s
>>
>> Same for rand 4k read - haven't tested sequential stuff.
>
> OK i found out what the issue is. I get 900 iop/s when compiled with
> syncfs support and i get 3000-6000 iop/s when compiled without syncfs
> support.
>
> Strange shouldn't syncfs improve the performance?
>
> Note: ceph is running inside KVM right now for testing with an iscsi
> based backend storage. My real testhw will arrive tomorrow.

Very strange.  I'm curious if you continue to see this on your real test 
hardware.

>
> Greets,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Mark
