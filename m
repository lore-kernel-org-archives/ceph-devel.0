From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: Set object mtime
Date: Thu, 11 Jul 2013 15:56:15 +0200
Message-ID: <CAF6-1L7R1T8icOcC+sguevBV-WigA=jZLEVCRP8HX0YXgGTK+g@mail.gmail.com>
References: <CAFtEh-e6GWeU-hP==zPjcXDuxfWkmeZo0wDwY-R82SJR2JZnzQ@mail.gmail.com>
	<5150A306.6030509@42on.com>
	<CAFtEh-d6r4S+1G1LLhWnzJXhKR1maQXJYrVK8nn+3UjjchoSZw@mail.gmail.com>
	<alpine.DEB.2.00.1303251237090.12444@cobra.newdream.net>
	<CAFtEh-dNzjj5yXmw+qej2a67yRW_YbjPk5uVQKhiK00kFRZysg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37989 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932442Ab3GKN4Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jul 2013 09:56:16 -0400
Received: by mail-bk0-f46.google.com with SMTP id na10so3336547bkb.33
        for <ceph-devel@vger.kernel.org>; Thu, 11 Jul 2013 06:56:15 -0700 (PDT)
In-Reply-To: <CAFtEh-dNzjj5yXmw+qej2a67yRW_YbjPk5uVQKhiK00kFRZysg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Damien Churchill <damoxc@gmail.com>
Cc: Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

> Okay thanks! A call in the C API would be handy. I was wanting to look
> at creating a tool to sync RADOS between clusters. Is that anything
> that's in the development plan already?

I was just thinking of the same thing.

Basically I want rsync between pools, mostly to allow changing the
number of PG with minimum down time. The current method is to copy the
pool but that implies nothing is writing to it in the mean time and I
can't shutdown operations for that long.

Did you end up writing that tool ?


Cheers,

    Sylvain
