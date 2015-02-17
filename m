From: Stephen Hindle <shindle@llnw.com>
Subject: Re: [ceph-users] Ceph Dumpling/Firefly/Hammer SSD/Memstore
 performance comparison
Date: Tue, 17 Feb 2015 13:16:04 -0700
Message-ID: <CANPbtN830yy7AJ6ziWr7V7sN80vHobpy7j8XwGpFizhd7fJynQ@mail.gmail.com>
References: <54E37C3D.5030702@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from exprod5og115.obsmtp.com ([64.18.0.246]:38420 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753102AbbBQUQH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 17 Feb 2015 15:16:07 -0500
Received: by mail-yk0-f181.google.com with SMTP id 200so17789249ykr.12
        for <ceph-devel@vger.kernel.org>; Tue, 17 Feb 2015 12:16:05 -0800 (PST)
In-Reply-To: <54E37C3D.5030702@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

I was wondering what the 'CBT' tool is ?  Google is useless for that acronym...

Thanks!
Steve

On Tue, Feb 17, 2015 at 10:37 AM, Mark Nelson <mnelson@redhat.com> wrote:
> Hi All,
>
> I wrote up a short document describing some tests I ran recently to look at
> how SSD backed OSD performance has changed across our LTS releases. This is
> just looking at RADOS performance and not RBD or RGW.  It also doesn't offer
> any real explanations regarding the results.  It's just a first high level
> step toward understanding some of the behaviors folks on the mailing list
> have reported over the last couple of releases.  I hope you find it useful.
>
> Mark
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

-- 
The information in this message may be confidential.  It is intended solely 
for
the addressee(s).  If you are not the intended recipient, any disclosure,
copying or distribution of the message, or any action or omission taken by 
you
in reliance on it, is prohibited and may be unlawful.  Please immediately
contact the sender if you have received this message in error.

