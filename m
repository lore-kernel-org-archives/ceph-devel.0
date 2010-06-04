From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: cosd death by oom-killer
Date: Fri, 4 Jun 2010 09:26:57 -0700
Message-ID: <AANLkTin63NnmUkd1StdJ6eFYcE69T7g5MzhqLf0Phatx@mail.gmail.com>
References: <1274912650.4773.243.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1005261626220.24698@cobra.newdream.net>
	<1275600252.4800.13.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1006031635520.29455@cobra.newdream.net>
	<1275662498.4800.34.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44471 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523Ab0FDQ1c convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jun 2010 12:27:32 -0400
Received: by gwaa12 with SMTP id a12so1018923gwa.19
        for <ceph-devel@vger.kernel.org>; Fri, 04 Jun 2010 09:27:31 -0700 (PDT)
In-Reply-To: <1275662498.4800.34.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jun 4, 2010 at 7:41 AM, Jim Schutt <jaschut@sandia.gov> wrote:
>> =A0It's not a complete solution to the
>> memory use issue, but it covers the most common problem (client indu=
ced
>> memory use), and your problem in particular.
>
> Will it also maybe address the possibility of OOM during recovery?
Probably not -- we're just going to put a limit on how much data
clients can shove into a server's memory. The server itself (and its
peers) aren't very careful about it, and right now at least they
really can't be due to their protocol expectations.
But I imagine that it won't be such an issue if you enable swap, and
this should let you do that without a client overwhelming your system.
:)
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
