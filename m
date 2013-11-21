From: Gregory Farnum <greg@inktank.com>
Subject: Re: possible bug in init-ceph.in
Date: Thu, 21 Nov 2013 09:59:59 -0800
Message-ID: <CAPYLRzjN4kS=6Rto02RvYvhS-iwQjT4ttM+Wb6YanDLRzCOiCQ@mail.gmail.com>
References: <24E144B8C0207547AD09C467A8259F7559232FA2@lisa.maurer-it.com>
	<528E4071.3070603@dachary.org>
	<528E498A.8020102@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34914 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab3KUSAB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Nov 2013 13:00:01 -0500
Received: by mail-wg0-f44.google.com with SMTP id k14so92411wgh.23
        for <ceph-devel@vger.kernel.org>; Thu, 21 Nov 2013 10:00:00 -0800 (PST)
In-Reply-To: <528E498A.8020102@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

Can we take that diff you provided as coming with a signed-off-by, as
in the pull request Loic generated? :)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Thu, Nov 21, 2013 at 9:57 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> It turns out there was no pull request or bug report, sorry about tha=
t. Here is the pull request with your patch included:
>
> https://github.com/ceph/ceph/pull/861
>
> Cheers
>
> On 21/11/2013 18:18, Loic Dachary wrote:
>> Hi,
>>
>> I believe there is either a pull request or a ticket with this fix. =
Definitely a typo ;-)
>>
>> Cheers
>>
>> On 21/11/2013 08:23, Dietmar Maurer wrote:
>>> http://ceph.com/git/?p=3Dceph.git;a=3Dblob;f=3Dsrc/init-ceph.in;h=3D=
7399abb8f85855f2248c4afb22bf94f2e2f080a2;hb=3DHEAD
>>>
>>> line 320:
>>>
>>>       if [ "${update_crush:-1}" =3D "1" -o "{$update_crush:-1}" =3D=
 "true" ]; then
>>>
>>> looks strange to me. Maybe that should be:
>>>
>>> -            if [ "${update_crush:-1}" =3D "1" -o "{$update_crush:-=
1}" =3D "true" ]; then
>>> +            if [ "${update_crush:-1}" =3D "1" -o "${update_crush:-=
1}" =3D "true" ]; then
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
