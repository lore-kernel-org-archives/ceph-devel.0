From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Why only support odd number monitors in ceph cluster?
Date: Fri, 23 Dec 2011 10:34:11 +0100
Message-ID: <4EF44B13.80301@widodh.nl>
References: <8512670932FB654F81AF0FEF1BE6D49DABFBE6@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:35451 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042Ab1LWJdz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Dec 2011 04:33:55 -0500
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49DABFBE6@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wistron.com
Cc: ceph-devel@vger.kernel.org, Chris_YT_Huang@wistron.com, Alex_KT_Lin@wistron.com

Hi,

On 12/23/2011 08:21 AM, Eric_YH_Chen@wistron.com wrote:
> Hi, all:
>
>       I am curious about why ceph cluster only support odd number monitors.

It doesn't only support a odd number. A even number of monitors works in 
theory, but it's recommended to use a odd number to get a majority.

>
>       If we lose 1 monitor (becomes odd number),

You shouldn't look to the number of online monitors, but to the number 
of monitors in your monmap. That should be a odd number.

Wido

>
>        would it cause any problem if we do not handle this situation in short time?
>
>       Thanks!
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

