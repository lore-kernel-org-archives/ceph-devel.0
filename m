From: Greg Farnum <gregory.farnum@dreamhost.com>
Subject: Re: Clocks Not Synchronized
Date: Wed, 21 Mar 2012 09:57:18 -0700
Message-ID: <A08B7F7C85B549F5AB38DC08F32DB998@dreamhost.com>
References: <4F699FBA02000099000DD40B@collaborate.seakr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63042 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315Ab2CUQ5W convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Mar 2012 12:57:22 -0400
Received: by obbeh20 with SMTP id eh20so816513obb.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Mar 2012 09:57:21 -0700 (PDT)
In-Reply-To: <4F699FBA02000099000DD40B@collaborate.seakr.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Couchman <Nick.Couchman@seakr.com>
Cc: ceph-devel@vger.kernel.org

On Wednesday, March 21, 2012 at 8:30 AM, Nick Couchman wrote:
> I'm setting up ceph and looking at the output of "ceph -w" and I'm se=
eing lots of warnings about messages from mon.X being stamped in the fu=
ture (142 seconds), clocks not synchronized. However, all of these syst=
ems use NTP, and if I use the "date" command to see the system time, th=
ey are definitely synchronized to within a second or so - definitely no=
t out of sync 142 seconds. What else should I check?
> =20

All the check for future timestamps does is get the time and compare to=
 the one in a lease message. The only thing I can think of is if you've=
 set the "clock offset" parameter on one machine, which seems unlikely=E2=
=80=A6The other possibilities are that
1) we somehow broke how we're passing timestamps along and nobody else =
has seen it. This is unlikely =E2=80=94 we haven't made any changes to =
this in a long time that I'm aware of.
2) one of the Monitors is running gettimeofday() and seeing that the pa=
ssed-along timestamp (from gettimeofday() on the other host) is 142 sec=
onds in the future.
So=E2=80=A6try running date on each of them again? :) Unless people are=
 aware of date and gettimeofday() somehow not being in sync?
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
