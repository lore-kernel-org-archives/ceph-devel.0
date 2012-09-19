From: Gregory Farnum <greg@inktank.com>
Subject: Re: Memory usage of ceph-mds
Date: Wed, 19 Sep 2012 14:12:03 -0700
Message-ID: <CAPYLRziJNqjZnD4J8ufhMZ+GYs3Wn67Qk_=GJKsb45e_D8Qjgw@mail.gmail.com>
References: <CANLRBoyZ5JCTfdu_ntf+aOYBPa2C4w5TLM8-2Q4_=YWg8=VL1w@mail.gmail.com>
	<alpine.DEB.2.00.1209191347210.7537@cobra.newdream.net>
	<CAPYLRziPh0+7BGxMa7e9n6QQGruRX6-58x-fnAAwYaONkOVZ1g@mail.gmail.com>
	<CANLRBoyKVk68Kxd85++WjWFr4870ihrRqWarO69V+7Pza62mXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45063 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab2ISVME convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Sep 2012 17:12:04 -0400
Received: by ieak13 with SMTP id k13so2271893iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Sep 2012 14:12:03 -0700 (PDT)
In-Reply-To: <CANLRBoyKVk68Kxd85++WjWFr4870ihrRqWarO69V+7Pza62mXw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tren Blackburn <tren@eotnetworks.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Wed, Sep 19, 2012 at 2:05 PM, Tren Blackburn <tren@eotnetworks.com> =
wrote:

> Greg: It's difficult to tell you that. I'm rsyncing 2 volumes from ou=
r
> filers. Each base directory on each filer mount has approximate 213
> directories, and then each directory under that has approximately
> anywhere from 3000 - 5000 directories (very loose approximation here,
> 850,000 directories per filer mount), and then each of those
> directories contains files.

Ah, directories are larger =97 Sage, do you think they're enough bigger
to make up that much extra memory usage?


> We have many many files here. We're doing this to see how CephFS
> handles lots of files. We are coming from MooseFS which its master
> metalogger process eats lots of ram, so we're hoping that Ceph is a
> bit lighter on us.
>
> Sage: The memory the MDS is using is only a cache? There should be no
> problem restarting the MDS server while activity is going on? I shoul=
d
> probably change the limit for the non-active MDS servers first, and
> then the active one and hope it fails over cleanly?
Yep, that should work fine, with the obvious caveat that your
filesystem will become inaccessible if the MDS is down long enough for
clients to exceed their timeouts (no metadata loss though, if all
clients remain active until the MDS comes back up). The cache needs to
be large enough to hold any directory you happen to be working in (for
now; there is unstable code that fixes that issue), so it should be
pretty large, but all updates are on stable storage fairly quickly
(before anybody except the requesting client is allowed to see the
change =97 and the change is in-memory on both the requesting client an=
d
the MDS until that point).
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
