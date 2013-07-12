From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: Set object mtime
Date: Fri, 12 Jul 2013 23:26:56 +0200
Message-ID: <CAF6-1L4LNeuBG_MdDYykDKVZ7ghmbNe_5=z8mxyh-rme6v3Hxw@mail.gmail.com>
References: <CAFtEh-e6GWeU-hP==zPjcXDuxfWkmeZo0wDwY-R82SJR2JZnzQ@mail.gmail.com>
	<5150A306.6030509@42on.com>
	<CAFtEh-d6r4S+1G1LLhWnzJXhKR1maQXJYrVK8nn+3UjjchoSZw@mail.gmail.com>
	<alpine.DEB.2.00.1303251237090.12444@cobra.newdream.net>
	<CAFtEh-dNzjj5yXmw+qej2a67yRW_YbjPk5uVQKhiK00kFRZysg@mail.gmail.com>
	<CAF6-1L7R1T8icOcC+sguevBV-WigA=jZLEVCRP8HX0YXgGTK+g@mail.gmail.com>
	<CAPYLRzjppMNGXqryMbQc5fk-5w4QB2hc5OPi=Af4M4mbUttXZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:63883 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965441Ab3GLV06 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jul 2013 17:26:58 -0400
Received: by mail-bk0-f42.google.com with SMTP id jk13so3965049bkc.1
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jul 2013 14:26:56 -0700 (PDT)
In-Reply-To: <CAPYLRzjppMNGXqryMbQc5fk-5w4QB2hc5OPi=Af4M4mbUttXZw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Damien Churchill <damoxc@gmail.com>, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

> Why do you want to copy the data to change the PG count? PG splitting
> is supported now, so unless you need to do merging for some reason you
> should be good to go. :)

I need to do merging :)

At the time the PG count formula wasn't too clear and I got too many
PGs which tend to slow things down, slow down peering and things like
that. Also non-power of two seem to have less favorable data
distributions.

It also seems to be the only way to enable that flag to hash the pool
id at the moment.

Cheers,

    Sylvain
