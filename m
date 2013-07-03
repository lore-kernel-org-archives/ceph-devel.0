From: Ilya Storozhilov <Ilya_Storozhilov@epam.com>
Subject: HA: wip-libcephfs rebased and pulled up to v.65
Date: Wed, 3 Jul 2013 11:17:59 +0000
Message-ID: <941FC8BE87ADE64D90E4EB6CD554517710022A7C@EPBYMINSA0032.epam.com>
References: <515941372.160.1372801066160.JavaMail.root@thunderbeast.private.linuxbox.com>,<alpine.DEB.2.00.1307021616570.3375@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from evbyminsa0039.epam.com ([217.21.63.35]:10765 "EHLO
	EVBYMINSA0039.epam.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab3GCLXY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jul 2013 07:23:24 -0400
In-Reply-To: <alpine.DEB.2.00.1307021616570.3375@cobra.newdream.net>
Content-Language: ru-RU
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, "Matt W. Benjamin" <matt@linuxbox.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, aemerson <aemerson@linuxbox.com>, David Zafman <david.zafman@inktank.com>

Hi Sage,

Andrey has amended our changes according to you comments except one reg=
arding re-fetching xattrs from the MDS after setting or removal the ext=
ended attribute of the filesystem object, cause it just requires some r=
esources we do not have at the moment (Andrey is sick till Thursday) - =
you can check Andrey's commits here: https://github.com/ferustigris/cep=
h/commits/open_by_handle_api. Other staff, including xattrs unit tests =
have been implemented.

Does it possible to rebase our current changes on top of this and to im=
plement re-fetching of xattrs from MDS later, cause I suspect we are no=
t able to complete it till Monday?

Best regards,
Ilya
________________________________________
=EF=D4: Sage Weil [sage@inktank.com]
=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 3 =C9=C0=CC=D1 2013 =C7. 3:19
To: Matt W. Benjamin; Ilya Storozhilov
Cc: ceph-devel; aemerson; David Zafman
=F4=C5=CD=C1: Re: wip-libcephfs rebased and pulled up to v.65

Hi Matt,

On Tue, 2 Jul 2013, Matt W. Benjamin wrote:
> Hi Sage (et al),
>
> We have rebased the former wip-libcephfs branch, on the model of the
> rebased example branch, as planned, and also pulled it up to Ceph's
> v65 tag/master, also as planned.
>
> In addition to cross checking this, Adam has updated our Ganesha clie=
nt
> driver to use the ll v2 API, and this checks out.
>
> We've pushed wip-libcephfs-rebased-v65 to our public git repository,
> https://github.com/linuxbox2/linuxbox-ceph, for review.

I made a couple comments on github with small nits.  In the meantime, I=
'm
going to run this through our fs test suite.

Looks good!

Ilya, do you want to rebase your changes on top of this?  It would be
great to get both sets of changes in before the dumpling feature freeze
(Monday!).

Thanks!
sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
