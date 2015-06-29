From: Gregory Farnum <greg@gregs42.com>
Subject: Re: CRC32 of messages
Date: Mon, 29 Jun 2015 12:37:13 +0100
Message-ID: <CAC6JEv8bpF4bmCnd5Z=Dv9MiUT4_rgStP49yOuEnULW8pGctRw@mail.gmail.com>
References: <a07cdfc20b95e8fd166d4d14adeb27a1.squirrel@www.erikburrows.com>
	<90559C83A9C7FA45B5846C975DFA612DDB4C4DC457@ABGEX73E.FSC.NET>
	<CABZ+qqkjYQBQJEjHGA8xs78d59khNLf9oDjA0ORTpFG0QiGtTQ@mail.gmail.com>
	<CAC6JEv938Os5jcNoV08vQJ6tLnR8y1kKLHR_z1iNRHXitQkMmw@mail.gmail.com>
	<mmra8n$ifi$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:33002 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbbF2LhR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jun 2015 07:37:17 -0400
Received: by laar3 with SMTP id r3so59798569laa.0
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 04:37:16 -0700 (PDT)
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com. [209.85.215.51])
        by mx.google.com with ESMTPSA id s8sm10719218las.29.2015.06.29.04.37.14
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2015 04:37:14 -0700 (PDT)
Received: by lagh6 with SMTP id h6so49939910lag.2
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 04:37:13 -0700 (PDT)
In-Reply-To: <mmra8n$ifi$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Swarbrick <daniel.swarbrick@profitbricks.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jun 29, 2015 at 12:30 PM, Daniel Swarbrick
<daniel.swarbrick@profitbricks.com> wrote:
> On 29/06/15 12:51, Gregory Farnum wrote:
>>
>> Yes, we have our own CRC32 checksum because loooong ago (before I
>> started!) Sage saw a lot of network corruption that wasn't being
>> caught by the TCP checksums so he added some to the Ceph message
>> stream. I can't tell you with any authority whatsoever how common that
>> problem is, but I don't think we're turning them off by default in
>> upstream. :)
>
> If the CRC32 implementation in Ceph is that dated (particularly the
> software implementations that will be used on AMD hardware), would it be
> worth checking out some of the updated implementations, such as the
> slice-by-16 or chunked methods?

Possibly? I really don't know anything about this. :) There have been
several changes to add new implementations (aarch64 and intel) since
then; pull requests welcome!
-Greg
