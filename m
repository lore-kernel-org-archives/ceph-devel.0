From: Sage Weil <sweil@redhat.com>
Subject: =?ISO-8859-15?Q?Re=3A_When_shall=A0EC_overwrites=A0be_production-ready=3F?=
Date: Wed, 25 Jan 2017 12:45:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701251243150.3654@piezo.novalocal>
References: <201701251515209373144@zte.com.cn>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-584475254-1485348330=:3654"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751386AbdAYMpb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 25 Jan 2017 07:45:31 -0500
In-Reply-To: <201701251515209373144@zte.com.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xie.xingguo@zte.com.cn
Cc: sjust@redhat.com, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-584475254-1485348330=:3654
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Xie,

On Wed, 25 Jan 2017, xie.xingguo@zte.com.cn wrote:
> 
> Hi sage and sam:
> 
>              As the title says, I am interested to know  when EC overwrites
> shall become production ready.

Luminous.  There were a few remaining issues with the kraken code that 
we're working through now (checksumming and scrub), but we realized 
last night that those should be pretty quick to resolve.

The big question is whether we tackle partial stripe updates for luminous.  
That will make small updates more efficient, but will require some 
significant work, and there are several other rados items with higher 
priority.

sage

--8323329-584475254-1485348330=:3654--
