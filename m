From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: Re: output file not truncated
Date: Thu, 8 Sep 2011 12:50:03 +0800
Message-ID: <CANExM-OCJoHavXh=OqsORm=-2EJdn4J7j+h3h8pUmPVNJewQvw@mail.gmail.com>
References: <CANExM-M8+-i8f38vGkv2ivQkZGu5U7ba+6S5uxpRB8jOxWOkMw@mail.gmail.com>
	<Pine.LNX.4.64.1109072122580.5347@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58831 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab1IHEuF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Sep 2011 00:50:05 -0400
Received: by ywf7 with SMTP id 7so339968ywf.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Sep 2011 21:50:03 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1109072122580.5347@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

2011/9/8 Sage Weil <sage@newdream.net>:
> On Thu, 8 Sep 2011, Henry C Chang wrote:
>> Hi,
>>
>> Finally got some time to play around ceph.
>> I found that: when I dumped osd status by: ceph osd dump -o
>> /tmp/dump.json --format=3Djson, I got some garbage data in the end o=
f
>> file.
>> Thus, I checked the code. I noticed that the output file was not
>> truncated in ceph_tool_cli_input:
>>
>> =C2=A0 // Write to a file. Don't truncate the file.
>> =C2=A0 int fd =3D TEMP_FAILURE_RETRY(::open(outfile, O_WRONLY|O_CREA=
T|O_TRUNC, 0644));
>>
>> Since it seems intended, I was wondering why. After all, in my case,=
 I
>> found it causing problems.
>
> There was a recent change that lets you stack up commands, separated
> by ';':
>
> =C2=A0$ ceph pg stat \; osd stat

Cool. It's quite useful.

>
> Basically we were lazy and reopened the output file inside the loop.
>
> Just pushed a patch cleaning it up some!
>

Thanks.

Henry
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
