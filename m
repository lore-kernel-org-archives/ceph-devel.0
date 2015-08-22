From: Sage Weil <sage@newdream.net>
Subject: Re: Ceph Hackathon: More Memory Allocator Testing
Date: Sat, 22 Aug 2015 06:55:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508220653120.13116@cobra.newdream.net>
References: <55D409F0.3050802@redhat.com> <1491599152.40068072.1439992888600.JavaMail.zimbra@oxygem.tv> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE127C5@SACMBXIP01.sdcorp.global.sandisk.com> <55D4E470.9030501@profihost.ag> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12841@SACMBXIP01.sdcorp.global.sandisk.com>
 <55D4E793.9040408@profihost.ag> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12899@SACMBXIP01.sdcorp.global.sandisk.com> <55D4E9BE.8000309@profihost.ag> <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12966@SACMBXIP01.sdcorp.global.sandisk.com>
 <EA545303A8F8E842820A172C3D641D6E1B09E891@SACMBXIP01.sdcorp.global.sandisk.com> <CANP1eJH=mhQ1rBkUD8=yuF26s2t2vO0JMO-wKOLQ8VbWdEmxxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56363 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbbHVNzv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 22 Aug 2015 09:55:51 -0400
In-Reply-To: <CANP1eJH=mhQ1rBkUD8=yuF26s2t2vO0JMO-wKOLQ8VbWdEmxxw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: Shishir Gowda <Shishir.Gowda@sandisk.com>, Somnath Roy <Somnath.Roy@sandisk.com>, Stefan Priebe <s.priebe@profihost.ag>, Alexandre DERUMIER <aderumier@odiso.com>, Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 21 Aug 2015, Milosz Tanski wrote:
> On Fri, Aug 21, 2015 at 12:22 AM, Shishir Gowda
> <Shishir.Gowda@sandisk.com> wrote:
> > Hi All,
> >
> > Have sent out a pull request which enables building librados/librbd with either tcmalloc(as default)  or jemalloc.
> >
> > Please find the pull request @ https://github.com/ceph/ceph/pull/5628
> >
> > With regards,
> > Shishir
> 
> Unless I'm missing something here, this seams like the wrong thing to.
> Libraries that will be linked in by other external applications should
> not have a 3rd party malloc linked in there. That seams like an
> application choice. At the very least the default should not be to
> link in a 3rd party malloc.

Yeah, I think you're right.

Note that this isn't/wasn't always the case, though.. on precise, for 
instance, libleveldb links libtcmalloc.  They stopped doing this 
sometime before trusty.

sage
