From: "J. Eric Ivancich" <ivancich@redhat.com>
Subject: Re: About dmClock tests confusion after integrating dmClock QoS library into ceph codebase
Date: Thu, 27 Jul 2017 13:29:11 -0400
Message-ID: <9E9D3C7D-1AF0-4DA8-B432-3D27EE72A582@redhat.com>
References: <509B214C5E2CEA4D9C41C1AB2A76BDD1A36B38B0@H3CMLB12-EX.srv.huawei-3com.com> <5a40a1e8-c1c5-1bc1-86ce-4f5d2593d2d4@redhat.com> <CAB7xdinyGMQMnORDfNknEg4a_y5EpW_ibndNZUyWtRhS9TNgFg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:37826 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdG0R3N (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Jul 2017 13:29:13 -0400
Received: by mail-qt0-f178.google.com with SMTP id 16so27018198qtz.4
        for <ceph-devel@vger.kernel.org>; Thu, 27 Jul 2017 10:29:13 -0700 (PDT)
In-Reply-To: <CAB7xdinyGMQMnORDfNknEg4a_y5EpW_ibndNZUyWtRhS9TNgFg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: Lijie <li.jieA@h3c.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Sheng,

The code you see in wip_dmclock_clients was essentially (there may have been some modifications) merged into master on June 26th.

Eric

> On Jun 13, 2017, at 12:06 PM, sheng qiu <herbert1984106@gmail.com> wrote:
> 
> Hi Eric,
> 
> we are also very interested in your dmclock work in ceph. May I ask if this branch wip_dmclock_clients has both clients and OSD support for dmclock?
> we want to fully test this implementations.
> 
> thanks for your help.
> 
> Sheng
