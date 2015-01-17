From: Yuri Weinstein <yuri.weinstein@inktank.com>
Subject: Re: ceph-qa analysis output
Date: Sat, 17 Jan 2015 14:08:27 -0800
Message-ID: <CAJBxG-tjfWt+=HGJF0sZBFRFnYuCs_VdVpQzO8XAXs3ooE4e1g@mail.gmail.com>
References: <54BA5E8D.30508@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:52438 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbbAQWI1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Jan 2015 17:08:27 -0500
Received: by mail-ob0-f172.google.com with SMTP id wp18so2954314obc.3
        for <ceph-devel@vger.kernel.org>; Sat, 17 Jan 2015 14:08:27 -0800 (PST)
In-Reply-To: <54BA5E8D.30508@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

I'd love to.

Let's chat on Monday to finalize format.

(
PS:  I think format would be easier to maintain like new lines enforced=
, e,g.

'701575', '701576', '701582', '701590'
 ttp://tracker.ceph.com/issues/10543
=46AILED assert(m_seed < old_pg_num

<jobs,...>
<issue RE>
<description>  (this I suppose can be retrieved from tracker, a?  if
yes, we may not need it at all)
)

Would it be possible to feed output of those machine digested emails
(and hopefully others) into this doc -
https://docs.google.com/a/inktank.com/spreadsheets/d/1S01gkuA149U5XSLSt=
uzEoh-14tK2ICGm5tsCUomuzTo/edit#gid=3D403616374
(I granted you access as it's still under development/review) ?


PPS: Again this ticket http://tracker.ceph.com/issues/10455 would be
helpful in what we are discussing here.

Thx
YuriW

On Sat, Jan 17, 2015 at 5:07 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Yuri,
>
> It would be great if the analysis you compile daily was machine reada=
ble. For instance, in a mail you sent to ceph-qa I read
>
> '701575', '701576', '701582', '701590' - known issue
> http://tracker.ceph.com/issues/10543
>
> "FAILED assert(m_seed < old_pg_num)"
>
> (duplicate of http://tracker.ceph.com/issues/10430)
>
> which could be something like:
>
> '701575', '701576', '701582', '701590': http://tracker.ceph.com/issue=
s/10543 FAILED assert(m_seed < old_pg_num)
>
> or any other format you find easier to use consistently.
>
> The reason I ask is because it would help me write a script that asso=
ciates redmine tickets to your findings, in the context of backporting.=
 It's just an idea, not a request ;-)
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
