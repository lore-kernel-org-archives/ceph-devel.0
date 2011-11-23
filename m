From: Atish Kathpal <atish.kathpal@gmail.com>
Subject: Re: Metadata queries on Ceph/RADOS
Date: Wed, 23 Nov 2011 21:32:04 +0530
Message-ID: <CAMiHsJJ0ARRMf7KHQmAHR5iZoCnzEhb3E6xuUx_ADfsFiPFndA@mail.gmail.com>
References: <CAMiHsJJN1UB++ijcorzBBi=YD9eawur62WF9L1QxtwwiH78HXw@mail.gmail.com>
 <CAF3hT9Av361T-H-dejBHcipYu2otpUR9GpLgdhDvy6d-Z9qPpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39677 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab1KWQC2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2011 11:02:28 -0500
Received: by faas1 with SMTP id s1so504528faa.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Nov 2011 08:02:26 -0800 (PST)
In-Reply-To: <CAF3hT9Av361T-H-dejBHcipYu2otpUR9GpLgdhDvy6d-Z9qPpQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thank you for the insights.

Atish

On Tue, Nov 22, 2011 at 10:39 PM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
>
>
> On Tuesday, November 22, 2011, Atish Kathpal <atish.kathpal@gmail.com=
>
> wrote:
>> Hello
>>
>> Does RADOS support metadata queries?
> Nope. RADOS is not a database of any kind, sorry. The only metadata s=
ervice
> is that used by te Ceph filesystem, and it can't do what you're after=
=2E
> I have gone through librados and
>> the "rados" command line tool, and there doesn't seem to be a way fo=
r
>> me to say, query the object store saying: "Give me all objects with
>> Xattr Video =3D 1". The only way I can think of is to write some of =
my
>> own code using librados.
>>
>> Any pointers if the system has a metadata service or something that =
I
>> can query?
> You could see of the object classes and map objects let you do what y=
ou
> want. I think we'll need to make them a bit more powerful before they=
're
> helpful for you, though. :/
>
>>
>> (I have seen few diagrams=A0showing a metadata cluster as part of Ce=
ph
>> which supports metadata operations, how can I leverage that? referen=
ce
>> diagram:
>> http://www.usenix.org/event/osdi06/tech/full_papers/weil/weil_html/f=
ig/overview.png)
>>
>> =A0Regards
>> Atish
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
