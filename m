From: Wido den Hollander <wido@widodh.nl>
Subject: Re: OSD's journal size
Date: Tue, 07 Aug 2012 10:28:27 +0200
Message-ID: <5020D1AB.6070309@widodh.nl>
References: <CAOLwVU=SjpOAAYNohhMN4oYZqTXMEQkTrCjW7L+E+Dr5M=mNBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:55734 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab2HGI22 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Aug 2012 04:28:28 -0400
In-Reply-To: <CAOLwVU=SjpOAAYNohhMN4oYZqTXMEQkTrCjW7L+E+Dr5M=mNBg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 08/07/2012 09:18 AM, S=E9bastien Han wrote:
> Hi everyone,
>
> I did a couple of research about journal's size on the Internet but I
> didn't find any good results.
>
> How do you calculate the 'ideal/required' size of an OSD journal? I
> suppose that the calculation is based on the disk size, but...
>

I found a post on the devel list from about 2 months ago.

This should explain:=20
http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/7032

Wido

> Thank you in advance.
>
> Cheers!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
