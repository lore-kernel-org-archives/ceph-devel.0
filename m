From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [ceph-users] About the NFS on RGW
Date: Tue, 22 Mar 2016 18:03:54 +0100
Message-ID: <CAOi1vP-ixe9BQoXjdGdeLQtooPjs2O23paQTeiSXWUTmMBpoMA@mail.gmail.com>
References: <FF8D83DAE5DF57468726B79904321E0603CC8967@H3CMLB14-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33662 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbcCVRD4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Mar 2016 13:03:56 -0400
Received: by mail-lb0-f182.google.com with SMTP id oe12so170028099lbc.0
        for <ceph-devel@vger.kernel.org>; Tue, 22 Mar 2016 10:03:55 -0700 (PDT)
In-Reply-To: <FF8D83DAE5DF57468726B79904321E0603CC8967@H3CMLB14-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xusangdi <xu.sangdi@h3c.com>
Cc: "mbenjamin@redhat.com" <mbenjamin@redhat.com>, "ceph-users@ceph.com" <ceph-users@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Mar 22, 2016 at 1:12 PM, Xusangdi <xu.sangdi@h3c.com> wrote:
> Hi Matt & Cephers,
>
> I am looking for advise on setting up a file system based on Ceph. As CephFS is not yet productive ready(or I missed some breakthroughs?), the new NFS on RadosGW should be a promising alternative, especially for large files, which is what we are most interested in. However, after searching around the Ceph documentation (http://docs.ceph.com/docs/master/) and recent community mails, I cannot find much information about it. Could you please provide some introduction about the new NFS, and (if possible) a raw way to try it? Thank you!

Note that CephFS is declared "stable, at last" in Jewel.  Not all
functionality falls under that heading (e.g. no snapshots, for now),
but if you want a file system based on Ceph, you really shouldn't be
looking at NFS-on-RGW.

Thanks,

                Ilya
