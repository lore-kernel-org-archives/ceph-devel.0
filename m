From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Radosgw cannot output Chinese file names
Date: Wed, 13 Jul 2011 10:45:05 -0700
Message-ID: <CA+qbEUPYHsJRPY-_ouCDCGLBxCcsy9cvDtwQ3hwuONNtp3ta2g@mail.gmail.com>
References: <CAPE_nyKQz0AR8H6HFe-BiGGoG=+uJpzRT_LfFNhn4OMr5ARH6w@mail.gmail.com>
	<CAC-hyiGeKnCEFXQq_F=2HWRmA7cRiv=uF6+sDCB2TyHYiTXavA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40333 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964805Ab1GMRpI convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jul 2011 13:45:08 -0400
Received: by eyx24 with SMTP id 24so2194484eyx.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jul 2011 10:45:06 -0700 (PDT)
In-Reply-To: <CAC-hyiGeKnCEFXQq_F=2HWRmA7cRiv=uF6+sDCB2TyHYiTXavA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Sylar Shen <kimulaaa@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jul 13, 2011 at 9:59 AM, Yehuda Sadeh Weinraub
<yehudasa@gmail.com> wrote:
> On Wed, Jul 13, 2011 at 12:48 AM, Sylar Shen <kimulaaa@gmail.com> wro=
te:
>> Hi developers,
>> I installed ceph and radosgw v0.3 and got 1 server with =A0MON and
>> radosgw , 2 OSDs server. (without MDS)
>> The environment started successfully and I wanted to test
>> upload/download file via radosgw.
>> It all went well if I uploaded/downloaded English file names.
>> But It went wrong when I tried Chinese file names.
>> Radowgw can receive files normally, but Chinese file names were turn=
ed
>> into unrecognized codes.
>> Therefore, radosgw cannot show the file list in a bucket normally.
>> It turned out to show nothing when I wanted to list files in a bucke=
t.
>> But the Chinese file did exist in the bucket.
>>
>> I am curious that if I did something wrong to result in such kind of=
 problems
>> Does anyone who has the same problem as I did?
>
> That's a bug. It appears that the xml escaping doesn't work correctly
> with unicode characters. I just opened issue #1301 for that, we'll
> look at it.

I guess this means that XML escaping needs to be utf-8-aware, which it
isn't now. Probably it's just a matter of recognizing when we are
inside a utf-8 character and skipping the bytes comprising that
character. JSON escaping probably also needs that change.

cheers,
Colin


>
> Thanks,
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
