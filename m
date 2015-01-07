From: Tamil Muthamizhan <tamil.muthamizhan@inktank.com>
Subject: Re: Testing the next giant release
Date: Wed, 7 Jan 2015 14:53:26 -0800
Message-ID: <CAFd2DpSu5uvQKjfz=vtCMOuLYEDddfrgCNLja+LU5sC+XHWLoA@mail.gmail.com>
References: <54AD3C8B.4030705@dachary.org> <CAFd2DpShjeBXQ5YPfWLVq2zsSTZDBzyZuvo40kOhzVy2fTdmCA@mail.gmail.com>
 <54ADB2FA.9030204@dachary.org> <CAJBxG-s5C6wzuJhVZhUAfNy9G1XuaDv+6D+R5c95WVWug7o4nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:58293 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbbAGWx5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Jan 2015 17:53:57 -0500
Received: by mail-wg0-f51.google.com with SMTP id x12so2068679wgg.10
        for <ceph-devel@vger.kernel.org>; Wed, 07 Jan 2015 14:53:56 -0800 (PST)
In-Reply-To: <CAJBxG-s5C6wzuJhVZhUAfNy9G1XuaDv+6D+R5c95WVWug7o4nA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

yes, just those suites will do Loic.

On Wed, Jan 7, 2015 at 2:34 PM, Yuri Weinstein
<yuri.weinstein@inktank.com> wrote:
> Loic,
>
> I think if you run those on bare metals (not vps) they will run on
> whatever machines are available in the octo or sepia labs.
>
> Thx
> YuriW
>
> On Wed, Jan 7, 2015 at 2:28 PM, Loic Dachary <loic@dachary.org> wrote=
:
>>
>>
>> On 07/01/2015 23:20, Tamil Muthamizhan wrote:
>>> hi Loic,
>>>
>>> we have a suite to perform smoke tests for rados/rbd/rgw.
>>> maybe you can try that to make sure things work.
>>
>> Are these the suites I should try:
>>
>> https://github.com/ceph/ceph-qa-suite/tree/master/suites/rados
>> https://github.com/ceph/ceph-qa-suite/tree/master/suites/rbd
>> https://github.com/ceph/ceph-qa-suite/tree/master/suites/rgw
>>
>> any specific settings or just all of three without restrictions (i.e=
=2E all os versions etc.)
>>
>> Cheers
>>
>>>
>>> once it looks good, we can have them scheduled to run using teuthol=
ogy for a more elaborate run.
>>>
>>> Thanks,
>>> Tamil
>>>
>>>
>>> On Wed, Jan 7, 2015 at 6:02 AM, Loic Dachary <loic@dachary.org <mai=
lto:loic@dachary.org>> wrote:
>>>
>>>     Hi Tamil,
>>>
>>>     I've merged / integrated the giant backports found at
>>>
>>>     https://github.com/ceph/ceph/pull/3186
>>>     https://github.com/ceph/ceph/pull/3178
>>>     https://github.com/ceph/ceph/pull/2954
>>>     https://github.com/ceph/ceph/pull/3191
>>>     https://github.com/ceph/ceph/pull/3168
>>>     https://github.com/ceph/ceph/pull/3289
>>>
>>>     into
>>>
>>>     http://workbench.dachary.org/ceph/ceph/commit/0ea20e6c51208d671=
0f469454ab3f964bfa7c9d2
>>>
>>>     and successfully ran make check on it
>>>
>>>     http://workbench.dachary.org:8080/projects/10?ref=3Dgiant-backp=
orts
>>>
>>>     If I'm not mistaken the next step would be to run teuthology. I=
f I'm to do it, would you be so kind as to let me know which suites are=
 most relevant ? If someone else will take care of it, should I push th=
e integration branch somewhere ?
>>>
>>>     Cheers
>>>
>>>     --
>>>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>>>
>>>
>>>
>>> --
>>> Regards,
>>> Tamil
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>



--=20
Regards,
Tamil
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
