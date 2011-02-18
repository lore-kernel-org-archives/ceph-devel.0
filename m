From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Fri, 18 Feb 2011 11:07:35 -0800
Message-ID: <AANLkTimC0eTX7NjLLPjWGOpa0FYiTiO0TsG3B5A1Waht@mail.gmail.com>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
	<75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
	<1297893011.25491.124.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
	<Pine.LNX.4.64.1102161651380.11150@cobra.newdream.net>
	<1297957574.25491.152.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1102170805080.22514@cobra.newdream.net>
	<1297985503.25491.175.camel@sale659.sandia.gov>
	<Pine.LNX.4.64.1102172312550.26016@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59442 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab1BRTIT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Feb 2011 14:08:19 -0500
Received: by fxm20 with SMTP id 20so4106812fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 Feb 2011 11:08:18 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1102172312550.26016@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Jim Schutt <jaschut@sandia.gov>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> Anybody else have ideas?  :/
>

At the risk of asking a dumb question, does syslog have messages from
ntpd about date/time adjustments?

Also, what is the load on the system like? dout will write to a
logfile using write(2), which of course is a blocking system call. 28
seconds is a long time for a write to block, but things can get weird
under heavy I/O.

A more general problem is priority inversion through the dout lock.
=46or example, some other piece of code could be doing something like t=
his

dout << my_happy_printer_function() << dendl

If my_happy_printer_function takes some heavily contended locks, this
will turn into
1. lock dout lock
2. lock heavily contended locks
3. write(2) to logfile
4. unlock ""
5. unlock dout lock

This is one reason why I want to get rid of the dout lock (although
not the only one.)

Colin


On Thu, Feb 17, 2011 at 11:13 PM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 17 Feb 2011, Jim Schutt wrote:
>> Check out the result:
>>
>> osd.68.log:256027:2011-02-17 15:44:50.141378 7fd42ad57940 osd68 5 ti=
ck
>> osd.68.log:256028:2011-02-17 15:44:50.141464 7fd42ad57940 osd68 5 ti=
ck getting read lock on map_lock
>> osd.68.log:256029:2011-02-17 15:44:50.141472 7fd42ad57940 osd68 5 ti=
ck got read lock on map_lock
>> osd.68.log:256031:2011-02-17 15:44:50.141612 7fd42ad57940 osd68 5 ti=
ck sending mon report
>> osd.68.log:256032:2011-02-17 15:44:50.141619 7fd42ad57940 osd68 5 ti=
ck removing stray pgs
>> osd.68.log:256033:2011-02-17 15:44:50.141626 7fd42ad57940 osd68 5 ti=
ck sending log to logclient
>> osd.68.log:256034:2011-02-17 15:44:50.141633 7fd42ad57940 osd68 5 ti=
ck arming timer for next tick =A0 =A0 <=3D=3D
>> osd.68.log:256277:2011-02-17 15:45:18.481656 7fd42ad57940 osd68 5 ti=
ck checking dispatch queue status <=3D=3D 28 second gap
>> osd.68.log:256278:2011-02-17 15:45:18.481669 7fd42ad57940 osd68 5 ti=
ck done
>> osd.68.log:256279:2011-02-17 15:45:18.481691 7fd42ad57940 osd68 5 ti=
ck
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
