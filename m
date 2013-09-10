From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: Feature request regarding size and min_size on pools
Date: Tue, 10 Sep 2013 15:51:00 +0200
Message-ID: <CAF6-1L6phgkEjUYgUZQ47SO5qM1VaZuw5JHMqiEApirubt=pMA@mail.gmail.com>
References: <1712504592.851.1378813557601.JavaMail.root@mail>
	<750758449.922.1378815687370.JavaMail.root@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:54621 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873Ab3IJNvA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Sep 2013 09:51:00 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so7720458pdj.12
        for <ceph-devel@vger.kernel.org>; Tue, 10 Sep 2013 06:51:00 -0700 (PDT)
In-Reply-To: <750758449.922.1378815687370.JavaMail.root@mail>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Svein-Erik Lund <sel@selund.se>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,


> Now to our problem. We want to be sure that a write is replicated before we get a ack.

That should be the case AFAIU.
There was however a bug that was recently fixed that make RBD ack too early.


>  one osd can lead to data loss with min_size set to 1.

It definitely shouldn't. Unless of course the only remaining OSD fails as well.


> The problem now is that if one osd goes down some pg's will end up incomplete, and no io operations will be allowed to the rbd.

Well yeah, that's exactly the semantic of the min_size option ...


Cheers,

    Sylvain
