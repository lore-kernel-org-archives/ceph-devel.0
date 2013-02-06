From: Mandell Degerness <mandell@pistoncloud.com>
Subject: Re: Increase number of pg in running system
Date: Tue, 5 Feb 2013 17:35:17 -0800
Message-ID: <CA+jddaN5zjDEhknDq2RCsTmXQUDbJB-VKV0K3JcT09Ai0Pdz=Q@mail.gmail.com>
References: <CAD3n6hFb=m_PL27sWZ5BSBAYP3xmTGZS_DrL-4ozF2+JbndMCA@mail.gmail.com>
	<loom.20130205T153942-509@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:54786 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070Ab3BFBfT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Feb 2013 20:35:19 -0500
Received: by mail-wi0-f169.google.com with SMTP id l13so4703330wie.0
        for <ceph-devel@vger.kernel.org>; Tue, 05 Feb 2013 17:35:17 -0800 (PST)
In-Reply-To: <loom.20130205T153942-509@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I would like very much to specify pg_num and pgp_num for the default
pools, but they are defaulting to 64 (no OSDs are defined in the
config file).  I have tried using the options indicated by Artem, but
they didn't seem to have any effect on the data and rbd pools which
are created by default.  Is there something I am missing?

On Tue, Feb 5, 2013 at 6:40 AM, ArtemGr <artemciy@gmail.com> wrote:
> Martin B Nielsen <martin <at> unity3d.com> writes:
>> Hi,
>>
>> Looking at:
>> http://ceph.com/docs/master/rados/operations/pools/
>>
>> It has this description roughly in the middle:
>>
>> ---------------
>> Important
>> Increasing the number of placement groups in a pool after you create
>> the pool is still an experimental feature in Bobtail (v 0.56). We
>> recommend defining a reasonable number of placement groups and
>> maintaining that number until Ceph=92s placement group splitting and
>> merging functionality matures.
>> ---------------
>>
>> However, I cannot find any references how to do this?
>>
>> I'm asking since we have a test system with 10TB data with only the
>> default 8 PG's created.
>
> Here's how I do it in ceph.conf:
>
> [osd]
>   ; Increase groups number in order to decrease scrub size
>   osd pool default pg num =3D 64
>   osd pool default pgp num =3D 64
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
