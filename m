From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Compiling for FreeBSD
Date: Mon, 30 Nov 2015 11:20:37 -0500
Message-ID: <CAJ4mKGb0FZ=P5rzCOhDsh2Z2BiPa4hXav_QXTipZB3x0fQa0=A@mail.gmail.com>
References: <565B3999.3050302@digiware.nl>
	<CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
	<565B4A7F.60301@digiware.nl>
	<CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
	<20151130065812.GA20205@gmail.com>
	<565C38D2.4080403@digiware.nl>
	<20151130141320.GB20205@gmail.com>
	<565C5FF8.1090003@digiware.nl>
	<565C73A7.9050201@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33984 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbbK3QUi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Nov 2015 11:20:38 -0500
Received: by wmvv187 with SMTP id v187so164943285wmv.1
        for <ceph-devel@vger.kernel.org>; Mon, 30 Nov 2015 08:20:37 -0800 (PST)
In-Reply-To: <565C73A7.9050201@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Mykola Golub <mgolub@mirantis.com>, "ceph-devel@vger.kernel.org >> Ceph Development" <ceph-devel@vger.kernel.org>

On Mon, Nov 30, 2015 at 11:04 AM, Willem Jan Withagen <wjw@digiware.nl>=
 wrote:
> On 30-11-2015 15:40, Willem Jan Withagen wrote:
>> On 30-11-2015 15:13, Mykola Golub wrote:
>>> On Mon, Nov 30, 2015 at 12:53:54PM +0100, Willem Jan Withagen wrote=
:
>>>
>>>>> git clone --recursive -b wip-freebsd https://github.com/trociny/c=
eph.git
>>>>> cd ceph
>>>>> ./install-deps.sh
>>>>> ./do_autogen.sh
>>>>> gmake
>>>>> cd src
>>>>> ./vstart.sh # start dev cluster
>>>>> ./ceph -s # check it works
>>>>>
>>>>
>>>> So what backend for the OSDs are you using here?
>>>
>>> The default one, which is FileStore. I have not done much testing
>>> though...
>>>
>>
>> Well,
>> Cherry-picked a few of you diffs.
>> Compilation is now slugging thru the tests in my tree.
>> Running gmake in serial mode, so it is slow with clang.
>
> Installed the results:
> gmake install
>
> And looked at what it delivered:
>         zfs diff <fs-en>
>
> And I have to be honest that I'm not really enjoying all the ceph-tes=
t
> stuff in my /usr/local/bin....
> Would prefer it to go into something like:
>         /usr/local/libexec/ceph/tests
> or
>         /usr/local/share/ceph/tests
>
> Not sure if this is possible without disrupting the automated testing=
=2E

As far as I know, none of what we do upstream relies on "make install"
and I don't think it's very well-maintained. You could make some
changes and submit a PR =E2=80=94 if it does break something it should =
show up
in the autobuilder bot.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
