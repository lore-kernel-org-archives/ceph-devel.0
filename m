From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: radosgw: shadow objects
Date: Thu, 29 Sep 2011 10:05:56 -0700
Message-ID: <CAC-hyiHzFympqYkYgNvs+1UJ78588QCgMZje7P-340hirNEteA@mail.gmail.com>
References: <CANExM-MPCAj9pzZUSciMrSxg+r=VJ9J9GUH88U-MvzDsyZJp7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48390 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab1I2RF6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Sep 2011 13:05:58 -0400
Received: by bkbzt4 with SMTP id zt4so883876bkb.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Sep 2011 10:05:56 -0700 (PDT)
In-Reply-To: <CANExM-MPCAj9pzZUSciMrSxg+r=VJ9J9GUH88U-MvzDsyZJp7A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Instead of removing the shadow objects, we add an intent entry to the
intent log. This is done, so that an object read that happens while
doing a write to the object can complete successfully, while returning
the original object. A separate process then have to remove those
entries, but only after a long period (e.g., a couple of days). The
radosgw-admin utility can handle that.

On Thu, Sep 29, 2011 at 9:14 AM, Henry C Chang <henry.cy.chang@gmail.co=
m> wrote:
> Hi,
>
> With radosgw, I noticed that after the actual objects are deleted, th=
e
> shadow objects still remains. I am wondering when the shadow object
> will be deleted. Is it a bug or on purpose?
> My used data size keeps growing...
>
> Henry
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
