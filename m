From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: About ceph_clock_now()
Date: Mon, 25 Jan 2016 15:18:08 -0500 (EST)
Message-ID: <935383330.24835824.1453753088174.JavaMail.zimbra@redhat.com>
References: <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com> <2002283349.16405061.1453715910495.JavaMail.zimbra@redhat.com> <56A5FF84.8080107@digiware.nl> <20160125172252.GA2818@ultraspiritum.redhat.com> <56A66099.4030501@digiware.nl> <1523354716.24670379.1453744826329.JavaMail.zimbra@redhat.com> <56A679BB.4090801@digiware.nl> <20160125201451.GC2818@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:60694 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756837AbcAYUSK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 25 Jan 2016 15:18:10 -0500
In-Reply-To: <20160125201451.GC2818@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: Willem Jan Withagen <wjw@digiware.nl>, Erwan Velu <evelu@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

inline

----- Original Message -----
> From: "Adam C. Emerson" <aemerson@redhat.com>
> To: "Willem Jan Withagen" <wjw@digiware.nl>
> Cc: "Matt Benjamin" <mbenjamin@redhat.com>, "Erwan Velu" <evelu@redhat.com>, "Ceph Development"
> <ceph-devel@vger.kernel.org>, "Sage Weil" <sweil@redhat.com>
> Sent: Monday, January 25, 2016 3:14:51 PM
> Subject: Re: About ceph_clock_now()
> 
> On 25/01/2016, Willem Jan Withagen wrote:
> > 1)
> > Currently the code in Adam's looks like:
> > #if defined(CLOCK_MONOTONIC_COARSE)
> >         // Linux systems have _COARSE clocks.
> >         clock_gettime(CLOCK_MONOTONIC_COARSE, &ts);
> > #elif defined(CLOCK_MONOTONIC_FAST)
> >         // BSD systems have _FAST clocks.
> >         clock_gettime(CLOCK_MONOTONIC_FAST, &ts);
> > #else
> >         // And if we find neither, you may wish to consult your system's
> >         // documentation.
> > #warning Falling back to CLOCK_MONOTONIC, may be slow.
> >         clock_gettime(CLOCK_MONOTONIC, &ts);
> > #endif
> > 
> > And this is repeated in a few more locations.
> > Moreover, it will be required to do that a few times everytime
> > clock_getime is used.
> 
> I was originally thinking of just specifying the time constant, but I figured
> that somehow somewhere someone might want to compile on a system without
> clock_gettime. (Windows? I don't know.) Or use the fasttime library or
> something
> where just switching out the constant wouldn't work.
> 
> I wouldn't worry about people having to do this every tie they call
> clock_gettime, though, since they really ought to be going through the C++
> Clock
> abstraction. (At least, in the context of the Ceph codebase.)

exactly, this.

> 
> --
> Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
> IRC: Aemerson@{RedHat, OFTC, Freenode}
> 0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
> 

-- 
-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
