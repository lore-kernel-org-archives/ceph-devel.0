From: Wade Holler <wade.holler@gmail.com>
Subject: Re: [ceph-users] Dramatic performance drop at certain number of
 objects in pool
Date: Wed, 22 Jun 2016 22:31:09 -0400
Message-ID: <CA+e22SfkY6vvD3JcfO-0XaCyU=pmuMAeYu2DSa1oWVCxf8gWSw@mail.gmail.com>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
 <1450235390.2134.1466084299677@ox.pcextreme.nl> <CA+z5DszqHuevkAF3W01R=7AAeqVcyuHZTX0+bAvThgihvOjwuA@mail.gmail.com>
 <CA+z5Dsy4tbyiL71C8CQCTQ66tY1=9thSWdNA4BSn6=tNfGUE6w@mail.gmail.com>
 <CA+e22Sc3iY5Lvp4oGwJ_wwpJsOJsWdB1thaHWEAuYP=bbGHAeg@mail.gmail.com>
 <D38DCB57.131AE%warren.wang@walmart.com> <20160621075856.3ad471d1@batzmaru.gol.ad.jp>
 <CA+e22SdrwRHmAD=67MpVtUXVyCOmidcoUXrANZVeDJc2tcJfnQ@mail.gmail.com>
 <CA+z5Dswx7V_HsiQ8TyhXmzJ70-D6kTQrfi8am7wMZOJVzsLerw@mail.gmail.com>
 <CA+e22SfaiBUQ9Wanay6_oji9t7131o67B2oDtaEW_zXwqCJfbQ@mail.gmail.com> <CA+z5DsxtBSWH3U-KYmxgTxUeMjNQouf9o0vRL+RU4LmOF0g2jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33957 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbcFWCbL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 22:31:11 -0400
Received: by mail-oi0-f53.google.com with SMTP id s66so50391137oif.1
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jun 2016 19:31:10 -0700 (PDT)
In-Reply-To: <CA+z5DsxtBSWH3U-KYmxgTxUeMjNQouf9o0vRL+RU4LmOF0g2jw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Blair Bethwaite <blair.bethwaite@gmail.com>
Cc: Christian Balzer <chibi@gol.com>, Warren Wang - ISD <Warren.Wang@walmart.com>, Wido den Hollander <wido@42on.com>, Ceph Development <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

No.  Our application writes very small objects.


On Wed, Jun 22, 2016 at 10:01 PM, Blair Bethwaite
<blair.bethwaite@gmail.com> wrote:
> On 23 June 2016 at 11:41, Wade Holler <wade.holler@gmail.com> wrote:
>> Workload is native librados with python.  ALL 4k objects.
>
> Was that meant to be 4MB?
>
> --
> Cheers,
> ~Blairo
