From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: Re: Recommended btrfs mount options
Date: Thu, 05 Apr 2012 17:22:23 +0200
Message-ID: <4F7DB8AF.4020502@univ-nantes.fr>
References: <CAO47_-_V4d=3abABvqrV+muJ3cF-J-=-RQ748Vr+U=_ZdffZfw@mail.gmail.com> <Pine.LNX.4.64.1111221415280.11288@cobra.newdream.net> <or39dful05.fsf@livre.localdomain> <Pine.LNX.4.64.1111230704560.5214@cobra.newdream.net> <4F7D9679.5050006@univ-nantes.fr> <Pine.LNX.4.64.1204050809360.2059@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp-tls1.univ-nantes.fr ([193.52.101.145]:45904 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279Ab2DEPWY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Apr 2012 11:22:24 -0400
In-Reply-To: <Pine.LNX.4.64.1204050809360.2059@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Alexandre Oliva <oliva@lsd.ic.unicamp.br>, Christian Brunner <chb@muc.de>, ceph-devel@vger.kernel.org

Le 05/04/2012 17:11, Sage Weil a =E9crit :

> Yes, it's safe.  We fall back to a manual copy if we see EINVAL from =
the
> ioctl.
>
> sage

Great, thanks for the answer .


cheers,


--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
