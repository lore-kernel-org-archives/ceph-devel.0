From: Neil Levine <neil.levine@inktank.com>
Subject: Re: [ceph-users] CephFS First product release discussion
Date: Tue, 5 Mar 2013 21:01:29 -0800
Message-ID: <CANygib-U_MQi1TMmQuT_Q9MVwPfT+PzJwN=+BMcBK69WuRfu3w@mail.gmail.com>
References: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51917 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab3CFFBa convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 00:01:30 -0500
Received: by mail-ie0-f174.google.com with SMTP id k10so8760263iea.5
        for <ceph-devel@vger.kernel.org>; Tue, 05 Mar 2013 21:01:29 -0800 (PST)
In-Reply-To: <E0B1337A572647BA9FCC0CE8CA946F42@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

As an extra request, it would be great if people explained a little
about their use-case for the filesystem so we can better understand
how the features requested map to the type of workloads people are
trying.

Thanks

Neil

On Tue, Mar 5, 2013 at 9:03 AM, Greg Farnum <greg@inktank.com> wrote:
> This is a companion discussion to the blog post at http://ceph.com/de=
v-notes/cephfs-mds-status-discussion/ =97 go read that!
>
> The short and slightly alternate version: I spent most of about two w=
eeks working on bugs related to snapshots in the MDS, and we started re=
alizing that we could probably do our first supported release of CephFS=
 and the related infrastructure much sooner if we didn't need to suppor=
t all of the whizbang features. (This isn't to say that the base featur=
e set is stable now, but it's much closer than when you turn on some of=
 the other things.) I'd like to get feedback from you in the community =
on what minimum supported feature set would prompt or allow you to star=
t using CephFS in real environments =97 not what you'd *like* to see, b=
ut what you *need* to see. This will allow us at Inktank to prioritize =
more effectively and hopefully get out a supported release much more qu=
ickly! :)
>
> The current proposed feature set is basically what's left over after =
we've trimmed off everything we can think to split off, but if any of t=
he proposed included features are also particularly important or don't =
matter, be sure to mention them (NFS export in particular =97 it works =
right now but isn't in great shape due to NFS filehandle caching).
>
> Thanks,
> -Greg
>
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
