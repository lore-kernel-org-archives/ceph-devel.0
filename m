From: Dan Mick <dan.mick@inktank.com>
Subject: Re: production ready?
Date: Tue, 30 Oct 2012 14:06:28 -0700
Message-ID: <50904154.7080004@inktank.com>
References: <CAJH6TXiaknfB4yCgepkChqSse8Yo2wqtAzwA4RXUEbq=Yc7EbA@mail.gmail.com> <508EE540.5060303@inktank.com> <CAJH6TXiqD3UGdnK-_ArUj_iYYb5nCPX6U-T9qZhBbqHWzY70xA@mail.gmail.com> <CAPYLRzgtKU06uUoWW9QoJS_X7mvpFdkav+TqFn1vZh6MFtGSjw@mail.gmail.com> <CAJH6TXjV2vGynH+tPQE7XSY5tCVsQTtD8+omiMTOZ9KzhE052g@mail.gmail.com> <CAPYLRzgEKJJG62UnJQPi-fzQOm4_jHCkWx=hgKvy5q7i6EZD4g@mail.gmail.com> <CAJH6TXiLpvN4cD829P8njm6z9YkQXtpKWpYoFWsCAHQO1N+Dow@mail.gmail.com> <CAMm-wcJTfubebF=W+GCHdHM9kvZ6b9pGWpMv-Ri0-Pn7XQ-SeQ@mail.gmail.com> <CAJH6TXjE=nQscexL34fQ7RA0sDVc4+QB_O1r39UUAJ5_q87+OQ@mail.gmail.com> <CAMm-wcJox33ZvdfQMT-UN75g5tmGjkbLzPvcbJNmC0-jD1rKVw@mail.gmail.com> <CAJH6TXg=DpmE8O24TPtQwPL3MsEaqqdxBsnhS1zAFmjgRbUYrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:64811 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934562Ab2J3VGb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Oct 2012 17:06:31 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so440191pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 30 Oct 2012 14:06:31 -0700 (PDT)
In-Reply-To: <CAJH6TXg=DpmE8O24TPtQwPL3MsEaqqdxBsnhS1zAFmjgRbUYrQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>, Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org



On 10/30/2012 07:59 AM, Gandalf Corvotempesta wrote:
> 2012/10/30 =E8=A2=81=E5=86=AC <yuandong1222@gmail.com>:
>> Yes, but network (and many other isssues) must be considered.
>
> Obviously
>
>> 3 is suggested.
>
> Any contraindication running mon in the same OSD server?
>

Generally that's considered OK.  ceph-mon doesn't use very much disk or=
=20
CPU or network bandwidth.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
