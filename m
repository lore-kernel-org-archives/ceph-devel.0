From: Gregory Farnum <greg@inktank.com>
Subject: Re: mds fails to start on SL6
Date: Mon, 9 Jul 2012 09:20:31 -0700
Message-ID: <CAPYLRzh-1TjcMUxU3uyThAamC3L88J4SQ+gb9BE81YLeUPuiMA@mail.gmail.com>
References: <sfid-H20120706-173805-+057.69-1@marduk.tchpc.tcd.ie>
	<DC5475EA-BEE8-4623-BFE7-C6BBB68C8C35@tchpc.tcd.ie>
	<4ff7146f.c6abd80a.2746.3555SMTPIN_ADDED@mx.google.com>
	<CAD0JqPHcfKDhBZHqH2N_KP2SA+c6U-Hv9gHTXfHgZZDxn1Hztw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44536 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab2GIQUc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 12:20:32 -0400
Received: by bkwj10 with SMTP id j10so6172426bkw.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jul 2012 09:20:31 -0700 (PDT)
In-Reply-To: <CAD0JqPHcfKDhBZHqH2N_KP2SA+c6U-Hv9gHTXfHgZZDxn1Hztw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jtang@tchpc.tcd.ie
Cc: ceph-devel@vger.kernel.org

On Sat, Jul 7, 2012 at 1:42 AM, Jimmy Tang <jtang@tchpc.tcd.ie> wrote:
> Hi Greg,
>
> On Fri, Jul 6, 2012 at 5:38 PM, Gregory Farnum <greg@inktank.com> wrote:
>>
>> Do you have more in the log? It looks like it's being instructed to
>> shut down before it's fully come up (thus the error in the Objecter
>> http://tracker.newdream.net/issues/2740, but is not the root cause),
>> but I can't see why.
>> -Greg
>>
>
> That's all that appeared in the log, if you need additional information I
> was following a wiki page from
> <http://ceph.com/wiki/Installing_on_RedHat_or_CentOS> to do the installation
> and also made some updated notes of what I did to install it which I can
> provide if you need it (they are updated installation notes for the
> mentioned wiki page which others will find useful anyway). I also had
> followed the 5min quick guide to testing out ceph on a single machine.
>
> Unfortunately I'm going to be away for the next week or two so I won't be
> able to do much for a few weeks on this.

Hmm. When you get back, if you could run this again with "debug mds =
20" and "debug objecter = 20" in the MDS config that would be helpful.
