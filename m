From: Elso Andras <elso.andras@gmail.com>
Subject: Re: v0.61.1 released
Date: Fri, 10 May 2013 20:53:19 +0200
Message-ID: <CAKxz0mwJtB5Gr9bHUPiEJrK-OYLcT5cLz6yDCQ9cfpM15cWJdQ@mail.gmail.com>
References: <alpine.DEB.2.00.1305091004170.32690@cobra.newdream.net>
 <CAKxz0mw8G8fykj3KC-Jjh=FkazcbDuBjG_tCNfcge+ofQykuFQ@mail.gmail.com> <alpine.DEB.2.00.1305101144450.27355@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:47553 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392Ab3EJSxl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 May 2013 14:53:41 -0400
Received: by mail-we0-f169.google.com with SMTP id x54so4393855wes.14
        for <ceph-devel@vger.kernel.org>; Fri, 10 May 2013 11:53:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1305101144450.27355@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Will it rebuild?
I need it for my own build.

Elbandi

2013/5/10 Sage Weil <sage@inktank.com>:
> On Fri, 10 May 2013, Elso Andras wrote:
>> Hi,
>>
>> Where is ceph_0.61.1-1.dsc? I could not find at
>> http://ceph.com/debian-cuttlefish/pool/main/c/ceph/
>
> There was some breakage in debian sid when we did the build, so we skipped
> it.  I happens semi-frequently, unfortunately :(
>
> sage
>
>
>>
>> Elbandi
>>
>> 2013/5/9 Sage Weil <sage@inktank.com>:
>> > This release fixes a problem when upgrading a bobtail cluster that had
>> > snapshots to cuttlefish.  Please use this instead of v0.61 if you are
>> > upgrading to avoid possible ceph-osd daemon crashes.  There is also fix
>> > for a problem deploying monitors and generating new authentication keys.
>> >
>> > Notable changes:
>> >
>> >  * osd: handle upgrade when legacy snap collections are present; repair
>> >    from previous failed restart
>> >  * ceph-create-keys: fix race with ceph-mon startup (which broke
>> >    'ceph-deploy gatherkeys ...')
>> >  * ceph-create-keys: gracefully handle bad response from ceph-osd
>> >  * sysvinit: do not assume default osd_data when automatically weighting
>> >    OSD
>> >  * osd: avoid crash from ill-behaved classes using getomapvals
>> >  * debian: fix squeeze dependency
>> >  * mon: debug options to log or dump leveldb transactactions
>> >
>> > You can get v0.61.1 from the usual places:
>> >
>> >  * Git at git://github.com/ceph/ceph.git
>> >  * Tarball at http://ceph.com/download/ceph-0.61.1.tar.gz
>> >  * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
>> >  * For RPMs, see http://ceph.com/docs/master/install/rpm
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
