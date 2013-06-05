From: Dominik Mostowiec <dominikmostowiec@gmail.com>
Subject: Re: two osd stack on peereng after start osd to recovery
Date: Thu, 6 Jun 2013 01:20:31 +0200
Message-ID: <CAMNMNTxAT6esZ70OjeKTcW5rEL0Y5Tv8Xcs2x23Tj=Cx2Apudw@mail.gmail.com>
References: <CAMNMNTyzChZPCgf-aOWJCzg-0=J9qRj3YknuBrtzWHKWFT9P8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f41.google.com ([209.85.128.41]:54323 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757711Ab3FEXUd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Jun 2013 19:20:33 -0400
Received: by mail-qe0-f41.google.com with SMTP id b4so1501177qen.28
        for <ceph-devel@vger.kernel.org>; Wed, 05 Jun 2013 16:20:31 -0700 (PDT)
In-Reply-To: <CAMNMNTyzChZPCgf-aOWJCzg-0=J9qRj3YknuBrtzWHKWFT9P8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi,
I have again the same problem.
Have you got any idea?

--
Regards
Dominik

2013/5/23 Dominik Mostowiec <dominikmostowiec@gmail.com>:
> Hi,
> I changed disk after failure (osd.155).
> When osd.155 start on empty disk, and starts recovery, two osd stack
> on peering (108 and 71).
> Logs in attachment.
> Restart (osd 108,71) helps.
> ceph -v
> ceph version 0.56.6 (95a0bda7f007a33b0dc7adf4b330778fa1e5d70c)
>
> setup:
>
> 6 servers x 26 osd
> 6 x mons
> journal and data on the same disk
>
> Regards
>
> Dominik



-- 
Pozdrawiam
Dominik
