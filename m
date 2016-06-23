From: Christian Balzer <chibi@gol.com>
Subject: Re: [ceph-users] Dramatic performance drop at certain number of
 objects in pool
Date: Thu, 23 Jun 2016 11:28:32 +0900
Message-ID: <20160623112832.47ace853@batzmaru.gol.ad.jp>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
	<1450235390.2134.1466084299677@ox.pcextreme.nl>
	<CA+z5DszqHuevkAF3W01R=7AAeqVcyuHZTX0+bAvThgihvOjwuA@mail.gmail.com>
	<CA+z5Dsy4tbyiL71C8CQCTQ66tY1=9thSWdNA4BSn6=tNfGUE6w@mail.gmail.com>
	<CA+e22Sc3iY5Lvp4oGwJ_wwpJsOJsWdB1thaHWEAuYP=bbGHAeg@mail.gmail.com>
	<D38DCB57.131AE%warren.wang@walmart.com>
	<20160621075856.3ad471d1@batzmaru.gol.ad.jp>
	<CA+e22SdrwRHmAD=67MpVtUXVyCOmidcoUXrANZVeDJc2tcJfnQ@mail.gmail.com>
	<CA+z5Dswx7V_HsiQ8TyhXmzJ70-D6kTQrfi8am7wMZOJVzsLerw@mail.gmail.com>
	<CA+e22SfaiBUQ9Wanay6_oji9t7131o67B2oDtaEW_zXwqCJfbQ@mail.gmail.com>
	<CA+z5DsxtBSWH3U-KYmxgTxUeMjNQouf9o0vRL+RU4LmOF0g2jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:35022 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbcFWC2i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jun 2016 22:28:38 -0400
In-Reply-To: <CA+z5DsxtBSWH3U-KYmxgTxUeMjNQouf9o0vRL+RU4LmOF0g2jw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Blair Bethwaite <blair.bethwaite@gmail.com>
Cc: Wade Holler <wade.holler@gmail.com>, Warren Wang - ISD <Warren.Wang@walmart.com>, Wido den Hollander <wido@42on.com>, Ceph Development <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Thu, 23 Jun 2016 12:01:38 +1000 Blair Bethwaite wrote:

> On 23 June 2016 at 11:41, Wade Holler <wade.holler@gmail.com> wrote:
> > Workload is native librados with python.  ALL 4k objects.
> 
> Was that meant to be 4MB?
> 
Nope, he means 4K, he's putting lots of small objects via a python script
into the cluster to test for exactly this problem.

See his original post.


Christian
-- 
Christian Balzer        Network/Systems Engineer                
chibi@gol.com   	Global OnLine Japan/Rakuten Communications
http://www.gol.com/
