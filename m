From: Dan Mick <dan.mick@inktank.com>
Subject: Re: recoverying from 95% full osd
Date: Thu, 24 Jan 2013 20:11:58 -0800
Message-ID: <5102060E.6030009@inktank.com>
References: <CAD5ewroRv5-F0ZxBUmXqjz77zNenHQsrBacJ7LgXCqyduoxHsQ@mail.gmail.com> <CAPYLRzjv2tjndJCAgCqj8uBcGdC4vCiU1hd3oG2MdqLA7fW3Yg@mail.gmail.com> <CAD5ewrrKB0kxMDq2Hg-XStQUdVhjtgTWvmb3OoZTzHcZ3wpUrQ@mail.gmail.com> <alpine.DEB.2.00.1301082251590.2227@cobra.newdream.net> <778D42BCC03C4BB589117CE6FB62B5D6@inktank.com> <CAD5ewrr7tiVTR3zna_iKqzg-GfwmERey1g4dn92yMA6fQNaaYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39555 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732Ab3AYEMC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 23:12:02 -0500
Received: by mail-pb0-f46.google.com with SMTP id uo15so138415pbc.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 20:12:01 -0800 (PST)
In-Reply-To: <CAD5ewrr7tiVTR3zna_iKqzg-GfwmERey1g4dn92yMA6fQNaaYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roman Hlynovskiy <roman.hlynovskiy@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


> what is pool 2 (rbd) for? looks like it's absolutely empty.

by default it's for rbd images (see the rbd command etc.).  It being 
empty or not has no effect on the other pools.
