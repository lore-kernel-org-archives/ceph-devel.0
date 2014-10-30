From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: krbd blk-mq support ?
Date: Fri, 31 Oct 2014 01:05:26 +0800
Message-ID: <CACJqLyb4WK-Pb3LHmY4V7-UCFZ3Y5W1OEcm-y6zCyJug0p3fHg@mail.gmail.com>
References: <4c95e688-d8cd-42b4-b414-535764fb80fc@mailpro>
	<d2a43b95-aad1-45de-932f-c78d9eb61790@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:53987 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757327AbaJ3RF2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Oct 2014 13:05:28 -0400
Received: by mail-wi0-f178.google.com with SMTP id q5so8022489wiv.5
        for <ceph-devel@vger.kernel.org>; Thu, 30 Oct 2014 10:05:26 -0700 (PDT)
In-Reply-To: <d2a43b95-aad1-45de-932f-c78d9eb61790@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Sage Weil <sage@newdream.net>, Christoph Hellwig <hch@infradead.org>, Ceph Devel <ceph-devel@vger.kernel.org>

Could you describe more about 2x70000 iops?
So you mean 8 OSD each backend with SSD can achieve with 14w iops?
is it read or write? could you give fio options?

On Fri, Oct 31, 2014 at 12:01 AM, Alexandre DERUMIER
<aderumier@odiso.com> wrote:
>>>I'll try to add more OSD next week, if it's scale it's a very good n=
ews !
>
> I just tried to add 2 more osds,
>
> I can now reach 2x 70000 iops on 2 client nodes (vs 2 x 50000 previou=
sly).
>
> and kworker cpu usage is also lower (84% vs 97%).
> (don't understand why exactly)
>
> So, Thanks for help everybody !
>
>
>
>
>
> ----- Mail original -----
>
> De: "Alexandre DERUMIER" <aderumier@odiso.com>
> =C3=80: "Sage Weil" <sage@newdream.net>
> Cc: "Christoph Hellwig" <hch@infradead.org>, "Ceph Devel" <ceph-devel=
@vger.kernel.org>
> Envoy=C3=A9: Jeudi 30 Octobre 2014 09:11:11
> Objet: Re: krbd blk-mq support ?
>
>>>Hmm, this is probably the messenger.c worker then that is feeding me=
ssages
>>>to the network. How many OSDs do you have? It should be able to scal=
e
>>>with the number of OSDs.
>
> Thanks Sage for your reply.
>
> Currently 6 OSD (ssd) on the test platform.
>
> But I can reach 2x 50000iops on same rbd volume with 2 clients on 2 d=
ifferents host.
> Do you think messenger.c worker can be the bottleneck in this case ?
>
>
> I'll try to add more OSD next week, if it's scale it's a very good ne=
ws !
>
>
>
>
>
>
>
> ----- Mail original -----
>
> De: "Sage Weil" <sage@newdream.net>
> =C3=80: "Alexandre DERUMIER" <aderumier@odiso.com>
> Cc: "Christoph Hellwig" <hch@infradead.org>, "Ceph Devel" <ceph-devel=
@vger.kernel.org>
> Envoy=C3=A9: Mercredi 29 Octobre 2014 16:00:56
> Objet: Re: krbd blk-mq support ?
>
> On Wed, 29 Oct 2014, Alexandre DERUMIER wrote:
>> >>Oh, that's without the blk-mq patch?
>>
>> Yes, sorry, I don't how to use perf with a custom compiled kernel.
>> (Usualy I'm using perf from debian, with linux-tools package provide=
d with the debian kernel package)
>>
>> >>Either way the profile doesn't really sum up to a fully used up cp=
u.
>>
>> But I see mostly same behaviour with or without blk-mq patch, I have=
 always 1 kworker at around 97-100%cpu (1core) for 50000iops.
>>
>> I had also tried to map the rbd volume with nocrc, it's going to 600=
00iops with same kworker at around 97-100%cpu
>
> Hmm, this is probably the messenger.c worker then that is feeding mes=
sages
> to the network. How many OSDs do you have? It should be able to scale
> with the number of OSDs.
>
> sage
>
>
>>
>>
>>
>> ----- Mail original -----
>>
>> De: "Christoph Hellwig" <hch@infradead.org>
>> ?: "Alexandre DERUMIER" <aderumier@odiso.com>
>> Cc: "Ceph Devel" <ceph-devel@vger.kernel.org>
>> Envoy?: Mardi 28 Octobre 2014 19:07:25
>> Objet: Re: krbd blk-mq support ?
>>
>> On Mon, Oct 27, 2014 at 11:00:46AM +0100, Alexandre DERUMIER wrote:
>> > >>Can you do a perf report -ag and then a perf report to see where=
 these
>> > >>cycles are spent?
>> >
>> > Yes, sure.
>> >
>> > I have attached the perf report to this mail.
>> > (This is with kernel 3.14, don't have access to my 3.18 host for n=
ow)
>>
>> Oh, that's without the blk-mq patch?
>>
>> Either way the profile doesn't really sum up to a fully used up
>> cpu. Sage, Alex - are there any ordring constraints in the rbd clien=
t?
>> If not we could probably aim for per-cpu queues using blk-mq and a
>> socket per cpu or similar.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
