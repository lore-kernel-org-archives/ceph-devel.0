From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: msgr2 schedule
Date: Tue, 28 Jun 2016 13:48:24 -0700
Message-ID: <CAJ4mKGZTrB9WCf1s6jrCkF5gNNbgJerDuHNwm-zFgHgfrFLxKQ@mail.gmail.com>
References: <VI1PR05MB16145CDE50827BEC6E7F39DBA9220@VI1PR05MB1614.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35493 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbcF1Usi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 16:48:38 -0400
Received: by mail-vk0-f53.google.com with SMTP id j2so39073470vkg.2
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jun 2016 13:48:25 -0700 (PDT)
In-Reply-To: <VI1PR05MB16145CDE50827BEC6E7F39DBA9220@VI1PR05MB1614.eurprd05.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avner Ben Hanoch <avnerb@mellanox.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jun 28, 2016 at 12:46 PM, Avner Ben Hanoch <avnerb@mellanox.com> wrote:
> Hi,
>
> I read about msgr2 and it sound very exciting
>
> Is there a time estimation when it will be available/started?
> Is there a development branch for its coding?

I don't think there's any firm timeline yet. Certainly we'd *like* to
see it in various named releases, but there isn't any development time
which has been publicly committed to it yet. So far it's mostly just
being defined so that the prior work (with addresses and things) that
is going on for other purposes and make sure to include all we need,
and to lay down a roadmap for future endeavors.
-Greg
