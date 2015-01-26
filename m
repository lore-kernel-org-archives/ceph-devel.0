From: Yuri Weinstein <yuri.weinstein@inktank.com>
Subject: Re: upcoming dumpling v0.67.12
Date: Mon, 26 Jan 2015 11:02:06 -0800
Message-ID: <CAJBxG-sstfAyOwUYMG0SA36Rhd+rL1sy0eY+sidc3JJ+o4Dx0A@mail.gmail.com>
References: <54C65F3D.5020200@dachary.org>
	<CAJBxG-u=ffbwSkwdtiUM7NSnGdnaXjb_VOmOVfkA8LTX9ANYWg@mail.gmail.com>
	<54C67E3C.1030303@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:54531 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbbAZTCH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Jan 2015 14:02:07 -0500
Received: by mail-ob0-f179.google.com with SMTP id vb8so9379413obc.10
        for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2015 11:02:06 -0800 (PST)
In-Reply-To: <54C67E3C.1030303@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Loic,

Here is the run from sepia
http://pulpito.front.sepia.ceph.com/ubuntu-2015-01-26_09:26:27-upgrade:=
dumpling-dumpling-distro-basic-vps/

Two failures seems like env noise.

Thx
YuriW

On Mon, Jan 26, 2015 at 9:49 AM, Loic Dachary <loic@dachary.org> wrote:
> Thanks for letting me know about the upgrade tests results, it's enco=
uraging :-) I'll let you know when the tests make progress.
>
> On 26/01/2015 18:00, Yuri Weinstein wrote:
>> Loic,
>>
>> Thanks for the update.
>> I ran upgrade/dumpling last week (and all 42 jobs passed in octo and
>> sepia) to establish a base line.  And today running another one,
>> assuming it will pick up the already merged pull requests.
>>
>> Let me know when you ready for next steps.
>>
>> Thx
>> YuriW
>>
>> On Mon, Jan 26, 2015 at 7:37 AM, Loic Dachary <loic@dachary.org> wro=
te:
>>> Hi Yuri,
>>>
>>> Here is a short update on the progress of the upcoming dumpling v0.=
67.12.
>>>
>>> It is tracked with http://tracker.ceph.com/issues/10560. In the inv=
entory part, there is a list of all pull requests that are already merg=
ed in the dumpling branch. There only is one pull request waiting to be=
 merged and three issues waiting for backports. While these last three =
are being worked on, I started rbd, rgw and rados suites.
>>>
>>> I chose to display the inventory by pull request because I figured =
it would be more convenient to read because sometimes a single pull req=
uest spans multiple issues ( https://github.com/ceph/ceph/pull/2611 for=
 instance fixes two issues ).
>>>
>>> Cheers
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
