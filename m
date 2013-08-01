From: Chmouel Boudjnah <chmouel@chmouel.com>
Subject: Re: LFS & Ceph
Date: Thu, 1 Aug 2013 10:34:29 +0200
Message-ID: <CAKSXASSpTK5itZbTo=jDw30WiRrDLgiiy=b+X2Ma+7NSrYAz2g@mail.gmail.com>
References: <51F06A8A.3050401@dachary.org> <51F12CBC.4080308@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:63081 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab3HAIfD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Aug 2013 04:35:03 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so3197298oah.20
        for <ceph-devel@vger.kernel.org>; Thu, 01 Aug 2013 01:35:02 -0700 (PDT)
Received: from mail-oa0-x233.google.com (mail-oa0-x233.google.com [2607:f8b0:4003:c02::233])
        by mx.google.com with ESMTPSA id jz7sm2001090obb.4.2013.08.01.01.35.00
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 01 Aug 2013 01:35:01 -0700 (PDT)
Received: by mail-oa0-f51.google.com with SMTP id h1so792790oag.10
        for <ceph-devel@vger.kernel.org>; Thu, 01 Aug 2013 01:35:00 -0700 (PDT)
In-Reply-To: <51F12CBC.4080308@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hello,

Sorry for the late answer as I was travelling lately.

The LFS works has been in a heavy state of work in progress by Peter
(in CC) and others there is some documentation in this review :

https://review.openstack.org/#/c/30051/

(summarized in Pete's gist here
https://gist.github.com/portante/5488238/raw/66b0bf2a91a8ca75301fa68dc0=
fef2d3dc76e5a2/gistfile1.txt)

some preliminary work here :

https://review.openstack.org/#/c/35381/

and some old documentation here :

https://raw.github.com/zaitcev/swift-lfs/master/doc/source/lfs_plugin.r=
st

I am sure Pete would appreciate the feedback.

Cheers,
Chmouel.

On 24/07/2013 17:00, Loic Dachary wrote:
> Hi,
>
> Thanks for take the time to discuss LFS today @ OSCON :-) Would you b=
e so kind as to send links to the current discussion about the LFS driv=
er API ?
>
> Cheers
>

--
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do no=
thing.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
