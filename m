From: Ketor D <d.ketor@gmail.com>
Subject: Re: rados_dll: A Windows port of librados
Date: Fri, 20 Mar 2015 10:45:16 +0800
Message-ID: <CAM9_UU_O=ntf+pZodFwMo1qS7R7Y4S1eNFiXx-x5G2TpOEGf2g@mail.gmail.com>
References: <CAHJ4zomaFxzJMBo+v50DUX=bycyagzWOfckoXPFcm1THFK8DQg@mail.gmail.com>
 <alpine.DEB.2.00.1503190822150.9418@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:32782 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbCTCpq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Mar 2015 22:45:46 -0400
Received: by obcxo2 with SMTP id xo2so69082864obc.0
        for <ceph-devel@vger.kernel.org>; Thu, 19 Mar 2015 19:45:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1503190822150.9418@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Alistair Israel <aisrael@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,
     I read the the rados_dll code and in my option it is very similar
to ceph-dokan,  like just add librados code to ceph-dokan.
     It's very easy to implement librados, librbd in ceph-dokan,
because all base code is ported to MinGW.

     I update the ceph-dokan from 0.67 to 0.92 for a long time, and
push it to all cephers in 0.88.
     With my experience I think if we need to split the client-side
code from all Ceph code.After split, all port work will be much more
easier to merge to upstream.
     Recently I am trying to port the cephx auth to MinGW, after this
ceph-dokan and libraodos can use cephx for mount.

     And also Alistair, would you like to help port your librados code
to ceph-dokan project with a clean pull request?

Ketor
