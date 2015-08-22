From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: Ceph Hackathon: More Memory Allocator Testing
Date: Sat, 22 Aug 2015 16:15:36 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE1DC70@SACMBXIP01.sdcorp.global.sandisk.com>
References: <55D409F0.3050802@redhat.com>
 <1491599152.40068072.1439992888600.JavaMail.zimbra@oxygem.tv>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE127C5@SACMBXIP01.sdcorp.global.sandisk.com>
 <55D4E470.9030501@profihost.ag>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12841@SACMBXIP01.sdcorp.global.sandisk.com>
 <55D4E793.9040408@profihost.ag>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12899@SACMBXIP01.sdcorp.global.sandisk.com>
 <55D4E9BE.8000309@profihost.ag>
 <755F6B91B3BE364F9BCA11EA3F9E0C6F2CE12966@SACMBXIP01.sdcorp.global.sandisk.com>
 <EA545303A8F8E842820A172C3D641D6E1B09E891@SACMBXIP01.sdcorp.global.sandisk.com>
 <CANP1eJH=mhQ1rBkUD8=yuF26s2t2vO0JMO-wKOLQ8VbWdEmxxw@mail.gmail.com>
 <alpine.DEB.2.00.1508220653120.13116@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0054.outbound.protection.outlook.com ([157.56.111.54]:19232
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753144AbbHVQPq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 22 Aug 2015 12:15:46 -0400
In-Reply-To: <alpine.DEB.2.00.1508220653120.13116@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Milosz Tanski <milosz@adfin.com>
Cc: Shishir Gowda <Shishir.Gowda@sandisk.com>, Stefan Priebe <s.priebe@profihost.ag>, Alexandre DERUMIER <aderumier@odiso.com>, Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Yes, even today rocksdb also linked with tcmalloc. It doesn't mean all the application using rocksdb needs to be built with tcmalloc.
Sage,
Wanted to know is there any reason we didn't link client libraries with tcmalloc at the first place (but did link only OSDs/mon/RGW) ?

Thanks & Regards
Somnath

-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net]
Sent: Saturday, August 22, 2015 6:56 AM
To: Milosz Tanski
Cc: Shishir Gowda; Somnath Roy; Stefan Priebe; Alexandre DERUMIER; Mark Nelson; ceph-devel
Subject: Re: Ceph Hackathon: More Memory Allocator Testing

On Fri, 21 Aug 2015, Milosz Tanski wrote:
> On Fri, Aug 21, 2015 at 12:22 AM, Shishir Gowda
> <Shishir.Gowda@sandisk.com> wrote:
> > Hi All,
> >
> > Have sent out a pull request which enables building librados/librbd with either tcmalloc(as default)  or jemalloc.
> >
> > Please find the pull request @
> > https://github.com/ceph/ceph/pull/5628
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

Note that this isn't/wasn't always the case, though.. on precise, for instance, libleveldb links libtcmalloc.  They stopped doing this sometime before trusty.

sage

________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).

