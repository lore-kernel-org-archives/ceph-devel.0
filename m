From: Yuri Weinstein <yuri.weinstein@inktank.com>
Subject: Re: Testing the next giant release
Date: Wed, 7 Jan 2015 15:29:05 -0800
Message-ID: <CAJBxG-vBhwymM5e_hjF3uaen+rUP_5MRgZZ7Efa0d7E=DG2geg@mail.gmail.com>
References: <54AD3C8B.4030705@dachary.org>
	<CAFd2DpShjeBXQ5YPfWLVq2zsSTZDBzyZuvo40kOhzVy2fTdmCA@mail.gmail.com>
	<54ADB2FA.9030204@dachary.org>
	<CAJBxG-s5C6wzuJhVZhUAfNy9G1XuaDv+6D+R5c95WVWug7o4nA@mail.gmail.com>
	<CAFd2DpSu5uvQKjfz=vtCMOuLYEDddfrgCNLja+LU5sC+XHWLoA@mail.gmail.com>
	<54ADBB4F.40705@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:49898 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbbAGX3H convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Jan 2015 18:29:07 -0500
Received: by mail-wg0-f53.google.com with SMTP id x13so2092081wgg.26
        for <ceph-devel@vger.kernel.org>; Wed, 07 Jan 2015 15:29:06 -0800 (PST)
In-Reply-To: <54ADBB4F.40705@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Tamil Muthamizhan <tamil.muthamizhan@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Look for them in new Octo lab - http://pulpito.ceph.redhat.com/

On Wed, Jan 7, 2015 at 3:03 PM, Loic Dachary <loic@dachary.org> wrote:
>
> Thanks Yuri & Tamil !
>
> One last question : http://pulpito.ceph.com/?branch=3Dgiant does not =
show a run of rbd or rgw. They would be useful to figure out what kind =
of errors I should expect. Are past results archived elsewhere by any c=
hance ?
>
>
> On 07/01/2015 23:53, Tamil Muthamizhan wrote:
>> yes, just those suites will do Loic.
>>
>> On Wed, Jan 7, 2015 at 2:34 PM, Yuri Weinstein
>> <yuri.weinstein@inktank.com> wrote:
>>> Loic,
>>>
>>> I think if you run those on bare metals (not vps) they will run on
>>> whatever machines are available in the octo or sepia labs.
>>>
>>> Thx
>>> YuriW
>>>
>>> On Wed, Jan 7, 2015 at 2:28 PM, Loic Dachary <loic@dachary.org> wro=
te:
>>>>
>>>>
>>>> On 07/01/2015 23:20, Tamil Muthamizhan wrote:
>>>>> hi Loic,
>>>>>
>>>>> we have a suite to perform smoke tests for rados/rbd/rgw.
>>>>> maybe you can try that to make sure things work.
>>>>
>>>> Are these the suites I should try:
>>>>
>>>> https://github.com/ceph/ceph-qa-suite/tree/master/suites/rados
>>>> https://github.com/ceph/ceph-qa-suite/tree/master/suites/rbd
>>>> https://github.com/ceph/ceph-qa-suite/tree/master/suites/rgw
>>>>
>>>> any specific settings or just all of three without restrictions (i=
=2Ee. all os versions etc.)
>>>>
>>>> Cheers
>>>>
>>>>>
>>>>> once it looks good, we can have them scheduled to run using teuth=
ology for a more elaborate run.
>>>>>
>>>>> Thanks,
>>>>> Tamil
>>>>>
>>>>>
>>>>> On Wed, Jan 7, 2015 at 6:02 AM, Loic Dachary <loic@dachary.org <m=
ailto:loic@dachary.org>> wrote:
>>>>>
>>>>>     Hi Tamil,
>>>>>
>>>>>     I've merged / integrated the giant backports found at
>>>>>
>>>>>     https://github.com/ceph/ceph/pull/3186
>>>>>     https://github.com/ceph/ceph/pull/3178
>>>>>     https://github.com/ceph/ceph/pull/2954
>>>>>     https://github.com/ceph/ceph/pull/3191
>>>>>     https://github.com/ceph/ceph/pull/3168
>>>>>     https://github.com/ceph/ceph/pull/3289
>>>>>
>>>>>     into
>>>>>
>>>>>     http://workbench.dachary.org/ceph/ceph/commit/0ea20e6c51208d6=
710f469454ab3f964bfa7c9d2
>>>>>
>>>>>     and successfully ran make check on it
>>>>>
>>>>>     http://workbench.dachary.org:8080/projects/10?ref=3Dgiant-bac=
kports
>>>>>
>>>>>     If I'm not mistaken the next step would be to run teuthology.=
 If I'm to do it, would you be so kind as to let me know which suites a=
re most relevant ? If someone else will take care of it, should I push =
the integration branch somewhere ?
>>>>>
>>>>>     Cheers
>>>>>
>>>>>     --
>>>>>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Regards,
>>>>> Tamil
>>>>
>>>> --
>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>
>>
>>
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
