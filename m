From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: on-the-wire encryption, addrs, and cephx
Date: Thu, 5 May 2016 20:34:54 -0600
Message-ID: <CALqRxCyDdUaL0RNWNS7r-ZtNYEbbvzaeGapkjXYit8kXb-q4zg@mail.gmail.com>
References: <alpine.DEB.2.11.1605050822230.15413@cpach.fuggernut.com>
	<CAGbvivJtadH75PN-hbd6DNrYsTvHtp9SY=pEvoHH7XRTqTwoFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:33116 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbcEFCez (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 May 2016 22:34:55 -0400
Received: by mail-yw0-f171.google.com with SMTP id t10so178456057ywa.0
        for <ceph-devel@vger.kernel.org>; Thu, 05 May 2016 19:34:55 -0700 (PDT)
In-Reply-To: <CAGbvivJtadH75PN-hbd6DNrYsTvHtp9SY=pEvoHH7XRTqTwoFw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, May 5, 2016 at 12:26 PM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
> Though I would caution
> against writing to a particular KRB5 API (MIT vs Heimdal, etc).

This is off-topic, but I've worked on the Heimdal project a bit and I
maintain the Heimdal packages in Fedora and EPEL, and I wouldn't
recommend it for Ceph. Heimdal is nowhere near as actively developed
as MIT. Debian is considering dropping it entirely because it has not
seen a release in four years (https://bugs.debian.org/806274).

- Ken
