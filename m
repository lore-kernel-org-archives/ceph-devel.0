From: Alex Elder <elder@inktank.com>
Subject: Re:
Date: Thu, 25 Oct 2012 17:15:55 -0500
Message-ID: <5089BA1B.6000905@inktank.com>
References: <CAB6Jr7RbMaxQpxV0_pUTwSwf51wuavmJ_Dnzdk4OVMZiHcMZKQ@mail.gmail.com> <50868471.1070105@widodh.nl> <CAB6Jr7QbWZ7Xe+VZrPwC7rWcZ7_F6kLm=A+zq1NEAmcGvgky-A@mail.gmail.com> <162E8EA1E858481C9CD55412C597577E@inktank.com> <CAB6Jr7SbbAE=yEVgg+UupTmavKfvFvGj8j7C9M0Ya2FocNmw9w@mail.gmail.com> <1A4C855A8DD647B0B2E8790CA2945D00@inktank.com> <50894E81.30403@inktank.com> <alpine.DEB.2.00.1210250838070.25762@cobra.newdream.net> <5089AEE7.2010302@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:54175 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751Ab2JYWP6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 18:15:58 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2941632iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Oct 2012 15:15:57 -0700 (PDT)
In-Reply-To: <5089AEE7.2010302@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Gregory Farnum <greg@inktank.com>, jie sun <0maidou0@gmail.com>, ceph-devel@vger.kernel.org

On 10/25/2012 04:28 PM, Dan Mick wrote:
> 
>>>    static void ceph_fault(struct ceph_connection *con)
>>>            __releases(con->mutex)
>>>    {
>>>            pr_err("%s%lld %s %s\n", ENTITY_NAME(con->peer_name),
>>>                   ceph_pr_addr(&con->peer_addr.in_addr), con->error_msg)
>>>
>>> Perhaps this should become pr_info() or something.  Sage?
>>
>> Yeah, I think pr_info() is probably the right choice.  Do you know if
>> that
>> hits the console by default, or just dmesg/kern.log?
> 
> pr_info is level 6, KERN_INFO; by default, /proc/sys/kernel/printk has
> 4 4 1 7 in it, the first 4 of which means 4-and-lower go to console.  So
> debug, info, notice messages all are options for "not console".
> 

Excellent.  So pr_info() it is.  Dan you want to implement this?

					-Alex
