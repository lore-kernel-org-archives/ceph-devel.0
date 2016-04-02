From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Fri, 1 Apr 2016 19:51:07 -0700
Message-ID: <CAJ4mKGaNPfpPbbNY+YVu1NDuVQ-gaS5fi2Pww7DSjsbGt-sbXg@mail.gmail.com>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
	<alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com>
	<CY1PR0201MB189760F1BB3EB67EF216B71DE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
	<20160401035610.GA5671@onthe.net.au>
	<alpine.DEB.2.11.1604010055050.22014@cpach.fuggernut.com>
	<20160401052838.GA8044@onthe.net.au>
	<alpine.DEB.2.11.1604011051480.22014@cpach.fuggernut.com>
	<20160401194912.GA18636@onthe.net.au>
	<CY1PR0201MB1897EE2E58FFF2FF3DFFFB55E89A0@CY1PR0201MB1897.namprd02.prod.outlook.com>
	<3E46E6C9-EFD2-49BD-9862-4C46D053A8D6@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34579 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbcDBCvJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Apr 2016 22:51:09 -0400
Received: by mail-vk0-f46.google.com with SMTP id e185so124580286vkb.1
        for <ceph-devel@vger.kernel.org>; Fri, 01 Apr 2016 19:51:08 -0700 (PDT)
In-Reply-To: <3E46E6C9-EFD2-49BD-9862-4C46D053A8D6@sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Chris Dunlop <chris@onthe.net.au>, Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Apr 1, 2016 at 7:23 PM, Allen Samuels <Allen.Samuels@sandisk.co=
m> wrote:
> Talk about mental failures. The first statement is correct. It's abou=
t the ratio of checksum to data bits. After that please ignore. If you =
double the data you need to double the checksum bit to maintain the ber=
=2E

=46orgive me if I'm wrong here =E2=80=94 I haven't done anything with
checksumming since I graduated college =E2=80=94 but good checksumming =
is
about probabilities and people suck at evaluating probability: I'm
really not sure any of the explanations given in this thread are
right. Bit errors aren't random and in general it requires a lot more
than one bit flip to collide a checksum, so I don't think it's a
linear relationship between block size and chance of error. Finding
collisions with cryptographic hashes is hard! Granted a CRC is a lot
simpler than SHA1 or whatever, but we also aren't facing adversaries
with it, just random corruption. So yes, as your data block increases
then naturally the number of possible bit patterns which match the
same CRC have to increase =E2=80=94 but that doesn't mean your odds of
actually *getting* that bit pattern by mistake increase linearly.

I spent a brief time trying to read up on Hamming distances and
"minimum distance separable" to try and remember/understand this and
it's just making my head hurt, so hopefully somebody with the right
math background can chime in.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
