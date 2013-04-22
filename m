From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Authentication question with RBD+STGT
Date: Mon, 22 Apr 2013 16:42:55 -0700
Message-ID: <5175CAFF.3020509@inktank.com>
References: <51757CD2.2070404@liquidweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:38847 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab3DVXm7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 19:42:59 -0400
Received: by mail-pd0-f181.google.com with SMTP id y10so18326pdj.26
        for <ceph-devel@vger.kernel.org>; Mon, 22 Apr 2013 16:42:58 -0700 (PDT)
In-Reply-To: <51757CD2.2070404@liquidweb.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Scott Sullivan <ssullivan@liquidweb.com>
Cc: ceph-devel@vger.kernel.org



On 04/22/2013 11:09 AM, Scott Sullivan wrote:
> Referring to this:
> http://ceph.com/dev-notes/adding-support-for-rbd-to-stgt/
>
> I compiled the latest tgt with RBD support. My question is when using
> this method to access RBD volumes, where do you tell it what user to
> authenticate to the cluster with? I do see the above linked page
> mentions it will read a local ceph.conf.

Yes, as Wido hints at, it passes NULL to rados_create()'s second arg; 
that means it will authenticate as client.admin.  This could certainly 
be easily fixed.

