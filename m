From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: on-the-wire encryption, addrs, and cephx
Date: Thu, 5 May 2016 12:16:34 -0600
Message-ID: <CALqRxCzqVyAY8=CuaJ0nLUgeLc9d32AWk3dP_j9yQ_raTmB8zw@mail.gmail.com>
References: <alpine.DEB.2.11.1605050822230.15413@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:33327 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbcEESQf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 May 2016 14:16:35 -0400
Received: by mail-yw0-f180.google.com with SMTP id t10so153352146ywa.0
        for <ceph-devel@vger.kernel.org>; Thu, 05 May 2016 11:16:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1605050822230.15413@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, May 5, 2016 at 6:57 AM, Sage Weil <sweil@redhat.com> wrote:
> 3) The above works great for most daemons, but the monitors themselves
> also have to support both legacy and v2 connections.  Conveniently, we
> also just got an IANA port assignment and need to transition to using that
> anyway.  We can make monitors listen to legacy connections on 6789 and v2
> connections on the new port 3300.

Ha, this is a great use of that new port :)
