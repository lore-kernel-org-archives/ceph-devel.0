From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: OSD's journal size
Date: Tue, 7 Aug 2012 11:14:30 +0200
Message-ID: <CAOLwVU=ho2H5KsXX1ETrNR4ky_XKNQUtC8ZCURBHnetGSATo4w@mail.gmail.com>
References: <CAOLwVU=SjpOAAYNohhMN4oYZqTXMEQkTrCjW7L+E+Dr5M=mNBg@mail.gmail.com>
 <5020D1AB.6070309@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:63500 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751297Ab2HGJOw convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 7 Aug 2012 05:14:52 -0400
Received: by lagy9 with SMTP id y9so1244289lag.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Aug 2012 02:14:50 -0700 (PDT)
In-Reply-To: <5020D1AB.6070309@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Ok thanks!

Seems logic, just need to test that.

Thanks ;)


On Tue, Aug 7, 2012 at 10:28 AM, Wido den Hollander <wido@widodh.nl> wr=
ote:
>
> On 08/07/2012 09:18 AM, S=E9bastien Han wrote:
>>
>> Hi everyone,
>>
>> I did a couple of research about journal's size on the Internet but =
I
>> didn't find any good results.
>>
>> How do you calculate the 'ideal/required' size of an OSD journal? I
>> suppose that the calculation is based on the disk size, but...
>>
>
> I found a post on the devel list from about 2 months ago.
>
> This should explain: http://comments.gmane.org/gmane.comp.file-system=
s.ceph.devel/7032
>
> Wido
>
>> Thank you in advance.
>>
>> Cheers!
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
