From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: RBD fio Performance concerns
Date: Thu, 22 Nov 2012 13:50:37 +0100
Message-ID: <CAOLwVU=VpDPg6iuZM=UFy5bcDm-Rm_dVRkeZrAu-DoFXp9cDKw@mail.gmail.com>
References: <CAOLwVUmJGZNaZsySsw8eQmLy1ZCha+AAGCp-5i42=mr0aKHMyA@mail.gmail.com>
 <3210b770-431e-44ed-8d86-4610de89dd92@mailpro> <CAOLwVUn5EAC4QaWgU+TkodcJea7ayKUANUpfzWUG+cTBunao5g@mail.gmail.com>
 <50ACF8C8.7020908@inktank.com> <50AD02AC.60802@inktank.com>
 <50ADFC23.2030208@profihost.ag> <CAOLwVUmp7wrfead8qX2BZPbyeN_JY_XBN+wkEWmbY6q1-5u0fw@mail.gmail.com>
 <50AE1107.5060606@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:41688 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab2KVS3V convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Nov 2012 13:29:21 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so3838635lag.19
        for <ceph-devel@vger.kernel.org>; Thu, 22 Nov 2012 10:29:20 -0800 (PST)
In-Reply-To: <50AE1107.5060606@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: Mark Nelson <mark.nelson@inktank.com>, Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>, Mark Kampe <mark.kampe@inktank.com>

> journal is running on tmpfs to me but that changes nothing.

I don't think it works then. According to the doc: Enables using
libaio for asynchronous writes to the journal. Requires journal dio
set to true.


On Thu, Nov 22, 2012 at 12:48 PM, Stefan Priebe - Profihost AG
<s.priebe@profihost.ag> wrote:
> Am 22.11.2012 11:49, schrieb S=E9bastien Han:
>
>> @Alexandre: cool!
>>
>> @ Stefan: Full SSD cluster and 10G switches?
>
> Yes
>
>
>> Couple of weeks ago I saw
>> that you use journal aio, did you notice performance improvement wit=
h it?
>
> journal is running on tmpfs to me but that changes nothing.
>
> Stefan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
