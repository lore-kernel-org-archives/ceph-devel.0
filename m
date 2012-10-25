From: Dan Mick <dan.mick@inktank.com>
Subject: Re:
Date: Thu, 25 Oct 2012 14:28:07 -0700
Message-ID: <5089AEE7.2010302@inktank.com>
References: <CAB6Jr7RbMaxQpxV0_pUTwSwf51wuavmJ_Dnzdk4OVMZiHcMZKQ@mail.gmail.com> <50868471.1070105@widodh.nl> <CAB6Jr7QbWZ7Xe+VZrPwC7rWcZ7_F6kLm=A+zq1NEAmcGvgky-A@mail.gmail.com> <162E8EA1E858481C9CD55412C597577E@inktank.com> <CAB6Jr7SbbAE=yEVgg+UupTmavKfvFvGj8j7C9M0Ya2FocNmw9w@mail.gmail.com> <1A4C855A8DD647B0B2E8790CA2945D00@inktank.com> <50894E81.30403@inktank.com> <alpine.DEB.2.00.1210250838070.25762@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35527 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab2JYV2L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 17:28:11 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2301728pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Oct 2012 14:28:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210250838070.25762@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Alex Elder <elder@inktank.com>, Gregory Farnum <greg@inktank.com>, jie sun <0maidou0@gmail.com>, ceph-devel@vger.kernel.org


>>    static void ceph_fault(struct ceph_connection *con)
>>            __releases(con->mutex)
>>    {
>>            pr_err("%s%lld %s %s\n", ENTITY_NAME(con->peer_name),
>>                   ceph_pr_addr(&con->peer_addr.in_addr), con->error_msg)
>>
>> Perhaps this should become pr_info() or something.  Sage?
>
> Yeah, I think pr_info() is probably the right choice.  Do you know if that
> hits the console by default, or just dmesg/kern.log?

pr_info is level 6, KERN_INFO; by default, /proc/sys/kernel/printk has
4 4 1 7 in it, the first 4 of which means 4-and-lower go to console.  So
debug, info, notice messages all are options for "not console".

