From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH]  fs/ceph: make logical calculation functions return bool
Date: Sat, 26 Mar 2016 00:39:36 +0000
Message-ID: <20160326003936.GL17997@ZenIV.linux.org.uk>
References: <1458886795-10694-1-git-send-email-zhangzhuoyu@cmss.chinamobile.com>
 <7341F3B8-5F38-4D4C-A373-8DDD6472FC23@redhat.com>
 <000601d18672$4da04d80$e8e0e880$@cmss.chinamobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:39519 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbcCZAjm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Mar 2016 20:39:42 -0400
Content-Disposition: inline
In-Reply-To: <000601d18672$4da04d80$e8e0e880$@cmss.chinamobile.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhang Zhuoyu <zhangzhuoyu@cmss.chinamobile.com>
Cc: "'Yan, Zheng'" <zyan@redhat.com>, 'Ceph Development' <ceph-devel@vger.kernel.org>, 'Sage Weil' <sage@redhat.com>, idryomov@gmail.com, linux-kernel@vger.kernel.org

On Fri, Mar 25, 2016 at 04:42:45PM +0800, Zhang Zhuoyu wrote:
> > This one is for ilookup5.  ilookup5() wants function pointer "int (=
*test)(struct
> > inode *, void *)=E2=80=9D.  The rest change looks good.
> >=20
> > Regards
> > Yan, Zheng
> >=20
>=20
> Yes, you are right, I will send another version.

=2E.. as long as that another version does not try to switch the callba=
ck type
of ilookup5/iget5_locked/etc argument.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
