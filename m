From: Joe Buck <jbbuck@gmail.com>
Subject: Re: Seeking review of a pull request in teuthology
Date: Thu, 25 Oct 2012 17:52:36 -0700
Message-ID: <5089DED4.4030002@gmail.com>
References: <508893F7.4070502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34214 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642Ab2JZAwh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Oct 2012 20:52:37 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1551448pad.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Oct 2012 17:52:37 -0700 (PDT)
In-Reply-To: <508893F7.4070502@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Based on the feedback I received, I changed this patch to use the 
username in the remote object.
I've also updated the commit comment to reference a user and not an owner.

The pull request is in teuthology branch wip-buck if someone could take 
another look at it.

Best,
-Joe Buck

On 10/24/2012 06:20 PM, Joe Buck wrote:
> I submitted a pull request for teuthology/task/workunit.py that uses 
> the configured owner rather than using the hard-coded "ubuntu" 
> username when creating a scratch directory in /tmp.
>
> -Joe Buck

