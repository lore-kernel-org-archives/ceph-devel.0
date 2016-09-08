From: Wido den Hollander <wido@42on.com>
Subject: Re: librados.h version numbers
Date: Thu, 8 Sep 2016 15:29:41 +0200 (CEST)
Message-ID: <1735254177.3909.1473341381129@ox.pcextreme.nl>
References: <1843378866.3701.1473189527273@ox.pcextreme.nl>
 <37bd7608-3352-5057-d238-e04517640f5b@redhat.com>
 <CAJ4mKGaLv+n8JsJkAYSoNz+3N3rsJHe+tjwoReN_B3AQPibAKQ@mail.gmail.com>
 <77759347.3838.1473317968120@ox.pcextreme.nl>
 <alpine.DEB.2.11.1609081322310.32742@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:58172 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751944AbcIHN3p (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2016 09:29:45 -0400
In-Reply-To: <alpine.DEB.2.11.1609081322310.32742@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Josh Durgin <jdurgin@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>


> Op 8 september 2016 om 15:24 schreef Sage Weil <sweil@redhat.com>:
> 
> 
> On Thu, 8 Sep 2016, Wido den Hollander wrote:
> > > Op 8 september 2016 om 3:08 schreef Gregory Farnum <gfarnum@redhat.com>:
> > > 
> > > 
> > > On Tue, Sep 6, 2016 at 4:16 PM, Josh Durgin <jdurgin@redhat.com> wrote:
> > > > On 09/06/2016 12:18 PM, Wido den Hollander wrote:
> > > >>
> > > >> Hi,
> > > >>
> > > >> wido@wido-laptop:~$ python -c "import rados; r = rados.Rados();
> > > >> print(r.version())"
> > > >> 0.69.1
> > > >> wido@wido-laptop:~$ dpkg -l|grep rados|awk '{print $2" "$3}'
> > > >> librados-dev 10.2.2-1trusty
> > > >> librados2 10.2.2-1trusty
> > > >> libradosstriper1 10.2.2-1trusty
> > > >> python-rados 10.2.2-1trusty
> > > >> wido@wido-laptop:~$
> > > >>
> > > >> Looking at librados.h in master I see:
> > > >>
> > > >> #define LIBRADOS_VER_MAJOR 0
> > > >> #define LIBRADOS_VER_MINOR 69
> > > >> #define LIBRADOS_VER_EXTRA 1
> > > >>
> > > >> Is this something which has just been forgotten to update?
> > > >
> > > >
> > > > Pretty much. Not much has relied on the librados/librbd version numbers
> > > > of this style. Adding tests for particular functions can be more
> > > > reliable than checking version numbers, since sometimes functions are
> > > > backported.
> > > >
> > > >> Looking at the 'ceph' tool I see:
> > > >>
> > > >> CEPH_GIT_NICE_VER="10.2.2"
> > > >>
> > > >> This is updated during packaging/build it seems.
> > > >>
> > > >> Should we maybe do that for librados.h as well?
> > > >
> > > >
> > > > I see no reason not to.
> > > 
> > > We at one point were trying to only increment the librados library
> > > version when stuff actually changed. Shockingly, that manual
> > > maintenance mostly resulted in it not getting updated. ;)
> > > But is it really that helpful to just provide another way of exposing
> > > the package version, instead of doing something that actually
> > > illustrates what functions are around? :/
> > 
> > I was using some Python code to gather Ceph information ( 
> > https://github.com/42on/ceph-collect ). One of the things I wanted to 
> > know is the installed Ceph version and I used the version() method.
> > 
> > It kept giving back 0.69.1 so I started looking into that.
> > 
> > I just try to avoid calling subprocesses when this isn't required.
> > 
> > Since the version() method is unreliable in giving back the version, 
> > what to do with it?
> 
> Let's remove those #defines from the header, and then do something like 
> include the auto-generated ceph_ver.h in the package, and update the 
> version functions to #include that and return an accurate string...
> 

yeah, one thing though.

#define CEPH_GIT_VER @CEPH_GIT_VER@
#define CEPH_GIT_NICE_VER "@CEPH_GIT_NICE_VER@"

librados.h:

CEPH_RADOS_API void rados_version(int *major, int *minor, int *extra);

We don't have major, minor and extra stored separately in ceph_ver.h at the moment.

Wido 

> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
