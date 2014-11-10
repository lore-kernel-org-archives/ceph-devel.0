From: Gregory Farnum <greg@gregs42.com>
Subject: Re: Ceph & Cinder & HA
Date: Mon, 10 Nov 2014 08:39:04 -0800
Message-ID: <CAC6JEv-ZS_heLJ1r6sw77asajfcm3-5+ypWE0z5=jrt0ffbGtQ@mail.gmail.com>
References: <545B9A53.4040502@dachary.org>
	<DAB091EE-E314-40D3-99F3-710E91ECC4D2@iweb.com>
	<545C927E.9010807@redhat.com>
	<CAOGLoJMMHZ3q9VxAG0B0ge6kaVdKZ1xVZLrjAFWZUGHf6kAeew@mail.gmail.com>
	<11F50ACF-55E9-4D2F-AD08-814FE5998089@enovance.com>
	<546098C5.4070709@dachary.org>
	<5460A683.9040509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:61790 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbaKJQjF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Nov 2014 11:39:05 -0500
Received: by mail-ig0-f171.google.com with SMTP id hl2so16739834igb.16
        for <ceph-devel@vger.kernel.org>; Mon, 10 Nov 2014 08:39:05 -0800 (PST)
Received: from mail-ie0-f176.google.com (mail-ie0-f176.google.com. [209.85.223.176])
        by mx.google.com with ESMTPSA id dy3sm4971020igb.1.2014.11.10.08.39.04
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 10 Nov 2014 08:39:04 -0800 (PST)
Received: by mail-ie0-f176.google.com with SMTP id rd18so9671968iec.35
        for <ceph-devel@vger.kernel.org>; Mon, 10 Nov 2014 08:39:04 -0800 (PST)
In-Reply-To: <5460A683.9040509@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Giulio Fidente <gfidente@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Sebastien Han <sebastien.han@enovance.com>, justin@erenkrantz.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Nov 10, 2014 at 3:50 AM, Giulio Fidente <gfidente@redhat.com> w=
rote:
> On 11/10/2014 11:51 AM, Loic Dachary wrote:
>>
>>
>>
>> On 10/11/2014 11:34, Sebastien Han wrote:
>>>
>>> Indeed, that=E2=80=99s what we discussed with Giulio, using HAProxy=
 for the
>>> Monitors is a bit overkill since the client is natively able to swi=
tch
>>> between different monitor source.
>>>
>>> Loic, maybe you can elaborate a bit more on the usage of HAProxy fo=
r the
>>> monitors?
>>
>>
>> Hi Sebastien,
>>
>> I can't elaborate because I know nothing about HAProxy (well, close =
to
>> nothing ;-). I'd like to learn more about how HA (via HAProxy or som=
ething
>> else) can leverage Ceph in a meaningfull way thouhg, hence my intere=
st for
>> the topic.
>
>
> Thanks all for helping.
>
> Loic explained requests for the non-leader monitors go to the monitor=
 anyway
> in which case I understand it makes more sense to avoid the complicat=
ion of
> balancing the monitors.

Well, that's not quite right =E2=80=94 *modification* requests get rout=
ed
through the leader; read-only operations are handled by the non-leader
monitors.
But I can't imagine how HAProxy would or could fit into that
communications path, and the clients do switch independently between
monitors as required (and there are a few different methods to
approximate load-balancing in the system, although nothing too
serious).
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
