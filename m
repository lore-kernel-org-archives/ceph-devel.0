From: Dan Mick <dan.mick@inktank.com>
Subject: Re: rados gw configuration documentation
Date: Mon, 22 Oct 2012 10:28:37 -0700
Message-ID: <50858245.3080309@inktank.com>
References: <CABpo6hJ2dTnVtSN8EUyFQzywge20=AsAW1tzxRujSkhhL3cMqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51357 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab2JVR2k (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 13:28:40 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2158531pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 10:28:40 -0700 (PDT)
In-Reply-To: <CABpo6hJ2dTnVtSN8EUyFQzywge20=AsAW1tzxRujSkhhL3cMqw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lokesh Krishnappa <lokesh.professional.it@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 10/22/2012 10:25 AM, Lokesh Krishnappa wrote:
> Hi,
>
> Am following link: http://ceph.com/docs/master/radosgw/config/ to
> configure for teuthology test cases .
> while configuration, i get freeze in session "create rgw.conf" and
> completed on second time.

What do you mean you "get freeze"?  That sounds like you're saying some 
process failed to make forward progress, but the "create rgw.conf" 
section of that documentation is a manual step.  What exactly happened?

> i request to more clear doucmentation for
> creating rgw.conf with path and FastCgiExternalServer . its more
> helpful for fresh users.
