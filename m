From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD
Date: Tue, 1 Dec 2015 10:42:57 +0100
Message-ID: <565D6BA1.1020300@digiware.nl>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com> <565C38D2.4080403@digiware.nl>
 <20151130141320.GB20205@gmail.com> <565C5FF8.1090003@digiware.nl>
 <565C73A7.9050201@digiware.nl>
 <CAJ4mKGb0FZ=P5rzCOhDsh2Z2BiPa4hXav_QXTipZB3x0fQa0=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:32627 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755924AbbLAJnC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Dec 2015 04:43:02 -0500
In-Reply-To: <CAJ4mKGb0FZ=P5rzCOhDsh2Z2BiPa4hXav_QXTipZB3x0fQa0=A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Mykola Golub <mgolub@mirantis.com>, "ceph-devel@vger.kernel.org >> Ceph Development" <ceph-devel@vger.kernel.org>

On 30-11-2015 17:20, Gregory Farnum wrote:
>> Installed the results:
>> gmake install
>>
>> And looked at what it delivered:
>>          zfs diff <fs-en>
>>
>> And I have to be honest that I'm not really enjoying all the ceph-te=
st
>> stuff in my /usr/local/bin....
>> Would prefer it to go into something like:
>>          /usr/local/libexec/ceph/tests
>> or
>>          /usr/local/share/ceph/tests
>>
>> Not sure if this is possible without disrupting the automated testin=
g.
>
> As far as I know, none of what we do upstream relies on "make install=
"
> and I don't think it's very well-maintained. You could make some
> changes and submit a PR =E2=80=94 if it does break something it shoul=
d show up
> in the autobuilder bot.

Well got that all compiled and installed.

=46ixed a startup problem in /usr/local/bin/ceph's python with an unkno=
wn
error value. So that looks to run.

Created a config, and acompanying directories.

And now for the real work:
Run:
	ceph-mon -i freetest -d --debug_mon 10 --cluster digiceph -c=20
/etc/ceph/ceph.conf

Which bombs out with:
2015-12-01 10:32:41.877243 804015000  0 ceph version 10.0.0-677-gd704c5=
4=20
(d704c54b7923ef7265fa27018e9411d8deb463b3), process (unknown), pid 9389=
6
2015-12-01 10:32:41.879339 804015000 -1 load=20
dlopen(/usr/local/lib/ceph/erasure-code/libec_jerasure.so):=20
/usr/local/lib/ceph/erasure-code/libec_jerasure.so: Undefined symbol=20
"ceph_arch_neon"

So of to find where ceph_arch_neon is, and why it seems not defined.
Perhaps as simple as loading the shared libs??

--WjW


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
