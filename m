From: Jaze Lee <jazeltq@gmail.com>
Subject: [ceph-deploy] Can not get the admin keys
Date: Mon, 21 Mar 2016 11:22:08 +0800
Message-ID: <CAKZcxgffMJ1wrPd6xQFcM9Ou4pgVJj6wY2nQFra68N_GF+fuwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:34653 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbcCUDWJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 20 Mar 2016 23:22:09 -0400
Received: by mail-ig0-f173.google.com with SMTP id av4so76215788igc.1
        for <ceph-devel@vger.kernel.org>; Sun, 20 Mar 2016 20:22:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi all,
   i found that i can not get the admin keys in ceph-deploy.
   At last i found this
 [Unit]
Description=3DCeph cluster key creator task

# the last key created is the mds bootstrap key -- look for that.
ConditionPathExists=3D!/var/lib/ceph/bootstrap-mds/ceph.keyring

in ceph-create-keys@service.
After remove the ceph.keyring in /var/lib/ceph/bootstrap-mds, i can
use ceph-deploy mon create to get the right ceph.client.admin.keyring.

I do not why the-create-keys depend on that condition.

   Thanks all.


--=20
=E8=B0=A6=E8=B0=A6=E5=90=9B=E5=AD=90
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
