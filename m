From: Gregory Farnum <greg@inktank.com>
Subject: Re: Set object mtime
Date: Fri, 12 Jul 2013 13:59:36 -0700
Message-ID: <CAPYLRzjppMNGXqryMbQc5fk-5w4QB2hc5OPi=Af4M4mbUttXZw@mail.gmail.com>
References: <CAFtEh-e6GWeU-hP==zPjcXDuxfWkmeZo0wDwY-R82SJR2JZnzQ@mail.gmail.com>
	<5150A306.6030509@42on.com>
	<CAFtEh-d6r4S+1G1LLhWnzJXhKR1maQXJYrVK8nn+3UjjchoSZw@mail.gmail.com>
	<alpine.DEB.2.00.1303251237090.12444@cobra.newdream.net>
	<CAFtEh-dNzjj5yXmw+qej2a67yRW_YbjPk5uVQKhiK00kFRZysg@mail.gmail.com>
	<CAF6-1L7R1T8icOcC+sguevBV-WigA=jZLEVCRP8HX0YXgGTK+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:61913 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965443Ab3GLU7i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jul 2013 16:59:38 -0400
Received: by mail-we0-f172.google.com with SMTP id q56so8582491wes.3
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jul 2013 13:59:37 -0700 (PDT)
In-Reply-To: <CAF6-1L7R1T8icOcC+sguevBV-WigA=jZLEVCRP8HX0YXgGTK+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: Damien Churchill <damoxc@gmail.com>, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jul 11, 2013 at 6:56 AM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> Hi,
>
>> Okay thanks! A call in the C API would be handy. I was wanting to look
>> at creating a tool to sync RADOS between clusters. Is that anything
>> that's in the development plan already?
>
> I was just thinking of the same thing.
>
> Basically I want rsync between pools, mostly to allow changing the
> number of PG with minimum down time. The current method is to copy the
> pool but that implies nothing is writing to it in the mean time and I
> can't shutdown operations for that long.
>
> Did you end up writing that tool ?

Why do you want to copy the data to change the PG count? PG splitting
is supported now, so unless you need to do merging for some reason you
should be good to go. :)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
