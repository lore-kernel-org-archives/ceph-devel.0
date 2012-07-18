From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Poor read performance in KVM
Date: Wed, 18 Jul 2012 08:34:43 -0700
Message-ID: <5006D793.6090906@inktank.com>
References: <5002C215.108@bashkirtsev.com> <5003B1CC.4060909@inktank.com> <50064DCD.8040904@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:33643 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab2GRPeq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jul 2012 11:34:46 -0400
Received: by ghrr11 with SMTP id r11so1686884ghr.19
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jul 2012 08:34:45 -0700 (PDT)
In-Reply-To: <50064DCD.8040904@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: ceph-devel@vger.kernel.org

On 07/17/2012 10:46 PM, Vladimir Bashkirtsev wrote:
>> ceph --admin-daemon /var/run/ceph/kvm.asok perf dump
> Done that. Waited for VM to fully boot then got perf dump. It would be
> nice to get output in human readable format instead of JSON - I remember
> some other part of ceph had relevant command line switch. Does it exist
> for perf dump?

I forgot to mention you can pipe that to 'python -mjson.tool' for more
readable output. It's intended to be used by monitoring tools, hence
json, but some kind of more plain output could be added.

Josh
