From: Chandan Kumar Singh <chandan.kr.singh@gmail.com>
Subject: Re: Mojette based Erasure Code is more performant than ISA-L or Jerasure
Date: Wed, 20 Apr 2016 18:40:52 +0530
Message-ID: <CAOu2ZZVWa7j2EmtfRjiTPvqJKckxRCOCjaHfeb+hAFZ=_a_JSg@mail.gmail.com>
References: <CAOu2ZZXx-no2EyDqd_D8SZp=qu-AALarxWd6=43qY-kTw7ZOow@mail.gmail.com>
	<57177CF7.1090600@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35602 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbcDTNKy convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Apr 2016 09:10:54 -0400
Received: by mail-wm0-f53.google.com with SMTP id e201so50058211wme.0
        for <ceph-devel@vger.kernel.org>; Wed, 20 Apr 2016 06:10:53 -0700 (PDT)
In-Reply-To: <57177CF7.1090600@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

Hi

Here is the link for the benchmark study :
http://arxiv.org/pdf/1504.07038.pdf. Initially, the mailing list was
blocking it because of HTML subparts.

Regards
Chandan

On Wed, Apr 20, 2016 at 6:28 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi,
>
> On 20/04/2016 15:52, Chandan Kumar Singh wrote:
>> Hi
>>
>> The authors of  Mojette Erasure Encoding claim that this EC has high=
er
>> performance than ISA-L and Jerasure and can be used for hot storage
>> use cases. Their EC is used in open source RozoFS. What is your
>> evaluation of it? It will be nice if it is available as another EC
>> plugin.
>
> RozoFS is no longer developped (last commit was july last year). It w=
ould be nice to have an alternative implementation of the same algorith=
m, well maintained. It's sad to see Free Software being frozen. But Fre=
e Software is never dead, all it needs is good will and a little work t=
o be resurected ! I've never seen any benchmark regarding performances,=
 that would be the first step.
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
