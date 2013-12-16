From: Ian Colle <ian.colle@inktank.com>
Subject: Re: creation of the puppet-ceph repository
Date: Mon, 16 Dec 2013 16:24:34 -0700
Message-ID: <CED4D9B5.1FA0B%ian.colle@inktank.com>
References: <52AC97E2.8080907@dachary.org>
 <CED3B77C.1F7CF%ian.colle@inktank.com>
 <52AF56D9.9040005@dachary.org>
 <CED4D2E9.1F9F3%ian.colle@inktank.com>
 <52AF89CC.8060007@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:54484 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab3LPXaq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 18:30:46 -0500
Received: by mail-ie0-f179.google.com with SMTP id x13so7501722ief.38
        for <ceph-devel@vger.kernel.org>; Mon, 16 Dec 2013 15:30:46 -0800 (PST)
In-Reply-To: <52AF89CC.8060007@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, ceph-devel@vger.kernel.org


On 12/16/13, 4:16 PM, "Loic Dachary" <loic@dachary.org> wrote:

>Hi Ian,
>
>I failed to push with:
>
>ERROR: Permission to ceph/puppet-ceph.git denied to dachary.
>fatal: Could not read from remote repository.
>
>I also checked if I had enough permissions to merge a pull request and
>apparently I don't. Would you be so kind as to grant me additional
>permission on this specific repository ? If it looks like I already ha=
ve
>permissions I will investigate more.

Try again now.

>
>Really sorry this is being so complicated :-(
>
>On 16/12/2013 23:55, Ian Colle wrote:
>>=20
>>=20
>> On 12/16/13, 12:39 PM, "Loic Dachary" <loic@dachary.org> wrote:
>>=20
>>> Hi Ian,
>>>
>>> It looks like nothing at all was created after all, not even the
>>> repository. Or maybe I don't understand how github works.
>>>
>>> $ git push puppet-ceph master
>>> ERROR: Permission to ceph/puppet-ceph.git denied to dachary.
>>> fatal: Could not read from remote repository.
>>>
>>> Please make sure you have the correct access rights
>>> and the repository exists.
>>>
>>> Could you please re-create it and add a README ? I should be able t=
o
>>>get
>>> rid of it afterwards.
>>=20
>> Done.
>>=20
>>>
>>> Thank you for your patience
>>>
>>> On 16/12/2013 04:46, Ian Colle wrote:
>>>>
>>>>
>>>> On 12/14/13, 9:39 AM, "Loic Dachary" <loic@dachary.org> wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> Could someone with sufficient permission please create the
>>>>>puppet-ceph
>>>>> repository (empty, no README or .gitignore) at
>>>>>http://github.com/ceph/
>>>>> ?
>>>>
>>>> Done.
>>>>
>>>> https://github.com/ceph/puppet-ceph
>>>>
>>>>
>>>>>
>>>>> A few weeks ago it was decided to host the development of the mod=
ule
>>>>>on
>>>>> stackforge ( https://github.com/stackforge/puppet-ceph ) and also=
 to
>>>>> establish a mirror under the ceph github namespace.
>>>>>
>>>>> Cheers
>>>>>
>>>>> --=20
>>>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>>>
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"
>>>>in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>> --=20
>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>
>>=20
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>
>--=20
>Lo=EFc Dachary, Artisan Logiciel Libre
>


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
