From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: REMINDER: all argonaut users should upgrade to v0.48.3argonaut
Date: Wed, 16 Jan 2013 18:05:07 +0100
Message-ID: <CAOLwVUn0PGeDEjKi-iWVu-jf8hXTqGtvMeB-RQ3+VHCBThzQCg@mail.gmail.com>
References: <alpine.DEB.2.00.1301151348330.24455@cobra.newdream.net>
 <CAOLwVU=0N2rrKFWoXoLm9ZmjgchVDcTCx7LHXTctvp9WVORRJw@mail.gmail.com> <alpine.DEB.2.00.1301160838470.14733@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:44449 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757208Ab3APRF3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 12:05:29 -0500
Received: by mail-la0-f52.google.com with SMTP id fq12so1683982lab.11
        for <ceph-devel@vger.kernel.org>; Wed, 16 Jan 2013 09:05:28 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301160838470.14733@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks Sage!

--
Regards,
S=E9bastien Han.


On Wed, Jan 16, 2013 at 5:39 PM, Sage Weil <sage@inktank.com> wrote:
> On Wed, 16 Jan 2013, S?bastien Han wrote:
>> Can we use this doc as a reference for the upgrade?
>>
>> https://github.com/ceph/ceph/blob/eb02eaede53c03579d015ca00a888a48db=
ab739a/doc/install/upgrading-ceph.rst
>
> Yeah.  It's pretty simple in this case (since it's a point release
> upgrade):
>
>  - install new package everywhere
>  - restart daemons
>
> (at any rate, in any order)
>
> The most important ones to upgrade in this case are the ceph-osd's.
>
> sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
