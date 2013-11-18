From: Noah Watkins <noah.watkins@inktank.com>
Subject: RFC: object operation instruction set
Date: Sun, 17 Nov 2013 18:37:20 -0800
Message-ID: <BC963CDE-A36F-42EE-AC7D-6638D878BBCD@inktank.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:38274 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924Ab3KRChY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Nov 2013 21:37:24 -0500
Received: by mail-pb0-f52.google.com with SMTP id wy17so4879436pbc.11
        for <ceph-devel@vger.kernel.org>; Sun, 17 Nov 2013 18:37:23 -0800 (PST)
Received: from [192.168.1.113] (c-50-131-197-174.hsd1.ca.comcast.net. [50.131.197.174])
        by mx.google.com with ESMTPSA id hu10sm19762229pbc.11.2013.11.17.18.37.21
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Nov 2013 18:37:22 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>

The ObjectOperation interface in librados is great for performing compo=
und atomic operations. However, it doesn=92t seem to be capable of expr=
essing more complex flows. Consider the following set of operations tha=
t I one might want to run atomically to optionally initialize an xattr:

   int ret =3D getxattr(=93foo=94)
   if (ret < 0 && ret !=3D -ENODATA)
     return ret;

   if (ret =3D=3D -ENODATA)
     /* do some initialization */
   else
     /* do something else */

As it stands, one would need to build a cls_xyz to do this. Alternative=
ly, something like cls_lua could be used, but there is a lot of downsid=
es to that. However, after building several cls_xyz modules, it is clea=
r that the majority of the time is spent doing basic logic, moving some=
 data around, and occasionally doing something like incrementing some c=
ounters.

I=92ve put a prototype solution up in github

    `github.com/ceph/ceph.git obj_op_virt_machine`

that adds control instructions into the ObjectOperation interface. Usin=
g the interface I can express the above logic as follows:

   ObjectReadOperation op;

   // foo doesn=92t exist. the return value
   // will be placed into a named register =93ret"
   op.getxattr(=93foo=94, bl, NULL);

   // jump to label if =93ret=94 register >=3D 0
   op.ois_jge(=93ret=94, 0, =93has_attr=94);=20

   // jump to label if =93ret=94 register =3D=3D 0
   op.ois_jeq(=93ret=94, -ENODATA, =93no_attr=94);

   // fall through to return any error in the
   // =93ret=94 register. returns immediately
   op.ois_ret(=93ret=94);

   // define a label target
   op.ois_label(=93has_attr=94);
   /* =85 do some stuff =85 */
   op.ois_ret(0);

  // defines a label target
  op.ois_label(=93no_attr=94);
  /* =85 do initialization =85 */
  op.ois_ret(0);

  ioctx.operate(=93obj=94, &op);

Using only a few instructions, we can get pretty good building blocks. =
Adding a few to examine some data in primitive ways would add another l=
evel of usefulness, too (e.g. atomic counter increment). And, this can =
also be made safe by ensuring that jumps are always forward, removing a=
ny problems like infinite loops.

- Noah--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
