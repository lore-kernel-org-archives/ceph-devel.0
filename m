From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: RBD Utilization
Date: Thu, 24 Mar 2016 12:37:06 +0100
Message-ID: <CAOi1vP_rPQtC+ij0yFB4p7iwUNDT=24hKmU=wcF4YOC3G-rXew@mail.gmail.com>
References: <1674621217.33764396.1458725323072.JavaMail.zimbra@redhat.com>
	<807270756.33765380.1458725728050.JavaMail.zimbra@redhat.com>
	<CANA9Uk4cME1cmPfk+a1kJ0=3C9p6uCNFgXxahNvz53sTkL=KHA@mail.gmail.com>
	<1749699911.33776369.1458729038657.JavaMail.zimbra@redhat.com>
	<56F2A7F2.7050103@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36220 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbcCXLhI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2016 07:37:08 -0400
Received: by mail-lf0-f67.google.com with SMTP id r8so3333581lfe.3
        for <ceph-devel@vger.kernel.org>; Thu, 24 Mar 2016 04:37:07 -0700 (PDT)
In-Reply-To: <56F2A7F2.7050103@earthlink.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bruce <bkmcfarland@earthlink.net>
Cc: Anmol Babu <anbabu@redhat.com>, M Ranga Swami Reddy <swamireddy@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, "Team discussions around SDS management program (aka USM or RHS
	Controller)" <sds-mgmt@redhat.com>

On Wed, Mar 23, 2016 at 3:28 PM, Bruce <bkmcfarland@earthlink.net> wrote:
> What I like to do is create a pool for each rbd. Then using any of the
> commands that provide per pool stats now also reflect each rbd.

You should use "rbd du" for this.  RADOS pools have substantial
cluster-wide overhead (a pool is basically a set of PGs), you do not
want to create one pool per image.

Thanks,

                Ilya
