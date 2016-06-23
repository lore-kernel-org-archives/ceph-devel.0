From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: [ceph-users] Dramatic performance drop at certain number of
 objects in pool
Date: Thu, 23 Jun 2016 12:36:51 +1000
Message-ID: <CA+z5Dsz1j_OP8niah_n7p-RtqTVz26C9xxGzQdj0KGru2Sri_w@mail.gmail.com>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
 <1450235390.2134.1466084299677@ox.pcextreme.nl> <CA+z5DszqHuevkAF3W01R=7AAeqVcyuHZTX0+bAvThgihvOjwuA@mail.gmail.com>
 <CA+z5Dsy4tbyiL71C8CQCTQ66tY1=9thSWdNA4BSn6=tNfGUE6w@mail.gmail.com>
 <CA+e22Sc3iY5Lvp4oGwJ_wwpJsOJsWdB1thaHWEAuYP=bbGHAeg@mail.gmail.com>
 <D38DCB57.131AE%warren.wang@walmart.com> <20160621075856.3ad471d1@batzmaru.gol.ad.jp>
 <CA+e22SdrwRHmAD=67MpVtUXVyCOmidcoUXrANZVeDJc2tcJfnQ@mail.gmail.com>
 <CA+z5Dswx7V_HsiQ8TyhXmzJ70-D6kTQrfi8am7wMZOJVzsLerw@mail.gmail.com>
 <CA+e22SfaiBUQ9Wanay6_oji9t7131o67B2oDtaEW_zXwqCJfbQ@mail.gmail.com>
 <CA+z5DsxtBSWH3U-KYmxgTxUeMjNQouf9o0vRL+RU4LmOF0g2jw@mail.gmail.com> <20160623112832.47ace853@batzmaru.gol.ad.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35411 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbcFWChM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 22:37:12 -0400
Received: by mail-vk0-f47.google.com with SMTP id j2so87568928vkg.2
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2016 19:37:11 -0700 (PDT)
In-Reply-To: <20160623112832.47ace853@batzmaru.gol.ad.jp>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Balzer <chibi@gol.com>, Wade Holler <wade.holler@gmail.com>
Cc: Warren Wang - ISD <Warren.Wang@walmart.com>, Wido den Hollander <wido@42on.com>, Ceph Development <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi Christian,

Ah ok, I didn't see object size mentioned earlier. But I guess direct
rados small objects would be a rarish use-case and explains the very
high object counts.

I'm interested in finding the right balance for RBD given object size
is another variable that can be tweaked there. I recall the
UnitedStack folks using 32MB.

Cheers,

On 23 June 2016 at 12:28, Christian Balzer <chibi@gol.com> wrote:
> On Thu, 23 Jun 2016 12:01:38 +1000 Blair Bethwaite wrote:
>
>> On 23 June 2016 at 11:41, Wade Holler <wade.holler@gmail.com> wrote:
>> > Workload is native librados with python.  ALL 4k objects.
>>
>> Was that meant to be 4MB?
>>
> Nope, he means 4K, he's putting lots of small objects via a python script
> into the cluster to test for exactly this problem.
>
> See his original post.
>
>
> Christian
> --
> Christian Balzer        Network/Systems Engineer
> chibi@gol.com           Global OnLine Japan/Rakuten Communications
> http://www.gol.com/



-- 
Cheers,
~Blairo
