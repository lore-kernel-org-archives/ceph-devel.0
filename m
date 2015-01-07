From: Yuri Weinstein <yuri.weinstein@inktank.com>
Subject: Re: Testing the next giant release
Date: Wed, 7 Jan 2015 14:34:39 -0800
Message-ID: <CAJBxG-s5C6wzuJhVZhUAfNy9G1XuaDv+6D+R5c95WVWug7o4nA@mail.gmail.com>
References: <54AD3C8B.4030705@dachary.org>
	<CAFd2DpShjeBXQ5YPfWLVq2zsSTZDBzyZuvo40kOhzVy2fTdmCA@mail.gmail.com>
	<54ADB2FA.9030204@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:56648 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbbAGWek convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Jan 2015 17:34:40 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so8488568wiv.17
        for <ceph-devel@vger.kernel.org>; Wed, 07 Jan 2015 14:34:39 -0800 (PST)
In-Reply-To: <54ADB2FA.9030204@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Tamil Muthamizhan <tamil.muthamizhan@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Loic,

I think if you run those on bare metals (not vps) they will run on
whatever machines are available in the octo or sepia labs.

Thx
YuriW

On Wed, Jan 7, 2015 at 2:28 PM, Loic Dachary <loic@dachary.org> wrote:
>
>
> On 07/01/2015 23:20, Tamil Muthamizhan wrote:
>> hi Loic,
>>
>> we have a suite to perform smoke tests for rados/rbd/rgw.
>> maybe you can try that to make sure things work.
>
> Are these the suites I should try:
>
> https://github.com/ceph/ceph-qa-suite/tree/master/suites/rados
> https://github.com/ceph/ceph-qa-suite/tree/master/suites/rbd
> https://github.com/ceph/ceph-qa-suite/tree/master/suites/rgw
>
> any specific settings or just all of three without restrictions (i.e.=
 all os versions etc.)
>
> Cheers
>
>>
>> once it looks good, we can have them scheduled to run using teutholo=
gy for a more elaborate run.
>>
>> Thanks,
>> Tamil
>>
>>
>> On Wed, Jan 7, 2015 at 6:02 AM, Loic Dachary <loic@dachary.org <mail=
to:loic@dachary.org>> wrote:
>>
>>     Hi Tamil,
>>
>>     I've merged / integrated the giant backports found at
>>
>>     https://github.com/ceph/ceph/pull/3186
>>     https://github.com/ceph/ceph/pull/3178
>>     https://github.com/ceph/ceph/pull/2954
>>     https://github.com/ceph/ceph/pull/3191
>>     https://github.com/ceph/ceph/pull/3168
>>     https://github.com/ceph/ceph/pull/3289
>>
>>     into
>>
>>     http://workbench.dachary.org/ceph/ceph/commit/0ea20e6c51208d6710=
f469454ab3f964bfa7c9d2
>>
>>     and successfully ran make check on it
>>
>>     http://workbench.dachary.org:8080/projects/10?ref=3Dgiant-backpo=
rts
>>
>>     If I'm not mistaken the next step would be to run teuthology. If=
 I'm to do it, would you be so kind as to let me know which suites are =
most relevant ? If someone else will take care of it, should I push the=
 integration branch somewhere ?
>>
>>     Cheers
>>
>>     --
>>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>>
>>
>>
>> --
>> Regards,
>> Tamil
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
