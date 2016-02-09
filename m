From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: Prevent rbd mapping/mounting on multiple hosts workaround
Date: Mon, 8 Feb 2016 20:25:49 -0500 (EST)
Message-ID: <548678370.20789680.1454981149809.JavaMail.zimbra@redhat.com>
References: <CAAVaRixeAPiyK2Xx1=nXAZBD=8ckctgFV=6Ag2EyTsAGhPrPUw@mail.gmail.com> <CAAVaRixPMWYibHFmmZmVgYB3RjPWaO2-gEhoyTnCHpBkkZjbgQ@mail.gmail.com> <CAJ4mKGb4x3Wn=hK_qz_p-fkWxcjQSJnotX=mz4pfM-DyPCQxZw@mail.gmail.com> <913505319.20723124.1454964252136.JavaMail.zimbra@redhat.com> <CAEhqmjLL8et0OPVVwHiCVqnuxpPj8VyjojS0OBgraOr0i0_gHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:59302 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932520AbcBIBZx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Feb 2016 20:25:53 -0500
In-Reply-To: <CAEhqmjLL8et0OPVVwHiCVqnuxpPj8VyjojS0OBgraOr0i0_gHA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bill Sanders <billysanders@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Mauricio Garavaglia <mauricio@medallia.com>, ceph-devel <ceph-devel@vger.kernel.org>

Yes, and 100% concur that this needs to be optional -- plenty of valid use-cases where the device is mapped concurrently.

Thanks,
Jason Dillaman 


----- Original Message -----
> From: "Bill Sanders" <billysanders@gmail.com>
> To: "Jason Dillaman" <dillaman@redhat.com>
> Cc: "Gregory Farnum" <gfarnum@redhat.com>, "Mauricio Garavaglia" <mauricio@medallia.com>, "ceph-devel"
> <ceph-devel@vger.kernel.org>
> Sent: Monday, February 8, 2016 5:41:37 PM
> Subject: Re: Prevent rbd mapping/mounting on multiple hosts workaround
> 
> So the idea here to prevent multiple hosts from mapping the same RBD
> image simultaneously?  If so, please do try to keep it optional (even
> if it's the default)... I'm not sure who else might, but Teradata
> relies on this functionality. :)
> 
> Thanks,
> Bill
> 
> On Mon, Feb 8, 2016 at 12:44 PM, Jason Dillaman <dillaman@redhat.com> wrote:
> > Within librbd there is support for blacklisting clients before stealing the
> > exclusive lock.  I don't remember any such enhancement to the rbd CLI's
> > map command.  In general it sounds like a good feature request.  The
> > automatic unblacklist on reboot would be outside the scope of any rbd CLI
> > change.  I added a new tracker ticket for the feature request.
> >
> > [1] http://tracker.ceph.com/issues/14700
> >
> > --
> >
> > Jason Dillaman
> >
> >
> > ----- Original Message -----
> >> From: "Gregory Farnum" <gfarnum@redhat.com>
> >> To: "Mauricio Garavaglia" <mauricio@medallia.com>, "Jason Dillaman"
> >> <dillaman@redhat.com>
> >> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> >> Sent: Monday, February 8, 2016 10:41:40 AM
> >> Subject: Re: Prevent rbd mapping/mounting on multiple hosts workaround
> >>
> >> On Fri, Feb 5, 2016 at 6:24 AM, Mauricio Garavaglia
> >> <mauricio@medallia.com> wrote:
> >> > Hello,
> >> >
> >> > In the January Tech Talk (PostgreSQL on Ceph under Mesos/Aurora with
> >> > Docker [https://youtu.be/OqlC7S3cUKs]) we presented a challenge we are
> >> > facing at Medallia when running databases on ceph under
> >> > mesos/aurora/docker; which is related to prevent mapping/mounting the
> >> > same rbd image in two hosts at the same time during network
> >> > partitions.
> >> >
> >> > As a workaround it was mentioned that we are wrapping rbd in a shell
> >> > script that executes extra logic around certain operations:
> >> >
> >> > - On Map; rbd lock add <image>
> >> >         - If no success; then
> >> >                 - "rbd status <image>": check for Watchers, 3 times each
> >> >                 15
> >> >                 secs
> >> >                         - If found, ABORT the mapping. The image is
> >> > still in use in a host that is healthy
> >> >                 - "ceph osd blacklist add <previous lock holder>".
> >> > Image locked without a watcher
> >> >                 - steal the lock in <image>
> >> >         - map the image
> >> >
> >> > - On Unmap;
> >> >         - rbd lock remove
> >> >
> >> > - On reboot of server;
> >> >         - "ceph osd blacklist rm <self>"
> >> >
> >> > I was wondering if this mechanism could be incorporated as part of the
> >> > rbd CLI, of course controlled by an option during map. We'll be happy
> >> > to work on it, but want to check the feasibility of having the patch
> >> > accepted.
> >>
> >> I actually thought we had a disable-by-default config option in later
> >> releases that grab the locks before allowing a mount, but now I can't
> >> find it. Jason?
> >> -Greg
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
