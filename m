From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [ceph-users] O_DIRECT on deep-scrub read
Date: Fri, 9 Oct 2015 12:54:16 -0400
Message-ID: <CANP1eJHD+gHdMgVPadENS-7C-1qROKHRMsdLdq7Wj-VhC85new@mail.gmail.com>
References: <56150598.1080604@sadziu.pl>
	<alpine.DEB.2.00.1510070748580.8667@cobra.newdream.net>
	<561577DD.1050107@redhat.com>
	<alpine.DEB.2.00.1510071349410.8667@cobra.newdream.net>
	<5616251E.8090104@sadziu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:36201 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbbJIQyV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Oct 2015 12:54:21 -0400
Received: by lbcao8 with SMTP id ao8so88091500lbc.3
        for <ceph-devel@vger.kernel.org>; Fri, 09 Oct 2015 09:54:17 -0700 (PDT)
In-Reply-To: <5616251E.8090104@sadziu.pl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Pawe=C5=82_Sadowski?= <ceph@sadziu.pl>
Cc: Sage Weil <sage@newdream.net>, David Zafman <dzafman@redhat.com>, ceph-users <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 8, 2015 at 4:11 AM, Pawe=C5=82 Sadowski <ceph@sadziu.pl> wr=
ote:
>
> On 10/07/2015 10:52 PM, Sage Weil wrote:
> > On Wed, 7 Oct 2015, David Zafman wrote:
> >> There would be a benefit to doing fadvise POSIX_FADV_DONTNEED afte=
r
> >> deep-scrub reads for objects not recently accessed by clients.
> > Yeah, it's the 'except for stuff already in cache' part that we don=
't do
> > (and the kernel doesn't give us a good interface for).  IIRC there =
was a
> > patch that guessed based on whether the obc was already in cache, w=
hich
> > seems like a pretty decent heuristic, but I forget if that was in t=
he
> > final version.
>
> I've run some tests and it look like on XFS cache is discarded on
> O_DIRECT write and read but on EXT4 is discarded only on O_DIRECT wri=
te.
> I've found some patches to add support for "read only if in page cach=
e"
> (preadv2/RWF_NONBLOCK) but can't find them in kernel source. Maybe
> Milosz Tanski can tell more about that. I think it could help a bit
> during deep scrub.


After a fair amount of bike shedding on the API (and removing
pwritev2) it looked like we (me and Christoph) had enough consensus to
get it upstream. But sadly it died, akpm preferred different approach
(fincore) and with enough roadblocks it died :/

>
>
> >> I see the NewStore objectstore sometimes using the O_DIRECT  flag =
for writes.
> >> This concerns me because the open(2) man pages says:
> >>
> >> "Applications should avoid mixing O_DIRECT and normal I/O to the s=
ame file,
> >> and especially to overlapping byte regions in the same file.  Even=
 when the
> >> filesystem correctly handles the coherency issues in this situatio=
n, overall
> >> I/O throughput is likely to be slower than using either mode alone=
=2E"
> > Yeah: an O_DIRECT write will do a cache flush on the write range, s=
o if
> > there was already dirty data in cache you'll write twice.  There's
> > similarly an invalidate on read.  I need to go back through the new=
store
> > code and see how the modes are being mixed and how it can be avoide=
d...
> >
> > sage
> >
> >
> >> On 10/7/15 7:50 AM, Sage Weil wrote:
> >>> It's not, but it would not be ahrd to do this.  There are fadvise=
-style
> >>> hints being passed down that could trigger O_DIRECT reads in this=
 case.
> >>> That may not be the best choice, though--it won't use data that h=
appens
> >>> to be in cache and it'll also throw it out..
> >>>
> >>> On Wed, 7 Oct 2015, Pawe? Sadowski wrote:
> >>>
> >>>> Hi,
> >>>>
> >>>> Can anyone tell if deep scrub is done using O_DIRECT flag or not=
? I'm
> >>>> not able to verify that in source code.
> >>>>
> >>>> If not would it be possible to add such feature (maybe config op=
tion) to
> >>>> help keeping Linux page cache in better shape?
> >>>>
> >>>> Thanks,
>
> --
> PS
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




--=20
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
