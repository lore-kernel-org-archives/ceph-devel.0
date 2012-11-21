From: =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>
Subject: Re: [Openstack] Ceph + Nova
Date: Wed, 21 Nov 2012 10:03:48 +0100
Message-ID: <CAOLwVU=114PncjQ_DNUrfVfRaP=9q02vTMtBwxuuA1VhWjcfiw@mail.gmail.com>
References: <CAGXO4kxPoxbJkZw57npn79e6TD5VByyXinh5vd8_JSSKb29MVw@mail.gmail.com>
 <CAGXO4kz-SZPHZp5aAFk4P4FFvK36qxNNX7D0wXtnqMLX3WCsKw@mail.gmail.com>
 <CAGXO4kwdNMuB4FRC2fgg2kHeo_zrGP66iLgCg2QaygqYOLS9cA@mail.gmail.com>
 <CACxfpGec2drEvAK+83cG1TEVQwMOg1P-7emU2zp9iX7VKORybg@mail.gmail.com>
 <CAGXO4kye1z8ymvdu=m+c8AwgEk6TU87S2iLoiJQYJLwrWrn8gA@mail.gmail.com>
 <CAGXO4kwDtmD5Jr_gGDocB8C-e90MHCONCnTAM5Lqp2nVgSKMnw@mail.gmail.com> <CAGXO4kywgFO1yEzSU56HBD2_GN856JwFshYc7+5com3t0cnfcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:43046 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab2KUJEK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Nov 2012 04:04:10 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so2630491lag.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Nov 2012 01:04:08 -0800 (PST)
In-Reply-To: <CAGXO4kywgFO1yEzSU56HBD2_GN856JwFshYc7+5com3t0cnfcA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?JuanFra_Rodr=EDguez_Cardoso?= <juanfra.rodriguez.cardoso@gmail.com>
Cc: Openstack <openstack@lists.launchpad.net>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I don't think it's the best place to ask your question since it's not
directly related to OpenStack but more about Ceph. I just put in c/c
the ceph ML. Anyway, CephFS is not ready yet for production but I
heard that some people use it. People from Inktank (the company behind
Ceph) don't recommend it, AFAIR they expect something more production
ready for Q2 2013. You can use it (I did, for testing purpose) but
it's at your own risk.
Beside of this RBD and RADOS are robust and stable now, so you can go
with the Cinder and Glance integration without any problems.

Cheers!

On Wed, Nov 21, 2012 at 9:37 AM, JuanFra Rodr=EDguez Cardoso
<juanfra.rodriguez.cardoso@gmail.com> wrote:
> Hi everyone:
>
> I'd like to know your opinion as nova experts:
>
> Would you recommend CephFS as shared storage in /var/lib/nova/instanc=
es?
> Another option it would be use GlusterFS or MooseFS for
> /var/lib/nova/instances directory and Ceph RBD for Glance and Nova vo=
lumes,
> don't you think?
>
> Thanks for your attention.
>
> Best regards,
> JuanFra
>
> _______________________________________________
> Mailing list: https://launchpad.net/~openstack
> Post to     : openstack@lists.launchpad.net
> Unsubscribe : https://launchpad.net/~openstack
> More help   : https://help.launchpad.net/ListHelp
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
