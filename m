From: Anmol Babu <anbabu@redhat.com>
Subject: Re: RBD Utilization
Date: Wed, 23 Mar 2016 06:30:38 -0400 (EDT)
Message-ID: <1749699911.33776369.1458729038657.JavaMail.zimbra@redhat.com>
References: <1674621217.33764396.1458725323072.JavaMail.zimbra@redhat.com> <807270756.33765380.1458725728050.JavaMail.zimbra@redhat.com> <CANA9Uk4cME1cmPfk+a1kJ0=3C9p6uCNFgXxahNvz53sTkL=KHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:53033 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbcCWKak (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Mar 2016 06:30:40 -0400
In-Reply-To: <CANA9Uk4cME1cmPfk+a1kJ0=3C9p6uCNFgXxahNvz53sTkL=KHA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: M Ranga Swami Reddy <swamireddy@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Team discussions around SDS management program (aka USM or RHS
	Controller)" <sds-mgmt@redhat.com>

No ceph df gives utilizations of all pools right?

Although the default rbd pool has the name rbd, there's no restriction and/or indication to suggest a pool as containing block devices right?

So, I wanted a command or a way in general to find the space occupied by rbd's in the cluster

Thanks,
Anmol

----- Original Message -----
From: "M Ranga Swami Reddy" <swamireddy@gmail.com>
To: "Anmol Babu" <anbabu@redhat.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "Team discussions around SDS management program (aka USM or RHS Controller)" <sds-mgmt@redhat.com>
Sent: Wednesday, March 23, 2016 3:31:48 PM
Subject: Re: RBD Utilization

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
