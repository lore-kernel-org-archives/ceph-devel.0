From: Jaze Lee <jazeltq@gmail.com>
Subject: [devops] the service can not start correctly
Date: Mon, 9 May 2016 14:54:09 +0800
Message-ID: <CAKZcxgcjKju=BtbAL-9dFmRSYvv0hHk-D5=n0n=sfrxb80_+NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37792 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbcEIGyK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 May 2016 02:54:10 -0400
Received: by mail-ig0-f177.google.com with SMTP id s8so84739679ign.0
        for <ceph-devel@vger.kernel.org>; Sun, 08 May 2016 23:54:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi all
   I test openstack/puppet-ceph to install ceph-10.2.0 and find that,
when the mon can not start correctly.

   The puppet agent says that

 Error: Could not start Service[ceph-mon-study-4]: Execution of
'service ceph start mon.study-4' returned 6: Redirecting to
/bin/systemctl start  mon.study-4 ceph.service



The command 'service ceph start mon.study-4' maps to 'systemctl start
mon.study-4 ceph.service'
I think here should be systemctl start ceph-mon@study-4.

May be the way i use puppet-ceph is not properly. If not, i think we
should add some code
to use systemctl directly rather than use the 'service start ....'.

The code is here
https://github.com/openstack/puppet-ceph/blob/master/manifests/mon.pp#L=
90


Thank a lot.



--=20
=E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
