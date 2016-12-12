From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Is Hammer end of life now?
Date: Mon, 12 Dec 2016 20:24:36 +0100
Message-ID: <71343bb5-fb1f-a389-3e8c-bbb38a42496e@suse.cz>
References: <CALqRxCxMvAZTgA5sO4cJzFhzVjL=0xYnXrLO2n57VZf21R3b9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44389 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752924AbcLLTYj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Dec 2016 14:24:39 -0500
In-Reply-To: <CALqRxCxMvAZTgA5sO4cJzFhzVjL=0xYnXrLO2n57VZf21R3b9Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

> Is Hammer EOL now? Should I put "December 2016" for actual retirement?

We are preparing a 0.94.10 point release, which will possibly be the 
last. If the retirement month is the month in which the last point 
release is published, you could put December 2016 or January 2017.

People keep earmarking issues for hammer backport, so I am getting ready 
to do another round of PR testing/merging, after which I will ask 
Abhishek if a 0.94.10 should be published.

Does anyone have anything in particular they would like to see in 0.94.10?

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
