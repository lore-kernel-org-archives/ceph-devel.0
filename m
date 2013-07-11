From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: Re: wip-libcephfs-rebased-v65 ready for pull
Date: Thu, 11 Jul 2013 15:11:00 -0400 (EDT)
Message-ID: <669764413.145.1373569860896.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <1375543209.143.1373569719851.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:3794 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050Ab3GKTLJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Jul 2013 15:11:09 -0400
In-Reply-To: <1375543209.143.1373569719851.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,

It's up to you folks.  If the next window works better, let's just enter it early.

Matt

----- "Sage Weil" <sage@inktank.com> wrote:

> Hi,
> 
> I've rebased this on master, and cherry-picked the fixes from Ilya on
> top.  
> The exception is the xattr changes, which turned out to be an MDS bug
> 
> turned by up the unit test.
> 
> Is there a particular need for this to be in dumpling?  I'm inclined
> to 
> delay a release to avoid potentially destabliizing things this late in
> the 
> game.
> 
> Thanks!
> sage
> 
> 
> On Wed, 10 Jul 2013, Matt W. Benjamin wrote:
> 
> > Hi,
> > 
> > We tracked down the refcount issue found Sat., and have
> rebased/pushed wip-libcephfs-rebased-v65
> > with the fix.
> > 
> > Thanks!
> > 
> > Matt
> > 
> > -- 
> > Matt Benjamin
> > The Linux Box
> > 206 South Fifth Ave. Suite 150
> > Ann Arbor, MI  48104
> > 
> > http://linuxbox.com
> > 
> > tel.  734-761-4689 
> > fax.  734-769-8938 
> > cel.  734-216-5309 
> > --
> > To unsubscribe from this list: send the line "unsubscribe
> ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> >

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
