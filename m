From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: Swift tests failing randomly
Date: Mon, 11 Aug 2014 10:11:48 -0700
Message-ID: <CABBk=J8by_UDKXddSDQ5HovtCtNOvhzBsGWdAiywEN1MmSS69A@mail.gmail.com>
References: <53E7316D.3090808@dachary.org>
	<53E8ED9C.5000601@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:46142 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbaHKRLt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Aug 2014 13:11:49 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so4618997igb.2
        for <ceph-devel@vger.kernel.org>; Mon, 11 Aug 2014 10:11:48 -0700 (PDT)
In-Reply-To: <53E8ED9C.5000601@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Yeah, looking at these logs, it really seem that it's just that things
are going slow on these machines and it's hitting timeouts. The fix is
ok with me, although I'd rather have it adjusted per machine type
(somehow).

Yehuda

On Mon, Aug 11, 2014 at 9:21 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Yehuda,
>
> It looks like increasing the rgw idle timeout makes the problem go aw=
ay ( https://github.com/ceph/ceph-qa-suite/pull/79 and http://tracker.c=
eph.com/issues/8988 ). It previously was 300 sec which looks like a lar=
ge value already. Does this fix / workaround make sense to you ?
>
> Cheers
>
> On 10/08/2014 10:46, Loic Dachary wrote:
>> Hi Yehuda,
>>
>> In the past few months the swift tests failed randomly and I was unf=
ortunately unable to figure out why. Here are a few examples:
>>
>>     http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:firefly=
-x:stress-split-wip-9025-chunk-remapping-testing-basic-vps/406944
>>     http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:firefly=
-x:stress-split-wip-9025-chunk-remapping-testing-basic-vps/406941
>>     http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:firefly=
-x:stress-split-wip-9025-chunk-remapping-testing-basic-vps/406946
>>     http://pulpito.ceph.com/loic-2014-08-08_12:17:30-upgrade:firefly=
-x:stress-split-wip-9025-chunk-remapping-testing-basic-vps/406947
>>
>> and it has happened on every upgrade test run since I can remember. =
I fail to see a pattern and cannot figure out what the real problem is.=
 It would be really great if you could take a look. Even a hunch or a t=
ip would be greatly appreciated :-)
>>
>> You can find more context in
>>
>> http://tracker.ceph.com/issues/8988
>> http://tracker.ceph.com/issues/8016
>> http://tracker.ceph.com/issues/7799
>>
>> and discussions at
>>
>> http://www.spinics.net/lists/ceph-devel/msg19933.html
>>
>> Cheers
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
