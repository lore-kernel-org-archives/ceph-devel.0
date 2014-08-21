From: Gregory Farnum <greg@inktank.com>
Subject: Re: mon dependency on OSD MonClient using OSD's client_messenger
Date: Thu, 21 Aug 2014 09:13:26 -0700
Message-ID: <CAPYLRzgJ7rHAy1eEvyjt0Y8o_nNSYDdO8-xh17zOsCD7aViZow@mail.gmail.com>
References: <1875667091.100.1407341902410.JavaMail.root@thunderbeast.private.linuxbox.com>
	<1261081511.125.1407343224581.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:47153 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbaHUQN1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Aug 2014 12:13:27 -0400
Received: by mail-qc0-f175.google.com with SMTP id w7so9418162qcr.6
        for <ceph-devel@vger.kernel.org>; Thu, 21 Aug 2014 09:13:27 -0700 (PDT)
In-Reply-To: <1261081511.125.1407343224581.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@cohortfs.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Aug 6, 2014 at 9:40 AM, Matt W. Benjamin <matt@cohortfs.com> wrote:
> Hi,
>
> We noticed that OSDs use their client_messenger, rather than their potentially
> dedicated cluster_messenger, to drive MonClient.  Then we found that the Mon's setup
> of the OSDMap depends on this.
>
> Can someone comment?  We assume this is well known, but what is the background?

Right. The monitors are *strongly* identified with their single IP
address, which needs to be client-accessible, so it belongs on the
client network. Since every other daemon type is a client to the
monitors, adding a special cluster network for the monitors doesn't
really make sense and would be a fair bit of work.

At least, those are the good reasons for it being this way. I haven't
thought about it much previously because the OSD "cluster network" (or
any support for different networks/IPs at all) is a relatively new
thing in Ceph's life, and the monitors never got that treatment. ;) (I
am pretty sure the good reasons for it being that way actually do hold
even if we did have the patches, but maybe I'm missing something.)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
