From: Wido den Hollander <wido@42on.com>
Subject: Re: switch "ms bind ipv6" default to "true"?
Date: Wed, 8 Feb 2017 17:24:10 +0100 (CET)
Message-ID: <1330200336.9468.1486571050945@ox.pcextreme.nl>
References: <CALqRxCxqUP6V0enicL4EM=aeH1Qt5G0vvmcrqQrmAa9TirpLoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:37176 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbdBHQY1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Feb 2017 11:24:27 -0500
In-Reply-To: <CALqRxCxqUP6V0enicL4EM=aeH1Qt5G0vvmcrqQrmAa9TirpLoQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>


> Op 7 februari 2017 om 20:33 schreef Ken Dreyer <kdreyer@redhat.com>:
> 
> 
> In ceph-ansible we have to determine whether the user wants to bind to
> IPv6 or not, and set "ms bind ipv6 = true".
> 

Isn't it possible that this causes troubles when explicitly setting public and/or cluster network?

Wido

> Could we make this easier for users and simply have this as the
> default option in Ceph? What is the downside to defaulting ms bind
> ipv6 to true?
> 
> - Ken
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
