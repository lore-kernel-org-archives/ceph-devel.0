From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: Re: RBD Utilization
Date: Wed, 23 Mar 2016 15:31:48 +0530
Message-ID: <CANA9Uk4cME1cmPfk+a1kJ0=3C9p6uCNFgXxahNvz53sTkL=KHA@mail.gmail.com>
References: <1674621217.33764396.1458725323072.JavaMail.zimbra@redhat.com>
	<807270756.33765380.1458725728050.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33642 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbcCWKBt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Mar 2016 06:01:49 -0400
Received: by mail-vk0-f41.google.com with SMTP id k1so12298393vkb.0
        for <ceph-devel@vger.kernel.org>; Wed, 23 Mar 2016 03:01:48 -0700 (PDT)
In-Reply-To: <807270756.33765380.1458725728050.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anmol Babu <anbabu@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Team discussions around SDS management program (aka USM or RHS
	Controller)" <sds-mgmt@redhat.com>

Try with:

ceph df       // will give better information on all pools used and
avail storage.

Thanks
Swami

On Wed, Mar 23, 2016 at 3:05 PM, Anmol Babu <anbabu@redhat.com> wrote:
> Hi,
>
> I would like to know how much of my storage is rbd consumed.
>
> Is there a way I can get this info using some command?
>
> Awaiting your valuable response.
>
> Thanks,
> Anmol
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
