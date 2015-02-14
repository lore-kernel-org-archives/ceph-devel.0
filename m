From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: [Ceph-qa] 1 hung, 11 passed in
 teuthology-2015-02-11_16:13:01-samba-giant-distro-basic-multi
Date: Sat, 14 Feb 2015 11:22:50 -0500 (EST)
Message-ID: <1611171464.18352749.1423930970636.JavaMail.zimbra@redhat.com>
References: <20150213035821.17712282150@teuthology.front.sepia.ceph.com> <CAC6JEv9pUeCtjs_SBeqr5N=4aSUUuUsbDW3eMipVsBTq5AkZkQ@mail.gmail.com> <54DEEC5C.4030605@dachary.org> <CAC6JEv_7OEsLkj1vm65Jxqh4e7LBnTQUAp6r0_5Tbs0-Z=YZZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:48011 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566AbbBNQX4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 14 Feb 2015 11:23:56 -0500
In-Reply-To: <CAC6JEv_7OEsLkj1vm65Jxqh4e7LBnTQUAp6r0_5Tbs0-Z=YZZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

> Yeah. Well, the last run alone isn't so important; we want to see a
> string of clean runs because a lot of issues aren't reproduced in
> every run.

My hope was that we can see all "green" results for say this giant release/backport, but I agree that we would need to make our go/no-go decision based on multiple run results, as I am not sure if we can get them all "green" due to complexity, time needed to execute, environment state etc..

We could thou modify our process a bit:
1. after backport-branch is ready for QE, merge it to the named branch (say 'giant' in this example) - that what we did now
2. cut a release numbered brach (maybe it's tag, not sure), say "v0.87.1"
3. run all QE suites on "v0.87.1" and get it to "all passed" state
4. make sure that commits to "v0.87.1" are committed to the named branch ('giant') 

#2 is that we have not done this time.

Thx
YuriW

----- Original Message -----
From: "Gregory Farnum" <greg@gregs42.com>
To: "Loic Dachary" <loic@dachary.org>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Friday, February 13, 2015 11:56:18 PM
Subject: Re: [Ceph-qa] 1 hung, 11 passed in teuthology-2015-02-11_16:13:01-samba-giant-distro-basic-multi

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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
