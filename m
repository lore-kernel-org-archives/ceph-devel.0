From: Bill Sanders <billysanders@gmail.com>
Subject: Re: [ceph-users] v10.0.2 released
Date: Thu, 14 Jan 2016 11:27:17 -0800
Message-ID: <CAEhqmjLGJN_c1wXW3yHc=kKab7w2mgfH6E8TqTds-VvKxDNfWA@mail.gmail.com>
References: <alpine.DEB.2.11.1601141033010.21258@cpach.fuggernut.com> <CADRKj5TXdCmDS5aX5+HRee9fOr7Za4y_WGJhja0eyxhdTcHefA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36634 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318AbcANT1h (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jan 2016 14:27:37 -0500
Received: by mail-yk0-f181.google.com with SMTP id v14so424898399ykd.3
        for <ceph-devel@vger.kernel.org>; Thu, 14 Jan 2016 11:27:37 -0800 (PST)
In-Reply-To: <CADRKj5TXdCmDS5aX5+HRee9fOr7Za4y_WGJhja0eyxhdTcHefA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>, "ceph-maintainers@ceph.com" <ceph-maintainers@ceph.com>, ceph-announce@ceph.com

Is there some information about rbd-nbd somewhere?  If it has feature
parity with librbd and is easier to maintain, will this eventually
deprecate krbd?  We're using the RBD kernel client right now, and so
this looks like something we might want to explore at my employer.

Bill

On Thu, Jan 14, 2016 at 9:04 AM, Yehuda Sadeh-Weinraub
<yehuda@redhat.com> wrote:
> On Thu, Jan 14, 2016 at 7:37 AM, Sage Weil <sweil@redhat.com> wrote:
>> This development release includes a raft of changes and improvements for
>> Jewel. Key additions include CephFS scrub/repair improvements, an AIX and
>> Solaris port of librados, many librbd journaling additions and fixes,
>> extended per-pool options, and NBD driver for RBD (rbd-nbd) that allows
>> librbd to present a kernel-level block device on Linux, multitenancy
>> support for RGW, RGW bucket lifecycle support, RGW support for Swift
>
> rgw bucket lifecycle isn't there, it still has some more way to go
> before we merge it in.
>
> Yehuda
>
>> static large objects (SLO), and RGW support for Swift bulk delete.
>>
>> There are also lots of smaller optimizations and performance fixes going
>> in all over the tree, particular in the OSD and common code.
>>
>> Notable Changes
>> ---------------
>>
>> See
>>
>>         http://ceph.com/releases/v10-0-2-released/
>>
>> [I'd include the changelog here but I'm missing a oneliner that renders
>> the rst in email-suitable form...]
>>
>> Getting Ceph
>> ------------
>>
>> * Git at git://github.com/ceph/ceph.git
>> * Tarball at http://download.ceph.com/tarballs/ceph-10.0.2.tar.gz
>> * For packages, see http://ceph.com/docs/master/install/get-packages
>> * For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
