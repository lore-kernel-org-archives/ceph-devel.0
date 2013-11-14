From: Gregory Farnum <greg@inktank.com>
Subject: Re: CDS blueprint: strong auth for cephfs
Date: Thu, 14 Nov 2013 08:37:35 -0800
Message-ID: <CAPYLRzh=DfpVx1Z04+XhbYY9yiyGD9HvG4rRp8=xi9B3SKb50A@mail.gmail.com>
References: <CABZ+qqkfhMFUskDheNrARKfyUPCRLref-O=kkw3ezqaZFnu6rw@mail.gmail.com>
	<CAPYLRzgrDPUg91em1uXkCtqFfbS-2GP92stjmGtPUOmS+tRcTw@mail.gmail.com>
	<CABZ+qq=SQman+HPvKany0HigYrtMn766itdU_7ZsYm6SOaQzcQ@mail.gmail.com>
	<CAPYLRzhKNT6Tx9LRV6bfHXpAsG1m3MhWriK-i-T+wSGfBVwh-A@mail.gmail.com>
	<CABZ+qqnfkEOVH2QRM8fu95eGEVBZ8JHX-KLGRAca76AymXothg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:37446 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481Ab3KNQhj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Nov 2013 11:37:39 -0500
Received: by mail-lb0-f176.google.com with SMTP id p9so1725631lbv.7
        for <ceph-devel@vger.kernel.org>; Thu, 14 Nov 2013 08:37:38 -0800 (PST)
In-Reply-To: <CABZ+qqnfkEOVH2QRM8fu95eGEVBZ8JHX-KLGRAca76AymXothg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Arne Wiebalck <Arne.Wiebalck@cern.ch>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, andrea.ieri@cern.ch

On Thu, Nov 14, 2013 at 8:21 AM, Dan van der Ster <dan@vanderster.com> =
wrote:
> On Thu, Nov 14, 2013 at 4:55 PM, Gregory Farnum <greg@inktank.com> wr=
ote:
>> Ah, I hadn't gotten that from skimming the blueprint. So this isn't
>> just about hooking into Kerberos when we do a mount, you want to
>> dynamically retrieve different caps from the monitors as users log o=
n,
>> and have that single client choose between them based on who's makin=
g
>> the request?
>
> In our proposal the "additional capabilities" (which allow IOs with a
> particular file/object) are encrypted and sent by the MDS to the
> client who passes it on to the OSD for object IOs.

I'm confused; if two different people are using the same client mount,
the MDS can't distinguish between them unless the client is
cooperating. Isn't that what you were saying it needs to do?

>>>> the MDS tickets in a lot more detail than you have there, though =97=
 for
>>>> instance, with your current description you'll need a shared secre=
t
>>>> between the OSD and MDS, and you'll need to expire the client extr=
a
>>>
>>> Right, the shared secret is the kerberos service key in our model.
>>
>> So the whole Ceph cluster has one shared service key, and they use
>> that for securing everything that anybody does? (Sorry, that's
>> probably an elementary question, but I haven't looked at Kerberos
>> since Yehuda implemented the initial CephX auth.)
>
> We've used the shared service key in the past with other distributed
> file systems. But perhaps the model can be changed to per-OSD/MDS
> keys.
>
>> By the time I arrived this was all history; you'll have to wait unti=
l
>> Sage gets back for that one. I suspect he didn't like the performanc=
e
>> enough and the trees had diverged non-trivially by the time Maat was
>> in a useful state. But if you are brave, you can go back in time
>> (couple years ago) and look for the "security" folder, which I think
>> contained the Maat changes, and see what would be involved in
>> extracting them. :)
>
> Is it this one?
>    https://github.com/ceph/ceph/tree/historic/aleung_mds_security/

Specifically the branches/aleung/security1/ folder in there. (This is
all svn branches converted to a git repository, etc, so the
organization is a bit weird.)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
