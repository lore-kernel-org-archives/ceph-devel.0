From: Gregory Farnum <greg@gregs42.com>
Subject: Re: [Ceph-qa] 1 hung, 11 passed in teuthology-2015-02-11_16:13:01-samba-giant-distro-basic-multi
Date: Fri, 13 Feb 2015 23:56:18 -0800
Message-ID: <CAC6JEv_7OEsLkj1vm65Jxqh4e7LBnTQUAp6r0_5Tbs0-Z=YZZQ@mail.gmail.com>
References: <20150213035821.17712282150@teuthology.front.sepia.ceph.com>
	<CAC6JEv9pUeCtjs_SBeqr5N=4aSUUuUsbDW3eMipVsBTq5AkZkQ@mail.gmail.com>
	<54DEEC5C.4030605@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:43958 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853AbbBNH4U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Feb 2015 02:56:20 -0500
Received: by iebtr6 with SMTP id tr6so14024150ieb.10
        for <ceph-devel@vger.kernel.org>; Fri, 13 Feb 2015 23:56:19 -0800 (PST)
Received: from mail-ig0-f172.google.com (mail-ig0-f172.google.com. [209.85.213.172])
        by mx.google.com with ESMTPSA id l6sm4687348igv.8.2015.02.13.23.56.18
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Feb 2015 23:56:18 -0800 (PST)
Received: by mail-ig0-f172.google.com with SMTP id l13so15006850iga.5
        for <ceph-devel@vger.kernel.org>; Fri, 13 Feb 2015 23:56:18 -0800 (PST)
In-Reply-To: <54DEEC5C.4030605@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Feb 13, 2015 at 10:34 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Greg,
>
> I'm curious to know how you handle the flow of mails from QA runs. Here is a wild guess:
>
> * from time to time check that the nightlies run the suites that should be run

Uh, I guess?

> * read the ceph-qa reports daily

Yeah

> * for each failed job, either relate it to an issue or create one or declare it noise

Yeah

> * if a job fails on an existing ticket store a link to the job if it's rare occurrence and the cause is not yet known

Yeah, or just to make clear it's still happening or whatever

> * bi-weekly bug scrub makes sure no issue, old or new, is forgotten

Hopefully!

> * at release time you decide that it is ready based on:
> ** the list of urgent/immediate issues that you can browse to ensure no issue is a blocker
> ** the last run of each suite to ensure they are recent enough and environmental noise did not permanently shadow anything

Yeah. Well, the last run alone isn't so important; we want to see a
string of clean runs because a lot of issues aren't reproduced in
every run.
-Greg
