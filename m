From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD
Date: Tue, 1 Dec 2015 13:44:46 +0100
Message-ID: <565D963E.3070703@digiware.nl>
References: <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com> <565C38D2.4080403@digiware.nl>
 <20151130141320.GB20205@gmail.com> <565C5FF8.1090003@digiware.nl>
 <565C73A7.9050201@digiware.nl>
 <CAJ4mKGb0FZ=P5rzCOhDsh2Z2BiPa4hXav_QXTipZB3x0fQa0=A@mail.gmail.com>
 <565D6BA1.1020300@digiware.nl> <20151201122257.GA8469@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:48507 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681AbbLAMpL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Dec 2015 07:45:11 -0500
In-Reply-To: <20151201122257.GA8469@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, "ceph-devel@vger.kernel.org >> Ceph Development" <ceph-devel@vger.kernel.org>

On 1-12-2015 13:22, Mykola Golub wrote:
> On Tue, Dec 01, 2015 at 10:42:57AM +0100, Willem Jan Withagen wrote:
>> On 30-11-2015 17:20, Gregory Farnum wrote:
>>>> Installed the results:
>>>> gmake install
>>>>
>>>> And looked at what it delivered:
>>>>          zfs diff <fs-en>
>>>>
>>>> And I have to be honest that I'm not really enjoying all the ceph-=
test
>>>> stuff in my /usr/local/bin....
>>>> Would prefer it to go into something like:
>>>>          /usr/local/libexec/ceph/tests
>>>> or
>>>>          /usr/local/share/ceph/tests
>>>>
>>>> Not sure if this is possible without disrupting the automated test=
ing.
>>>
>>> As far as I know, none of what we do upstream relies on "make insta=
ll"
>>> and I don't think it's very well-maintained. You could make some
>>> changes and submit a PR =E2=80=94 if it does break something it sho=
uld show up
>>> in the autobuilder bot.
>>
>> Well got that all compiled and installed.
>>
>> Fixed a startup problem in /usr/local/bin/ceph's python with an unkn=
own
>> error value. So that looks to run.
>>
>> Created a config, and acompanying directories.
>>
>> And now for the real work:
>> Run:
>> 	ceph-mon -i freetest -d --debug_mon 10 --cluster digiceph -c
>> /etc/ceph/ceph.conf
>>
>> Which bombs out with:
>> 2015-12-01 10:32:41.877243 804015000  0 ceph version 10.0.0-677-gd70=
4c54
>> (d704c54b7923ef7265fa27018e9411d8deb463b3), process (unknown), pid 9=
3896
>> 2015-12-01 10:32:41.879339 804015000 -1 load
>> dlopen(/usr/local/lib/ceph/erasure-code/libec_jerasure.so):
>> /usr/local/lib/ceph/erasure-code/libec_jerasure.so: Undefined symbol
>> "ceph_arch_neon"
>>
>> So of to find where ceph_arch_neon is, and why it seems not defined.
>> Perhaps as simple as loading the shared libs??
>
> You have to add -export-dynamic to LDFLAGS, something like in this
> patch:

That one I missed...
I guess I need to read more carefully, since lots of the remainder did
not make sense. Mainly because I did not really want to start a dev clu=
ster
right away.

So I'm  aiming for 'gmake check' atm.

--WjW

>
> https://github.com/trociny/ceph/commit/dcee0c0635d37f2b36257c55a3cc69=
d05b5afe5e#diff-ef3c0ccbdde56cca822801c6ef1d289aR79
>
> Also, you don't have to install binaries just to test if they work. A=
s
> I wrote previously:
>
> cd src
> ./vstart.sh
>
> It will start a dev cluster for you using binaries from the build
> dir. You can check if it runs with:
>
> ./ceph -s
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
