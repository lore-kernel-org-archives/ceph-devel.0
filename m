From: John Spray <jspray@redhat.com>
Subject: Re: Suggestions on tracker 13578
Date: Wed, 2 Dec 2015 20:34:31 +0000
Message-ID: <CALe9h7dJUYMjkVcgnRfKcR=idFF1Su__O+SdmzMWMCfa19Es1A@mail.gmail.com>
References: <565D9F61.6070108@redhat.com> <CAJ4mKGbg159aO7S1soYnR+uhR9uV=t3EjYW2Q=2fbh+PPeEAeQ@mail.gmail.com>
 <565F40AB.5060804@redhat.com> <622F4407872BA447A16110F65453358C04CDB8EA221A@FMSAMAIL.fmsa.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33694 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbbLBUgw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 2 Dec 2015 15:36:52 -0500
Received: by igcmv3 with SMTP id mv3so126442216igc.0
        for <ceph-devel@vger.kernel.org>; Wed, 02 Dec 2015 12:36:51 -0800 (PST)
In-Reply-To: <622F4407872BA447A16110F65453358C04CDB8EA221A@FMSAMAIL.fmsa.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>
Cc: Mark Nelson <mnelson@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Vimal <vikumar@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Dec 2, 2015 at 7:54 PM, Paul Von-Stamwitz
<PVonStamwitz@us.fujitsu.com> wrote:
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Mark Nelson
>> Sent: Wednesday, December 02, 2015 11:04 AM
>> To: Gregory Farnum; Vimal
>> Cc: ceph-devel
>> Subject: Re: Suggestions on tracker 13578
>>
>>
>> On 12/02/2015 12:23 PM, Gregory Farnum wrote:
>> > On Tue, Dec 1, 2015 at 5:23 AM, Vimal <vikumar@redhat.com> wrote:
>> >> Hello,
>> >>
>> >> This mail is to discuss the feature request at
>> >> http://tracker.ceph.com/issues/13578.
>> >>
>> >> If done, such a tool should help point out several mis-configurations
>> >> that may cause problems in a cluster later.
>> >>
>> >> Some of the suggestions are:
>> >>
>> >> a) A check to understand if the MONs and OSD nodes are on the same
>> machines.
>> >>
>> >> b) If /var is a separate partition or not, to prevent the root
>> >> filesystem from being filled up.
>> >>
>> >> c) If monitors are deployed in different failure domains or not.
>> >>
>> >> d) If the OSDs are deployed in different failure domains.
>> >>
>> >> e) If a journal disk is used for more than six OSDs. Right now, the
>> >> documentation suggests upto 6 OSD journals to exist on a single
>> >> journal disk.
>> >>
>> >> f) Failure domains depending on the power source.
>> >>
>> >> There can be several more checks, and it can be a useful tool to test
>> >> the problems an existing cluster or a new installation.
>> >>
>> >> But I'd like to know how the engineering community sees this, if its
>> >> seems to be worth pursuing, and what suggestions do you have for
>> >> improving/adding to this.
>> >
>> > This is a user experience and support tool; I don't think the
>> > engineering community can really judge its value. ;)
>> >
>> > So sure, sounds good to me. It'll need to get into the hands of users
>> > before we find out if it's a good plan or not. I was at the SDI Summit
>> > yesterday and was hearing about how some of our choices (like
>> > HEALTH_WARN on pg counts) are *really* scary for users who think
>> > they're in danger of losing data. I suspect the difficulty of a tool
>> > like this will be more in the communication of issues and severity,
>> > more than in what exactly we choose to check.
>>
>> Frankly I've never been a big fan of how we report warnings like this through
>> the health check.  It's important to let users know if they've set up things
>> sub-optimally, but I don't think ceph health is the way to do it.  The
>> difference between your doctor telling you you should exercise more and
>> lose a few pounds vs you have Ebola and are going to suffer an incredibly
>> gruesome and painful death in the next 48 hours. :)
>>
>
> Since I was the one at the SDI Summit that took issue with some of these warnings, I whole-heartedly agree with Greg's and Mark's comments. A warning at health check should indicate to the user that some corrective action should be taken, besides turning the warning off :-) I do not have an issue reporting advisories, but they should be kept separate true warnings. If we want to notify the user of variances from best practices, I suggest a separate method, i.e. "ceph advise", rather than constantly repeating them on health checks.

Separating things into "advise" vs. "health" probably doesn't solve
the problem, because one has to decide what goes in which section, and
ends up with the same problem as INFO/WARN/ERR categorisation -- the
idea of having different categories is fine, the hard part is
assigning particular items to a category in a way that makes sense for
different users.

IMHO the core problems are attempting to collapse all these
notifications into a global indicator, and attempting to do that in
the same way for all systems.  It needs to be finer grained than that.
I never got around to doing anything with #7192 [1], but it outlines a
way to change the health outlet into a form where it's easier to
selectively ignore particular items.

Once you break down the health output into a set of known status
codes, a natural extension would be to have user-configurable masks,
so that they could cancel particular warnings if they wanted to.
Think of it like having the ability to press the warning lights in an
aeroplane cockpit to turn off the alarm sound.

John

1. http://tracker.ceph.com/issues/7192
