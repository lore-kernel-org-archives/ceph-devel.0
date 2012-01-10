From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: towards a user-mode diagnostic log mechanism
Date: Mon, 9 Jan 2012 18:20:08 -0800
Message-ID: <CA+qbEUPBh8PbV8gddG3QUz+bCq3Cd2NXvzmkfDYoTG_9fH+qHA@mail.gmail.com>
References: <4EEFF614.8040207@dreamhost.com>
	<CA+qbEUNvLL0pui+XOr5W2m6dmBCxg8d4ZobrAnXV=wTQ=7YCFw@mail.gmail.com>
	<4F07A3F8.8000407@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45183 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260Ab2AJCUJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jan 2012 21:20:09 -0500
Received: by werm1 with SMTP id m1so3131960wer.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jan 2012 18:20:08 -0800 (PST)
In-Reply-To: <4F07A3F8.8000407@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Kampe <mark.kampe@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Jan 6, 2012 at 5:46 PM, Mark Kampe <mark.kampe@dreamhost.com> w=
rote:
> On 01/05/12 20:09, Colin McCabe wrote:
>> Pantheios and log4cpp are two potential candidates. =A0I don't know =
that
>> much about either, unfortunately.
>
> Good suggestions. =A0I am also looking at varnish (suggested by Wido
> den Hollander) which does logging in a shared memory segment from
> which external processes can save it (or not). =A0What was (for me)
> a new idea here is the clean decoupling of in-memory event capture
> from on-disk persistence and log rotation. =A0After I thought about
> it for a few minutes, I concluded it had many nice consequences.

On-disk storage and log rotation is already decoupled from event
capture-- maybe even a little too decoupled.  The logging system can
send output to stderr, syslog, or a file.  It can even send to
multiple sinks at once.

Log rotation has never been done by Ceph itself.  If you want that,
you have to install a separate daemon.  On Fedora, that would be
"logrotate."  I realize there is a function named something like
"log_rotate" in the logging code, but actually it implements something
called the "symlink dance" which is needed by vstart.sh.  The less
said about that, the better.

Maybe what you are thinking of is copying all log output to a buffer,
but only permanently storing certain logs.  This could be useful in
the event of a crash or assertion.  This is a good idea in general,
but there are some things to keep in mind.

There is a bunch of code that performs really expensive operations
when lots of logging is enabled.  I remember seeing things like code
that printed out all elements in the PG history, etc.  This is
acceptable with the current logging system, because those logs never
even get created when the log level is low.  If you want "always-on"
logging, the first thing you'll have to do is audit all the code to
make sure nobody is performing very expensive operations when logging
is turned all the way up.

>
>
>> Honestly, I feel like logging is something that you will end up
>> customizing pretty extensively to suit the needs of your application=
=2E
>> But perhaps it's worth checking out what these libraries provide--
>> especially in terms of efficiency.
>
>
> I agree that the data captured is going to be something we hone
> based on experience. =A0I am (for now) most concerned with the
> mechanism ... because I don't want to start making big investments
> in instrumentation until we have a good mechanism, around which
> we can fix the APIs that instrumentation will use.
>
> I'll try to review the suggested candidates and describe the
> mechanisms and advantages of each in another two weeks.

Good luck with your review.  I hope you come up with something that
serves Ceph well.

Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
