From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Monitor issue
Date: Mon, 29 Oct 2012 15:59:08 +0100
Message-ID: <508E99BC.6050807@widodh.nl>
References: <508E9742.8040303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:56367 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab2J2O7K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Oct 2012 10:59:10 -0400
In-Reply-To: <508E9742.8040303@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Alekseev <rs.alekseev@gmail.com>
Cc: ceph-devel@vger.kernel.org



On 10/29/2012 03:48 PM, Roman Alekseev wrote:
> Hello,
>
> I have 3 monitors on different nodes and when 'mon.a' was stopped whole
> cluster stopped work too.
> My conf: http://pastebin.com/hT3qEhUF
>
> Could someone explain how to fix such kind of failure?

Could you explain a bit more about the setup?

Which version are you running?

What do you mean with failure? Is the ceph -s command still working?

How sure are you that you didn't catch a bug that killed all three 
monitors? Are those processes actually up and running?

Did you check the logs of the monitors?

Could you let us know?

Thanks!

Wido
