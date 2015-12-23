From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Time to move the make check bot to jenkins.ceph.com
Date: Wed, 23 Dec 2015 07:27:15 -0700
Message-ID: <CALqRxCwk38hjmGUvuV4=d3FqsJ9OniO4zD3x4hkRfg9X5zQGcw@mail.gmail.com>
References: <5677D0D2.5090801@dachary.org>
	<56799526.1000404@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37859 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226AbbLWO1Q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Dec 2015 09:27:16 -0500
Received: by mail-wm0-f49.google.com with SMTP id p187so150711958wmp.0
        for <ceph-devel@vger.kernel.org>; Wed, 23 Dec 2015 06:27:16 -0800 (PST)
In-Reply-To: <56799526.1000404@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is really great. Thanks Loic and Alfredo!

- Ken

On Tue, Dec 22, 2015 at 11:23 AM, Loic Dachary <loic@dachary.org> wrote=
:
> Hi,
>
> The make check bot moved to jenkins.ceph.com today and ran it's first=
 successfull job. You will no longer see comments from the bot: it will=
 update the github status instead, which is less intrusive.
>
> Cheers
>
> On 21/12/2015 11:13, Loic Dachary wrote:
>> Hi,
>>
>> The make check bot is broken in a way that I can't figure out right =
now. Maybe now is the time to move it to jenkins.ceph.com ? It should n=
ot be more difficult than launching the run-make-check.sh script. It do=
es not need network or root access.
>>
>> Cheers
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
